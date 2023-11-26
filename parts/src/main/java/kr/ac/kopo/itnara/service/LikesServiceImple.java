package kr.ac.kopo.itnara.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import kr.ac.kopo.itnara.dao.LikesDao;
import kr.ac.kopo.itnara.model.Likes;
import kr.ac.kopo.itnara.security.CustomUserDetails;

@Service
public class LikesServiceImple implements LikesService {

	@Autowired
	LikesDao dao;

	@Override
	public Likes thiPckd(Likes like) {
		// TODO Auto-generated method stub
		return dao.thiPckd(like);
	}

	@Override
	public void likeSet(Map<String, Object> requestBody, Authentication authentication) {
		// TODO Auto-generated method stub

		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();

		
		System.out.println("2222");
		
		Likes likes = new Likes();
		
		System.out.println(requestBody.get("productId"));
		
		likes.setProductId(Long.parseLong((String) requestBody.get("productId")));
		likes.setUserId(userDetails.getUserId());

		System.out.println(likes.getProductId() + "_" + likes.getProductId());

		if (requestBody.get("LikeStatus") == null) {

			dao.like(likes);
		} else {
			dao.unlike(likes);
		}

	}

}
