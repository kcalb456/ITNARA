package kr.ac.kopo.itnara.dao;

import java.util.List;

import kr.ac.kopo.itnara.model.Category1;
import kr.ac.kopo.itnara.model.Category2;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;

public interface ProductDao {

	List<Product> list();

	void add(Product item);

	void add(ProductImage image);

	List<Category1> category1List();

	List<Category2> category2List();

}
