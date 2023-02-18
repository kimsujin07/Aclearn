package com.ezen.aclearn.service.user;

import com.ezen.aclearn.vo.UserVO;

public interface UserService {
	// 회원가입
	int join(UserVO userVO);
	
	// 로그인
	UserVO login(UserVO userVO);
	
	// 아이디 중복체크
	int idCheck(String userId);
	
	// 아이디 찾기
	String searchId(UserVO searchVO);
		
	// 비밀번호 찾기
	String searchPw(UserVO searchVO);
	
	// 닉네임
	int nicknameCheck(String userNickname);
	
	// 마이페이지 
	int updateMyInfo(UserVO userVO);
	
}
