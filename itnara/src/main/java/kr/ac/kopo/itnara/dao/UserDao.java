package kr.ac.kopo.itnara.dao;

import kr.ac.kopo.itnara.model.User;
import kr.ac.kopo.itnara.security.CustomUserDetails;

public interface UserDao {

	void add(User item);

	CustomUserDetails getUserInfo(String name);


}
