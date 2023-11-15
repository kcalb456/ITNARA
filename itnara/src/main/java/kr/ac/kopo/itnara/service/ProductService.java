package kr.ac.kopo.itnara.service;

import java.util.List;


import kr.ac.kopo.itnara.model.Product;

public interface ProductService {

	List<Product> list();

	void add(Product item);

}
