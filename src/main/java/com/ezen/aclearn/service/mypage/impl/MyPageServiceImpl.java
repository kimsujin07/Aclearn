package com.ezen.aclearn.service.mypage.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.aclearn.service.mypage.MyPageService;
import com.ezen.aclearn.vo.UserVO;

@Service
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private MyPageDAO myPageDAO;
	
	@Override
	public String checkCurrentPw(String userId, String userPw) {
		int userCnt = myPageDAO.checkCurrentPw(userId, userPw);
		String checkResult = "";
		
		if(userCnt >= 1) {
			checkResult = "checkOk";
		} else {
			checkResult = "checkFail";
		}
		
		return checkResult;
	}
	
	@Override
	public UserVO getChangedUserInfo(String userId) {
		return myPageDAO.getChangedUserInfo(userId);
	}

	@Override
	public void quitUser(String userId) {
		myPageDAO.quitUser(userId);
		
	}
}
