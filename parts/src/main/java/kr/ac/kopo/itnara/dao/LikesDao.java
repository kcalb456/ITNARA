package kr.ac.kopo.itnara.dao;

import kr.ac.kopo.itnara.model.Likes;

public interface LikesDao {

	Likes thiPckd(Long productId);

	void like(Likes likes);

	void unlike(Likes likes);


}
