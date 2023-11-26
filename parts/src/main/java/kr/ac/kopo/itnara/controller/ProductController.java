package kr.ac.kopo.itnara.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Search;
import kr.ac.kopo.itnara.model.Category;
import kr.ac.kopo.itnara.security.CustomUserDetails;
import kr.ac.kopo.itnara.service.ProductService;
import kr.ac.kopo.itnara.service.StoreService;

@Controller
@RequestMapping("/products")
public class ProductController {

	@Autowired
	ProductService service;

	@Autowired
	StoreService storeService;

	private String path = "/products";

	@GetMapping("/list")
	String list(Model model, Search search) {
		List<Product> list = service.list(search);
		model.addAttribute("list", list);
		return path + "/list";
	}

	@GetMapping("/new")
	String newProduct(Model model, Authentication authentication) {
		service.cacheImageDelete(authentication);
		List<Category> categoryList = service.category();
		model.addAttribute("category", categoryList);
		return path + "/new";
	}

	@PostMapping("/new")
	String add(Product item, List<MultipartFile> uploadFile, Authentication authentication) {

		if (isAuthenticated()) {
			service.add(item, authentication);

			return "redirect:/";
		}
		return "/auth/login";

	}



	private boolean isAuthenticated() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
			return false;
		}
		return authentication.isAuthenticated();
	}
}
