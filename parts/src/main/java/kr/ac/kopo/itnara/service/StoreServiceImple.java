package kr.ac.kopo.itnara.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.kopo.itnara.dao.ProductDao;
import kr.ac.kopo.itnara.dao.StoreDao;
import kr.ac.kopo.itnara.model.Order;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
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
		productDao.addView(productId);
		return dao.product(productId);
	}

	@Override
	public List<ProductImage> delete(Long productId) {
		// TODO Auto-generated method stub
		Product item = dao.product(productId);
		System.out.println(item.getImages());
		productDao.delete(productId);
		return item.getImages();

	}

	@Override
	public void update(Product item) {
		// TODO Auto-generated method stub
		productDao.update(item);
	}

	@Transactional
	@Override
	public void order(Order order) {
		// TODO Auto-generated method stub
		Product product = new Product();
		product.setProductId(order.getProductId());
		product.setSoldCheck(1);
		productDao.soldCheckUpdate(product);
		dao.order(order);
	}

	@Override
	public List<Product> soldOrderList(Long userId) {
		return productDao.soldOrderList(userId);
	}

}
