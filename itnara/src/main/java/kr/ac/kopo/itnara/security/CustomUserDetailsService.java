package kr.ac.kopo.itnara.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import kr.ac.kopo.itnara.dao.UserDao;


@Component
public class CustomUserDetailsService implements UserDetailsService{
	
	@Autowired
	UserDao dao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		CustomUserDetails user = dao.getUserInfo(username);
		
		if(user == null) {
			throw new UsernameNotFoundException(username);
		}
		
		
		return user;
	}

}
