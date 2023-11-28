package kr.ac.kopo.itnara.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.ac.kopo.itnara.model.CacheImage;
import kr.ac.kopo.itnara.model.Category;
import kr.ac.kopo.itnara.model.Likes;
import kr.ac.kopo.itnara.model.Order;
import kr.ac.kopo.itnara.model.Post;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Search;
import kr.ac.kopo.itnara.model.Store;
import kr.ac.kopo.itnara.model.UserInfo;
import kr.ac.kopo.itnara.security.CustomUserDetails;
import kr.ac.kopo.itnara.service.ForumService;
import kr.ac.kopo.itnara.service.LikesService;
import kr.ac.kopo.itnara.service.OrderService;
import kr.ac.kopo.itnara.service.ProductService;
import kr.ac.kopo.itnara.service.StoreService;
import kr.ac.kopo.itnara.service.UserService;

@RestController
@RequestMapping("/api")
public class ApiController {

	@Autowired
	ProductService productService;

	@Autowired
	StoreService storeService;

	@Autowired
	OrderService orderService;

	@Autowired
	UserService userService;

	@Autowired
	ForumService forumService;

	@Autowired
	LikesService likesService;

	private String uploadPath = "d:/upload/";

	@GetMapping("/category")
	public ResponseEntity<List<Category>> getCategory() {
		List<Category> categories = productService.category2();
		return new ResponseEntity<>(categories, HttpStatus.OK);
	}

	@GetMapping("/forum/list")
	public ResponseEntity<List<Post>> getForumList() {
		List<Post> Posts = forumService.getPostList();
		return new ResponseEntity<>(Posts, HttpStatus.OK);
	}

	@GetMapping(value = { "/store/{userId}", "/" })
	public ResponseEntity<Map<String, Object>> storeProductList(@PathVariable(required = false) Long userId,
			Search search) {
		Map<String, Object> response = new HashMap<>();

		Store item = storeService.item(userId);
		response.put("item", item);

		List<Product> list = productService.list(search);
		response.put("list", list);

		return new ResponseEntity<>(response, HttpStatus.OK);
	}

	@GetMapping("/newlist")
	public ResponseEntity<List<Product>> getProduct(Search search) {
		List<Product> products = productService.list(search);
		System.out.println(products.size());
		return new ResponseEntity<>(products, HttpStatus.OK);
	}

	@GetMapping("/product")
	public ResponseEntity<Map<String, Object>> getProduct(Authentication authentication, @RequestParam Long productId, Likes like) {
		Map<String, Object> responseMap = new HashMap<>();
		
		if (isAuthenticated()) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();	
			like.setUserId(userDetails.getUserId());
			Likes likes = likesService.thiPckd(like);			
			responseMap.put("likes", likes);
		}

		Product item = storeService.product(productId);
		
		responseMap.put("item", item);
		

		return new ResponseEntity<>(responseMap, HttpStatus.OK);
	}

	@PostMapping("/product/like")
	public ResponseEntity<?> likeSet(Authentication authentication, @RequestBody Map<String, Object> requestBody) {
		// 권한 확인: 사용자가 인증되었으며, 제공된 userId에 대한 권한이 있는지 확인합니다.

		if (isAuthenticated()) {

			likesService.likeSet(requestBody, authentication);

			return new ResponseEntity<>(HttpStatus.OK);
		} else {
			// 권한이 없는 경우: UNAUTHORIZED 상태로 응답합니다.
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
	}

	@GetMapping("/store/order")
	public ResponseEntity<List<Order>> getOrder(@RequestParam Long userId, Authentication authentication) {
		List<Order> list = new ArrayList<>();
		if (isAuthenticated() && isAuthorized(authentication, userId)) {
			list = orderService.list(userId);
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@GetMapping("/store/order/purchase")
	public ResponseEntity<List<Order>> getPurchaseOrder(@RequestParam Long userId, Authentication authentication) {
		List<Order> list = new ArrayList<>();
		if (isAuthenticated() && isAuthorized(authentication, userId)) {
			list = orderService.purchaseList(userId);
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	@GetMapping("/auth")
	public ResponseEntity<?> getAuthentication(Authentication authentication, UserInfo userInfo) {

		if (isAuthenticated()) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();

			userInfo = userService.getInfo(userDetails.getUserId());
			userInfo.setUserId(userDetails.getUserId());
			return new ResponseEntity<>(userInfo, HttpStatus.OK);
		}
		else
		{
			Map<String, Object> errorResponse = new HashMap<>();
	        errorResponse.put("error", "로그인에 실패하였습니다.");
	        return new ResponseEntity<>(errorResponse, HttpStatus.UNAUTHORIZED);	
		}
	}

	@DeleteMapping("/product/delete/{userId}")
	public ResponseEntity<String> deleteProduct(Authentication authentication, @PathVariable Long userId,
			@RequestParam Long productId) {
		// 권한 확인: 사용자가 인증되었으며, 제공된 userId에 대한 권한이 있는지 확인합니다.
		if (isAuthenticated() && isAuthorized(authentication, userId)) {
			// 삭제 수행: 서비스를 사용하여 상품을 삭제하고, 연결된 이미지 파일을 삭제합니다.
			List<ProductImage> images = storeService.delete(productId);
			for (ProductImage image : images) {
				File file = new File(uploadPath + image.getUuid() + "_" + image.getImageName());
				if (file.exists()) {
					file.delete();
				}
			}
			return ResponseEntity.ok("Product deleted successfully");
		} else {
			// 권한이 없는 경우: UNAUTHORIZED 상태로 응답합니다.
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized access");
		}
	}

	@PatchMapping("/store/order/tracking")
	public ResponseEntity<String> updateTrackingNumber(Authentication authentication, @RequestBody Order order) {
		// 권한 확인: 사용자가 인증되었으며, 제공된 userId에 대한 권한이 있는지 확인합니다.
		if (isAuthenticated() && isAuthorized(authentication, order.getUserId())) {
			// 운송장번호 업데이트
			orderService.updateTracking(order);
			return ResponseEntity.ok("tracking number update successfully");
		} else {
			// 권한이 없는 경우: UNAUTHORIZED 상태로 응답합니다.
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized access");
		}
	}

	@PostMapping("/product/update")
	public ResponseEntity<String> productUpdate(Authentication authentication,
			@RequestPart("uploadFile") MultipartFile uploadFile, @RequestParam("productName") String productName,
			@RequestParam("productPrice") double productPrice, @RequestParam("productStock") int productStock,
			@RequestParam("productStatus") int productStatus, @RequestParam("productDetail") String productDetail,
			@RequestParam("userId") Long userId, @RequestParam("productId") Long productId,
			@ModelAttribute Product product) {
		// 권한 확인: 사용자가 인증되었으며, 제공된 userId에 대한 권한이 있는지 확인합니다.
		if (isAuthenticated() && isAuthorized(authentication, product.getUserId())) {

			storeService.update(product);

			System.out.println(product.getProductId());
			return ResponseEntity.ok("tracking number update successfully");
		} else {
			// 권한이 없는 경우: UNAUTHORIZED 상태로 응답합니다.
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized access");
		}
	}

	@DeleteMapping("/cache/delete")
	public ResponseEntity<?> cacheDelete(@RequestParam String imageName, Authentication authentication) {
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		String cacheFolderPath = "d:/cachePath/" + userDetails.getUserId() + "/";
		if (isAuthenticated()) {
			File file = new File(cacheFolderPath + imageName);
			if (file.exists()) {
				file.delete();
			}
			return ResponseEntity.ok("이미지 삭제 성공");
		}
		return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	}

	@PostMapping("/cache")
	public ResponseEntity<?> cache(Authentication authentication,
			@RequestPart("uploadFile") List<MultipartFile> uploadFile, @RequestParam("userId") long userId) {
		// 권한 확인: 사용자가 인증되었으며, 제공된 userId에 대한 권한이 있는지 확인합니다.

		if (isAuthenticated()) {
			List<CacheImage> images = new ArrayList<CacheImage>();
			for (MultipartFile file : uploadFile) {
				if (file.isEmpty()) {
					continue;
				}
				String filename = file.getOriginalFilename();
				String uuid = UUID.randomUUID().toString();

				try {

					String cachePath = "d:/cachePath/" + userId + "/";
					file.transferTo(new File(cachePath + uuid + "_" + filename));

					CacheImage img = new CacheImage();
					img.setImageName(filename);
					img.setUuid(uuid);
					img.setUserId(userId);
					images.add(img);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return new ResponseEntity<>(images, HttpStatus.OK);
		} else {
			// 권한이 없는 경우: UNAUTHORIZED 상태로 응답합니다.
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		}
	}

	// 권한 확인 메서드: 사용자가 인증되었는지 확인합니다.
	private boolean isAuthenticated() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
			return false;
		}
		return authentication.isAuthenticated();
	}

	// 사용자 권한 확인 메서드: 현재 사용자가 제공된 userId에 대한 권한이 있는지 확인합니다.
	private boolean isAuthorized(Authentication authentication, Long userId) {
		if (authentication.getPrincipal() instanceof CustomUserDetails) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			// 현재 사용자의 ID와 제공된 userId를 비교하여 권한을 확인합니다.
			return userId.equals(userDetails.getUserId());
		}
		// CustomUserDetails가 아닌 경우 권한이 없음을 반환합니다.
		return false;
	}
}
