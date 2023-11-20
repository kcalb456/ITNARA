package kr.ac.kopo.itnara.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.kopo.itnara.model.Category;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.Store;
import kr.ac.kopo.itnara.service.ProductService;
import kr.ac.kopo.itnara.service.StoreService;


@RestController
@RequestMapping("/api")
public class ApiController {
	
	@Autowired
	ProductService productService;
	
	@Autowired
	StoreService storeService;
	
	@GetMapping("/category")
	public ResponseEntity<List<Category>> getCategory() {
	    List<Category> categories = productService.category2();
	    return new ResponseEntity<>(categories, HttpStatus.OK);
	}
	
	
	@GetMapping(value = { "/store/{userId}", "/" })
    public ResponseEntity<Map<String, Object>> storeProductList(@PathVariable(required = false) Long userId) {
        Map<String, Object> response = new HashMap<>();

        Store item = storeService.item(userId);
        response.put("item", item);

        List<Product> list = storeService.list(userId);
        response.put("list", list);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
