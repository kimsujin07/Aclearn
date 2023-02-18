package com.ezen.aclearn.service.mypage;

import com.ezen.aclearn.vo.UserVO;

public interface MyPageService {
	String checkCurrentPw(String userId, String userPw);
	
	UserVO getChangedUserInfo(String userId);

	void quitUser(String userId);
}
