package kr.ac.kopo.itnara.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.itnara.model.Post;

@Repository
public class ForumDaoImple implements ForumDao {
	
	@Autowired
	SqlSession sql;

	@Override
	public List<Post> getPostList() {
		// TODO Auto-generated method stub
		return sql.selectList("forum.list");
	}

}
