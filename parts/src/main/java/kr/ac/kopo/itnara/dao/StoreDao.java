package kr.ac.kopo.itnara.dao;

import java.util.List;

import kr.ac.kopo.itnara.model.Order;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.Store;

public interface StoreDao {

	Store item(Long userId);

	List<Product> list(Long userId);

	Product product(Long productId);

	void order(Order order);

}
