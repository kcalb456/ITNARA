package kr.ac.kopo.itnara.service;

import java.util.List;

import kr.ac.kopo.itnara.model.Category1;
import kr.ac.kopo.itnara.model.Category2;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.Search;

public interface ProductService {

	List<Product> list(Search search);

	void add(Product item);

	List<Category1> category1List();

	List<Category2> category2List();

}
