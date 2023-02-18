package com.ezen.aclearn.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ezen.aclearn.service.lctr.LctrService;
import com.ezen.aclearn.vo.LctrVO;

@Controller
@RequestMapping("/main")
public class MainController {
	@Autowired
	private LctrService lctrService;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
/**
 * 메인페이지 ui 호출
 * parameter 
 * return 
 *  - /ACLearn/src/main/webapp/WEB-INF/views/main.jsp
 */	
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String main(Model model) {
		//메인페이지 필요한 데이터 가져오기
		//1. 강의리스트
		List<LctrVO> lctrList = lctrService.getMainLctrList();
		
//		for(LctrVO lctr : lctrList) {
//			System.out.println(lctr.toString());
//		}
		
		model.addAttribute("lctrList", lctrList);
		
		//2. 추천강의
		List<LctrVO> lctrSubList = lctrService.getSubLctrList();
		model.addAttribute("lctrSubList", lctrSubList);
		return "main/main";
	}
	
	

/**
 * 로그인 ui 호출 
 * parameter 
 *  - 
 * return 
 *  - /ACLearn/src/main/webapp/WEB-INF/views/login.jsp
 */
	/*
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login(Locale locale, Model model, HttpServletRequest request, HttpSession session) {
		//logger.info("Welcome home! The client locale is {}.", locale);
		
		
		return "login";
	}	
	*/
/**
 * 로그인 인증 
 * parameter 
 * return 
 */
	/*
	@RequestMapping(value = "/setLogin.do", method = RequestMethod.GET)
	public ModelAndView setLogin(Locale locale, Model model, HttpServletRequest request, HttpSession session) {
		//logger.info("Welcome home! The client locale is {}.", locale);
		ModelAndView mv = new ModelAndView();
		
		
		return mv;
	}	
	*/	

	//받아올거: search, lctrTitle, lctrDetail, lctrOriimg1, lctrCode 모두 lctrList에서 받아오기 
//	 @RequestMapping("/getLctrList.do") 
//	 public String getLctrList(Model model, @RequestParam Map<String, String> paramMap) {
//		List<LctrVO> lctrList = lctrService.getLctrList(paramMap);
//		
//		model.addAttribute("lctrList", lctrList);
//		model.addAttribute("searchKeyword", paramMap.get("searchKeyword"));
//			
//		return "lctr/getLctrList";
//	 }
//	 
//	 @RequestMapping("/getLctr.do")
//		public String getLctr(@RequestParam("lctrCode") int lctrCode, Model model) {
//			LctrVO lctr = lctrService.getLctr(lctrCode);
//			model.addAttribute("lctr", lctr);
//			
//			return "lctr/getLctr";
//		}
	 
	 
	
}
