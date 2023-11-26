package kr.ac.kopo.itnara.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.itnara.dao.ForumDao;
import kr.ac.kopo.itnara.model.Post;

@Service
public class ForumServiceImple implements ForumService {
	
	@Autowired
	ForumDao dao;

	@Override
	public List<Post> getPostList() {
		// TODO Auto-generated method stub
		return dao.getPostList();
	}

}
