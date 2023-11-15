package kr.ac.kopo.itnara.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.Store;
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

	


	@GetMapping("/{userId}/{productId}")
	String Detail(@PathVariable Long userId, @PathVariable Long productId) {
		return path + "detail";
	}
}
