package kr.ac.kopo.itnara.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import kr.ac.kopo.itnara.dao.UserDao;
import kr.ac.kopo.itnara.model.User;
import kr.ac.kopo.itnara.model.UserInfo;

@Service
public class UserServiceImple implements UserService {

	@Autowired
	UserDao dao;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Override
	public void Register(User item) {
		// TODO Auto-generated method stub
		System.out.println("Befor Encoder : " + item.getPasswd());
		String encodedPassword = bcryptPasswordEncoder.encode(item.getPasswd());
		System.out.println("After Encoder : " + encodedPassword);
		System.out.println("Resister User Info : " + item);

		item.setPasswd(encodedPassword);

		dao.add(item);
	}

	@Override
	public UserInfo getInfo(Long userId) {
		// TODO Auto-generated method stub
		return dao.getUserInfo(userId);
	}





}
