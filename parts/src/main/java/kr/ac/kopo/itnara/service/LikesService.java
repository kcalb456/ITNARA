package kr.ac.kopo.itnara.service;



import java.util.Map;

import org.springframework.security.core.Authentication;

import kr.ac.kopo.itnara.model.Likes;

public interface LikesService {

	Likes thiPckd(Long productId);

	void likeSet(Map<String, Object> requestBody, Authentication authentication);

}
