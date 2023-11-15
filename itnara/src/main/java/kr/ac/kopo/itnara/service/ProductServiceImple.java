package kr.ac.kopo.itnara.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.itnara.dao.ProductDao;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;


@Service
public class ProductServiceImple implements ProductService {
	
	@Autowired
	ProductDao dao;

	@Override
	public List<Product> list() {
		return dao.list();
	}



	@Override
	public void add(Product item) {
		// TODO Auto-generated method stub
		dao.add(item);
		
		for(ProductImage image : item.getImages()) {
			image.setProductId(item.getProductId());
			dao.add(image);
		}
	}

}
