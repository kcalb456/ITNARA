package kr.ac.kopo.itnara.dao;

import java.util.List;

import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;

public interface ProductDao {

	List<Product> list();

	void add(Product item);

	void add(ProductImage image);

}
