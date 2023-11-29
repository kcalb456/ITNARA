package kr.ac.kopo.itnara.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.kopo.itnara.model.Category1;
import kr.ac.kopo.itnara.model.Order;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.security.CustomUserDetails;
import kr.ac.kopo.itnara.service.ProductService;
import kr.ac.kopo.itnara.service.StoreService;

@Controller
@RequestMapping("/store")
public class StoreController {

	@Autowired
	StoreService service;

	@Autowired
	ProductService productService;

	private String path = "store/";
	private String uploadPath = "d:/upload/";

	@GetMapping(value = { "/{userId}", "/" })
	String list() {
		return path + "products";
	}

	@GetMapping("/{userId}/{productId}/update")
	String update(@PathVariable Long userId, @PathVariable Long productId, Authentication authentication, Model model,
			Product item) {

		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		if (isAuthenticated() && userId == userDetails.getUserId()) {

			List<Category1> categoryList = productService.category();
			model.addAttribute("category", categoryList);
			item = service.product(productId);
			model.addAttribute("item", item);
			productService.cacheImageDelete(authentication);
			productService.uploadedDupleToCache(item.getImages(), authentication);
			return path + "product/update";

		}
		return "redirect:/";
	}


	@GetMapping("/{userId}/{productId}/order")
	String order(@PathVariable Long productId, Model model, Product item) {
		if (isAuthenticated()) {
			System.out.println(productId);
			item = service.product(productId);
			model.addAttribute("item", item);
			return path + "product/order";
		}
		return "redirect:/auth/login";
	}

	@PostMapping("/{userId}/{productId}/order")
	String order(Order order, Authentication authentication, @PathVariable Long userId, @PathVariable Long productId) {
		CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
		order.setUserId2(user.getUserId());
		order.setUserId(userId);
		order.setProductId(productId);
		service.order(order);
		return "redirect:/";
	}

	@GetMapping("/{userId}/{productId}")
	String Detail(@PathVariable Long productId, Model model) {
		return path + "detail";
	}

	private boolean isAuthenticated() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
			return false;
		}
		return authentication.isAuthenticated();
	}
}
