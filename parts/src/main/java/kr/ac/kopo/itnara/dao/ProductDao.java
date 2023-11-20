package kr.ac.kopo.itnara.dao;

import java.util.List;

import kr.ac.kopo.itnara.model.Category;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Search;

public interface ProductDao {

	List<Product> list(Search search);

	void add(Product item);

	void add(ProductImage image);

	List<Category> category();

	void delete(Long productId);

	List<Category> category2();

	void update(Product item);

	void soldCheckUpdate(Product product);



}
