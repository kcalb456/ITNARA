package kr.ac.kopo.itnara.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.kopo.itnara.model.Category;
import kr.ac.kopo.itnara.service.ProductService;


@RestController
@RequestMapping("/api")
public class ApiController {
	
	@Autowired
	ProductService service;
	
	@PostMapping("/category")
	List<Category> category() {
		return service.category2();
	}
}
