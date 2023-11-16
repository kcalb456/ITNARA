package kr.ac.kopo.itnara.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
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
	String Detail(@PathVariable Long productId, Model model) {
		
		Product item = service.product(productId);
		List<ProductImage> Image = item.getImages();
		System.out.println(Image.get(0).getImageName());
		model.addAttribute("product",item);
		
		return path + "detail";
	}
}
