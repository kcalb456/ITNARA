package kr.ac.kopo.itnara.dao;

import java.util.List;

import kr.ac.kopo.itnara.model.Order;

public interface OrderDao {

	List<Order> list(Long userId);

	List<Order> purchaseList(Long userId);

	void updateTracking(Order order);

}
