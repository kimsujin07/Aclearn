package com.ezen.aclearn.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.aclearn.service.mypage.MyPageService;
import com.ezen.aclearn.service.user.UserService;
import com.ezen.aclearn.vo.LctrVO;
import com.ezen.aclearn.vo.UserVO;

@Controller
@RequestMapping("/user")
public class MyPageController {
	@Autowired
	private MyPageService mypageService;
	@Autowired
	private UserService userService;
	
	// 마이페이지 화면으로 이동
	@RequestMapping(value="/mypage.do", method = RequestMethod.GET)
	public String mypageUpdateView() throws Exception{
		
		// WEB-INF/views/user/mypage.jsp
		return "user/mypage";
	}
	
	// 마이페이지 - 회원정보 수정 
	@RequestMapping(value="/updateMyInfo.do", method = RequestMethod.POST)
	public String updateMyInfo(UserVO userVO, HttpSession session, 
			HttpServletRequest request, Model model) throws Exception{
		
		int result = userService.updateMyInfo(userVO);
		
		if(result == 0) {
			model.addAttribute("msg", "editFail");
			return "user/mypage";
		}
		
		session.invalidate();
		
		session = request.getSession();
		
		//회원정보 가져오기
		UserVO userInfo = mypageService.getChangedUserInfo(userVO.getUserId());
		
		//가져온 회원정보로 세션 재등록
		session.setAttribute("loginUser", userInfo);
		
		model.addAttribute("msg", "editOk");
		
		return "user/mypage";
	}
	
	
	
	//현재 비밀번호 체크
	@PostMapping("/checkCurrentPw.do")
	@ResponseBody
	public String checkCurrentPw(@RequestParam("userId") String userId, 
			@RequestParam("userPw") String userPw) {
		String checkResult = mypageService.checkCurrentPw(userId, userPw);
		
		return checkResult;
	}
	
	// 회원 탈퇴
	@RequestMapping("/quitUser.do")
	public String quitUser(@RequestParam("userId") String userId) {
		mypageService.quitUser(userId);
		
		return "redirect:/index.jsp";
	}
	
	// 나의 강의 목록
	public List getLctrList(LctrVO lctrVO) {
		
		return null;
	}
}
