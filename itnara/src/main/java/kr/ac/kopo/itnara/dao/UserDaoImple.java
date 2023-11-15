package kr.ac.kopo.itnara.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import kr.ac.kopo.itnara.model.User;
import kr.ac.kopo.itnara.security.CustomUserDetails;

@Repository
public class UserDaoImple implements UserDao {

	@Autowired
	SqlSession sql;

	@Override
	public void add(User item) {
		sql.insert("user.add", item);
		sql.insert("user.add_store", item);
	}

	@Override
	public CustomUserDetails getUserInfo(String name) {
		// TODO Auto-generated method stub
		return sql.selectOne("user.info",name);
	}


}
