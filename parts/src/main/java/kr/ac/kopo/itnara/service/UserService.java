package kr.ac.kopo.itnara.service;



import kr.ac.kopo.itnara.model.User;
import kr.ac.kopo.itnara.model.UserInfo;

public interface UserService {

	void Register(User item);

	UserInfo getInfo(Long userId);


}
