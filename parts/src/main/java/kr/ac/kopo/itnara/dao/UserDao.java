package kr.ac.kopo.itnara.dao;

import kr.ac.kopo.itnara.model.User;
import kr.ac.kopo.itnara.model.UserInfo;
import kr.ac.kopo.itnara.security.CustomUserDetails;

public interface UserDao {

	void add(User item);

	CustomUserDetails getUserInfo(String name);

	UserInfo getUserInfo(Long userId);


}
