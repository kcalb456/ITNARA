package kr.ac.kopo.itnara.service;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

import kr.ac.kopo.itnara.model.Category1;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Search;

public interface ProductService {

	List<Product> list(Search search);


	List<Category1> category();

	void add(Product item, Authentication authentication);


	void cacheImageDelete(Authentication authentication);


	void uploadedDupleToCache(List<ProductImage> list, Authentication authentication);


	void update(Product item, Authentication authentication);





}
