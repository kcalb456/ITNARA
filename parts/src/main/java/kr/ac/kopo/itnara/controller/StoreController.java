package kr.ac.kopo.itnara.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

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
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Store;
import kr.ac.kopo.itnara.security.CustomUserDetails;
import kr.ac.kopo.itnara.service.StoreService;

@Controller
@RequestMapping("/store")
public class StoreController {

	@Autowired
	StoreService service;

	private String path = "store/";

	@GetMapping(value = { "/{userId}", "/" })
	String list(@PathVariable(required = false) Long userId, Model model) {

		Store item = service.item(userId);
		model.addAttribute("item", item);

		List<Product> list = service.list(userId);

		model.addAttribute("list", list);
		return path + "products";

	}

	@GetMapping("/{userId}/{productId}/delete")
	String delete(@PathVariable Long userId, @PathVariable Long productId, Authentication authentication) {
		
		//비회원 및 상품 등록자와 로그인정보가 일치한 경우에만 처리되도록
		if (isAuthenticated()) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			if(userId == userDetails.getUserId())
			{
				service.delete(productId);
			}
		}
		return "redirect:/";
	}
	
	@GetMapping("/{userId}/{productId}/update")
	String update(@PathVariable Long userId, @PathVariable Long productId, Authentication authentication, Model model, Product item) {
		
		//비회원 및 상품 등록자와 로그인정보가 일치한 경우에만 처리되도록
		if (isAuthenticated()) {
			CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			if(userId == userDetails.getUserId())
			{
				item = service.product(productId);
				model.addAttribute("item",item);
				return path + "product/update";
			}
		}
		return "redirect:/";
	}

	@GetMapping("/{userId}/{productId}")
	String Detail(@PathVariable Long productId, Model model) {

		Product item = service.product(productId);
		model.addAttribute("product", item);

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
