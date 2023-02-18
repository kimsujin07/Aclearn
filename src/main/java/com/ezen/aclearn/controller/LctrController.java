package com.ezen.aclearn.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.ezen.aclearn.service.lctr.LctrService;
import com.ezen.aclearn.vo.LctrLikeVO;
import com.ezen.aclearn.vo.LctrVO;
import com.ezen.aclearn.vo.ReviewVO;
import com.ezen.aclearn.vo.UserLctrVO;
import com.ezen.aclearn.vo.UserVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/lctr")
public class LctrController {
	@Autowired
	private LctrService lctrService;
	
	public void addLctr(LctrVO lctrVO) {
		
	}
	
	public void delLctr(LctrVO lctrVO) {
		
	}
	
	public void updLctr(LctrVO lctrVO) {
		
	}
	
	@RequestMapping("/getLctrList.do")
	public String getLctrList(Model model) {
		List<LctrVO> lctrList = lctrService.getLctrList();
		
		model.addAttribute("lctrList", lctrList);
		
		return "lctr/getLctrList";
	}
	
	/* ("searchKeyword") String searchKeyword) */
	@RequestMapping("/getSearchLctrList.do")
	public String getSearchLctrList(Model model, @RequestParam Map<String, String> paramMap) {
		System.out.println(paramMap.get("searchKeyword"));
		
		List<LctrVO> lctrList = lctrService.getSearchLctrList(paramMap);
		
		model.addAttribute("lctrList", lctrList);
		model.addAttribute("searchKeyword", paramMap.get("searchKeyword"));
		
		return "lctr/getLctrList";
	}
	
	@RequestMapping("/getLctr.do")
	public String getLctr(@RequestParam("lctrCode") int lctrCode, Model model, HttpServletRequest httpRequest) {
		// null값 없을 때
		UserVO user = (UserVO)httpRequest.getSession().getAttribute("loginUser");
		
		if(user != null) {
			String userId = user.getUserId();
			
			// 좋아요 클릭 여부
			LctrLikeVO LctrLike = new LctrLikeVO();
			// 수강신청 여부 
			UserLctrVO LctrUser = new UserLctrVO();
			
			LctrLike.setLctrCode(lctrCode);
			LctrLike.setUserId(userId);
			
			LctrUser.setLctrCode(lctrCode);
			LctrUser.setUserId(userId);
			
			int getLctrLike = lctrService.getLctrLike(LctrLike);
			int getLctrUser = lctrService.getLctrUser(LctrUser);
					
			model.addAttribute("getLctrLike", getLctrLike);
			model.addAttribute("getLctrUser", getLctrUser);
		}
		
		LctrVO Lctr = lctrService.getLctr(lctrCode);
		List<ReviewVO> review = lctrService.getReview(lctrCode);
		
		int lctrLikeCnt = lctrService.getLctrLikeCnt(lctrCode);
		int lctrUserCnt = lctrService.getLctrUserCnt(lctrCode);
		int reviewCnt = lctrService.getReviewCnt(lctrCode);
		
		if(reviewCnt != 0) {
			float avgScore = lctrService.avgScore(lctrCode);
			model.addAttribute("avgScore", avgScore);
		}
		Map<Integer, String> ratingOptions = new HashMap<Integer, String>();
		ratingOptions.put(0, "☆☆☆☆☆");
		ratingOptions.put(1, "★☆☆☆☆");
		ratingOptions.put(2, "★★☆☆☆");
		ratingOptions.put(3, "★★★☆☆");
		ratingOptions.put(4, "★★★★☆");
		ratingOptions.put(5, "★★★★★");
		model.addAttribute("ratingOptions", ratingOptions);
		
		model.addAttribute("lctr", Lctr);
		model.addAttribute("lctrLikeCnt", lctrLikeCnt);
		model.addAttribute("lctrUserCnt", lctrUserCnt);
		model.addAttribute("review", review);
		model.addAttribute("reviewCnt", reviewCnt);
		
		return "lctr/getLctr";
	}
	
	@ResponseBody
	@RequestMapping(value="/lctrLike.do", method= RequestMethod.POST, produces="application/json" )
	public String boardLike(HttpServletRequest httpRequest) throws JsonProcessingException {
		int getLctrLike = Integer.parseInt(httpRequest.getParameter("getLctrLike"));
		int lctrCode = Integer.parseInt(httpRequest.getParameter("lctrCode"));
		String userId = ((UserVO)httpRequest.getSession().getAttribute("loginUser")).getUserId();
		
		LctrLikeVO lctrLike = new LctrLikeVO();
		
		lctrLike.setLctrCode(lctrCode);
		lctrLike.setUserId(userId);
		
		if(getLctrLike >= 1) {
			lctrService.deleteLctrLike(lctrLike);
			lctrService.updateLctrLike(lctrCode);
			getLctrLike = 0;
			System.out.println("getBoardLike >=1 일떄: " + getLctrLike );
		} 
		else {
			lctrService.addLctrLike(lctrLike);
			lctrService.updateLctrLike(lctrCode);
			getLctrLike = 1;
			System.out.println("getLctrLike =0 일떄: " + getLctrLike );
		}
		
		int lctrLikeCnt = lctrService.getLctrLikeCnt(lctrCode);
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Integer> returnMap = new HashMap<String, Integer>();
		
		returnMap.put("getLctrLike", getLctrLike);
		returnMap.put("lctrLikeCnt", lctrLikeCnt);
		returnMap.put("lctrCode", lctrCode);
		
		String jsonStr = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(returnMap);
		
		return jsonStr;
	}
	
	@ResponseBody
	@RequestMapping(value="/lctrUser.do", method= RequestMethod.POST, produces="application/json" )
	public String lctrUser(HttpServletRequest httpRequest) throws JsonProcessingException {
		int getLctrUser = Integer.parseInt(httpRequest.getParameter("getLctrUser"));
		int lctrCode = Integer.parseInt(httpRequest.getParameter("lctrCode"));
		String userId = ((UserVO)httpRequest.getSession().getAttribute("loginUser")).getUserId();
		
		UserLctrVO lctrUser = new UserLctrVO();
		
		lctrUser.setLctrCode(lctrCode);
		lctrUser.setUserId(userId);
		
		System.out.println("좋아요 버튼 누른 후 getLctrUser: " + getLctrUser );
		System.out.println("좋아요 버튼 누른 후 lctrCode: " + lctrCode);
		System.out.println("좋아요 버튼 누른 후 userId: " + userId);
		
		if(getLctrUser >= 1) {
			lctrService.deleteLctrUser(lctrUser);
			//lctrService.updateLctrUser(lctrCode);
			getLctrUser = 0;
			System.out.println("getBoardLike >=1 일떄: " + getLctrUser );
		} 
		else {
			lctrService.addLctrUser(lctrUser);
			//lctrService.updateLctrUser(lctrCode);
			getLctrUser = 1;
			System.out.println("getLctrLike =0 일떄: " + getLctrUser );
		}
		
		int lctrUserCnt = lctrService.getLctrUserCnt(lctrCode);
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Integer> returnMap = new HashMap<String, Integer>();
		
		returnMap.put("getLctrUser", getLctrUser);
		returnMap.put("lctrUserCnt", lctrUserCnt);
		returnMap.put("lctrCode", lctrCode);
		
		String jsonStr = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(returnMap);
		
		return jsonStr;
	}
	
	@PostMapping("/addReview.do")
	public String addReview(ReviewVO reviewVO) {
		
		lctrService.addReview(reviewVO);
		
		return "redirect:/lctr/getLctr.do?lctrCode=" + reviewVO.getLctrCode();
	}
	
	@RequestMapping("/deleteReview.do")
	public String delReview(ReviewVO reviewVO, HttpSession session) {
		UserVO user = (UserVO)session.getAttribute("loginUser");
		
		if(user == null || !reviewVO.getUserId().equals(user.getUserId())) {
			
		}
		
		lctrService.deleteReview(reviewVO);
		
		return "redirect:/lctr/getLctr.do?lctrCode=" + reviewVO.getLctrCode();
	}
	
	public void updReview(ReviewVO reviewVO) {
		
	}
	
	@RequestMapping(value="/updateLctrCnt.do", method= RequestMethod.GET)
	public String updateLctrCnt(@RequestParam("lctrCode") int lctrCode) {
		lctrService.updateLctrCnt(lctrCode);
		
		return "redirect:/lctr/getLctr.do?lctrCode=" + lctrCode;
	}
	
	// 위의 내용에 추가
//	public void addUserLctr(LctrVO lctrVO) {
//		
//	}	
	
	@RequestMapping("/getLctrReviewList.do")
	public String getLctrReviewList(Model model) {
		Map<Integer, String> ratingOptions = new HashMap<Integer, String>();
		ratingOptions.put(0, "☆☆☆☆☆");
		ratingOptions.put(1, "★☆☆☆☆");
		ratingOptions.put(2, "★★☆☆☆");
		ratingOptions.put(3, "★★★☆☆");
		ratingOptions.put(4, "★★★★☆");
		ratingOptions.put(5, "★★★★★");
		model.addAttribute("ratingOptions", ratingOptions);
		
		List<ReviewVO> review = lctrService.getLctrReviewList();
		model.addAttribute("review", review);
		
		int getLctrReviewCnt = lctrService.getLctrReviewCnt();
		model.addAttribute("getLctrReviewCnt", getLctrReviewCnt);
		
		return "/lctr/getLctrReviewList";
	}
	
	@RequestMapping("/getUserLctrList.do")
	public String getUserLctrList(Model model, HttpServletRequest httpRequest) {
		UserVO user = (UserVO)httpRequest.getSession().getAttribute("loginUser");
		if(user != null) {
			String userId = user.getUserId();
			List<LctrVO> lctrUserList = lctrService.getLctrUserList(userId);
			model.addAttribute("lctrUserList", lctrUserList);
		}
		return "/lctr/getUserLctrList";
	}
}
