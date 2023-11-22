package kr.ac.kopo.itnara.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.kopo.itnara.model.Category;
import kr.ac.kopo.itnara.model.Order;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Search;
import kr.ac.kopo.itnara.model.Store;
import kr.ac.kopo.itnara.security.CustomUserDetails;
import kr.ac.kopo.itnara.service.OrderService;
import kr.ac.kopo.itnara.service.ProductService;
import kr.ac.kopo.itnara.service.StoreService;

@RestController
@RequestMapping("/api")
public class ApiController {

	@Autowired
	ProductService productService;

	@Autowired
	StoreService storeService;

	@Autowired
	OrderService orderService;

	private String uploadPath = "d:/upload/";

	@GetMapping("/category")
	public ResponseEntity<List<Category>> getCategory() {
		List<Category> categories = productService.category2();
		return new ResponseEntity<>(categories, HttpStatus.OK);
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
		return new ResponseEntity<>(products, HttpStatus.OK);
	}

	@GetMapping("/product")
	public ResponseEntity<Product> getProduct(@RequestParam Long productId) {
		Product item = storeService.product(productId);
		return new ResponseEntity<>(item, HttpStatus.OK);
	}

	@GetMapping("/store/order")
	public ResponseEntity<Map<String, Object>> getOrder(@RequestParam Long userId, Authentication authentication) {
		List<Order> list = new ArrayList<>();
		List<Product> productList = new ArrayList<>();
		Map<String, Object> response = new HashMap<>();
		if (isAuthenticated() && isAuthorized(authentication, userId)) {
			list = orderService.list(userId);	
			productList = storeService.list(userId);
			
			
			response.put("orders", list);
			response.put("products", productList);
		}
		return new ResponseEntity<>(response, HttpStatus.OK);
	}

	@GetMapping("/auth")
	public ResponseEntity<CustomUserDetails> getAuthentication(Authentication authentication) {
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		return new ResponseEntity<>(userDetails, HttpStatus.OK);
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
	
	/*@PatchMapping("/store/order/tracking")
	public ResponseEntity<CustomUserDetails> getAuthentication(Authentication authentication) {
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
	}*/
	

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
