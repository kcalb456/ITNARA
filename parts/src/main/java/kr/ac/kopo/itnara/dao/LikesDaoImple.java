package kr.ac.kopo.itnara.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.itnara.model.Likes;

@Repository
public class LikesDaoImple implements LikesDao {
	
	@Autowired
	SqlSession sql;

	@Override
	public Likes thiPckd(Long productId) {
		// TODO Auto-generated method stub
		return sql.selectOne("likes.this",productId);
	}

	@Override
	public void like(Likes likes) {
		// TODO Auto-generated method stub
		sql.insert("likes.add",likes);
	}

	@Override
	public void unlike(Likes likes) {
		// TODO Auto-generated method stub
		sql.delete("likes.delete",likes);
	}

}
