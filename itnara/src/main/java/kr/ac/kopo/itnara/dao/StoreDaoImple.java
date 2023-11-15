package kr.ac.kopo.itnara.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.Store;

@Repository
public class StoreDaoImple implements StoreDao {
	
	@Autowired
	SqlSession sql;

	@Override
	public Store item(Long userId) {
		// TODO Auto-generated method stub
		return sql.selectOne("store.item", userId);
	}

	@Override
	public List<Product> list(Long userId) {
		// TODO Auto-generated method stub
		return sql.selectList("store.product", userId);
	}

	@Override
	public Store myStore(String name) {
		// TODO Auto-generated method stub
		return sql.selectOne("store.my",name);
	}

}
