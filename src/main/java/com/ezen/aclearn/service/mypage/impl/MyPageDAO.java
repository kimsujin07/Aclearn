package com.ezen.aclearn.service.mypage.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.aclearn.vo.UserVO;

@Repository
public class MyPageDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int checkCurrentPw(String userId, String userPw) {
		UserVO checkUser = new UserVO();
		checkUser.setUserId(userId);
		checkUser.setUserPw(userPw);
		
		return mybatis.selectOne("MypageDAO.checkCurrentPw", checkUser);
	}
	
	public UserVO getChangedUserInfo(String userId) {
		return mybatis.selectOne("MypageDAO.getChangedUserInfo", userId);
		
	}

	public void quitUser(String userId) {
		mybatis.update("MypageDAO.quitUser", userId);
		
	}
	
}
