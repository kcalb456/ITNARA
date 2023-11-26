package kr.ac.kopo.itnara.service;

import java.util.List;

import org.springframework.security.core.Authentication;

import kr.ac.kopo.itnara.model.Category;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.Search;

public interface ProductService {

	List<Product> list(Search search);


	List<Category> category();

	List<Category> category2();

	void add(Product item, Authentication authentication);


	void cacheImageDelete(Authentication authentication);



}
