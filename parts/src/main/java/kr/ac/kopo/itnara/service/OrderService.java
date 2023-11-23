package kr.ac.kopo.itnara.service;

import java.util.List;

import kr.ac.kopo.itnara.model.Order;

public interface OrderService {

	List<Order> list(Long userId);

	List<Order> purchaseList(Long userId);

	void updateTracking(Order order);

}
