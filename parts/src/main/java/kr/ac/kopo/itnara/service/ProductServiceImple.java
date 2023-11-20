package kr.ac.kopo.itnara.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.kopo.itnara.dao.ProductDao;
import kr.ac.kopo.itnara.model.Category;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Search;


@Service
public class ProductServiceImple implements ProductService {
	
	@Autowired
	ProductDao dao;

	@Override
	public List<Product> list(Search search) {
		return dao.list(search);
	}


	@Transactional
	@Override
	public void add(Product item) {
		// TODO Auto-generated method stub
		dao.add(item);
		
		for(ProductImage image : item.getImages()) {
			image.setProductId(item.getProductId());
			dao.add(image);
		}
	}





	@Override
	public List<Category> category() {
		// TODO Auto-generated method stub
		return dao.category();
	}


	@Override
	public List<Category> category2() {
		// TODO Auto-generated method stub
		return dao.category2();
	}




}
