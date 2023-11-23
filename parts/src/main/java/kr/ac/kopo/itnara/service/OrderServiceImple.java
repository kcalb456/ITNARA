package kr.ac.kopo.itnara.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.itnara.dao.OrderDao;
import kr.ac.kopo.itnara.model.Order;

@Service
public class OrderServiceImple implements OrderService {
	@Autowired
	OrderDao dao;

	@Override
	public List<Order> list(Long userId) {
		// TODO Auto-generated method stub
		return dao.list(userId);
	}

	@Override
	public List<Order> purchaseList(Long userId) {
		// TODO Auto-generated method stub
		return dao.purchaseList(userId);
	}

	@Override
	public void updateTracking(Order order) {
		// TODO Auto-generated method stub
		dao.updateTracking(order);
	}

}
