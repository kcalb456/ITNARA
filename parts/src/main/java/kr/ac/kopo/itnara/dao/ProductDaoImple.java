package kr.ac.kopo.itnara.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.itnara.model.Category1;
import kr.ac.kopo.itnara.model.Category2;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Search;

@Repository
public class ProductDaoImple implements ProductDao {

	@Autowired
	SqlSession sql;

	@Override
	public List<Product> list(Search search) {
		System.out.println(search.getCategory1Code());
		return sql.selectList("product.list", search);
	}

	@Override
	public void add(Product item) {
		// TODO Auto-generated method stub
		System.out.println(item.toString());
		sql.insert("product.add", item);
	}

	@Override
	public void add(ProductImage image) {
		// TODO Auto-generated method stub
		sql.insert("product.add_image", image);
	}

	@Override
	public List<Category1> category1List() {
		// TODO Auto-generated method stub
		return sql.selectList("product.category1List");
	}

	@Override
	public List<Category2> category2List() {
		// TODO Auto-generated method stub
		return sql.selectList("product.category2List");
	}

	@Override
	public void delete(Long productId) {
		// TODO Auto-generated method stub
		sql.delete("product.delete",productId);
		
	}

}
