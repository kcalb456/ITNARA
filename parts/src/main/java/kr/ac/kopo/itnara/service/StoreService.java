package kr.ac.kopo.itnara.service;

import java.util.List;

import kr.ac.kopo.itnara.model.Order;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Store;

public interface StoreService {

	Store item(Long userId);

	List<Product> list(Long userId);

	Product product(Long productId);

	List<ProductImage> delete(Long productId);

	void update(Product item);

	void order(Order order);

	List<Product> soldOrderList(Long userId);



}
