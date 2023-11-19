package kr.ac.kopo.itnara.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.itnara.dao.ProductDao;
import kr.ac.kopo.itnara.dao.StoreDao;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.Store;

@Service
public class StoreServiceImple implements StoreService {
	@Autowired
	StoreDao dao;
	
	@Autowired
	ProductDao productDao;
	
	
	@Override
	public Store item(Long userId) {
		// TODO Auto-generated method stub
		return dao.item(userId);
	}


	@Override
	public List<Product> list(Long userId) {
		// TODO Auto-generated method stub
		return dao.list(userId);
	}


	@Override
	public Product product(Long productId) {
		// TODO Auto-generated method stub
		return dao.product(productId);
	}


	@Override
	public void delete(Long productId) {
		// TODO Auto-generated method stub
		productDao.delete(productId);
		
	}





}
