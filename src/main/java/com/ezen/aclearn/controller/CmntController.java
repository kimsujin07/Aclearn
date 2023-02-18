package com.ezen.aclearn.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.aclearn.common.FileUtils;
import com.ezen.aclearn.service.cmnt.CmntService;
import com.ezen.aclearn.vo.CmntVO;
import com.ezen.aclearn.vo.ReplyVO;
import com.ezen.aclearn.vo.UserVO;

@Controller
@RequestMapping("/cmnt")
public class CmntController {
	@Autowired
	private CmntService cmntService;
	
	// 커뮤니티 목록 화면
	@RequestMapping("/getCmntList.do")
	public String getCmntList(Model model, @RequestParam Map<String, String> paramMap) {
		List<CmntVO> cmntList = cmntService.getCmntList(paramMap);
		
		model.addAttribute("cmntList", cmntList);
		
		if(paramMap.get("searchCondition") != null && !paramMap.get("searchCondition").equals(""))
			model.addAttribute("searchCondition", paramMap.get("searchCondition"));
		if(paramMap.get("searchKeyword") != null && !paramMap.get("searchKeyword").equals(""))
			model.addAttribute("searchKeyword", paramMap.get("searchKeyword"));
		
		return "cmnt/getCmntList";
	}
	
	
	// 커뮤니티 글 상세보기
	@RequestMapping("/getCmnt.do")
	public String getCmnt(@RequestParam("cmntCode") int cmntCode, /* Map<String, String> paramMap,*/ Model model) {
		CmntVO cmnt = cmntService.getCmnt(cmntCode);
		List<ReplyVO> replyList = cmntService.getReplyList(cmntCode);
		
		model.addAttribute("cmnt", cmnt);
		model.addAttribute("replyList", replyList);
		
		return "cmnt/getCmnt";
	}
	
	// 조회수 증가
	@RequestMapping("/updateCmntCnt.do")
	public String updateCmntCnt(@RequestParam("cmntCode") int cmntCode) {
		cmntService.updateCmntCnt(cmntCode);
		
		return "redirect:/cmnt/getCmnt.do?cmntCode=" + cmntCode;
	}
	
	
	// 커뮤니티 글 등록 화면으로 이동
	@GetMapping("/insertCmnt.do")
	public String insertCmntView(HttpSession session) {
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		if(loginUser == null) {
			return "redirect:/user/login.do";
		}
		return "cmnt/insertCmnt";
	}
	
	// 커뮤니티 글 등록
	@PostMapping("/insertCmnt.do")
	public String insertCmnt(CmntVO cmntVO, MultipartFile uploadFiles,
			HttpServletRequest request) throws IOException {
		
		if(uploadFiles.getOriginalFilename() != null &&
			!uploadFiles.getOriginalFilename().equals("")) {
			String attachPath = request.getSession().getServletContext().getRealPath("/") + "/upload/";
			
			File directory = new File(attachPath);
			
			if(!directory.exists()) {
				directory.mkdir();
			}
			
			Map<String, String> fileMap = FileUtils.parseFileInfo(uploadFiles, attachPath);
			
			cmntVO.setCmntNowImg(fileMap.get("boardFileNm"));
			cmntVO.setCmntOriImg(fileMap.get("boardOriginFileNm"));
		}		
		
		cmntService.insertCmnt(cmntVO);
		
		// 등록 후 게시글 목록으로 이동
		return "redirect:/cmnt/getCmntList.do";
	}
	
	
	// 커뮤니티 글 수정 페이지로 이동
	@RequestMapping("/updateCmntView.do")
	public String updateCmntView(Model model, CmntVO cmntVO, HttpSession session) {		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");		
		if(loginUser == null) {
			return "redirect:/user/login.do";
		}
		System.out.println("@@@cmntVO getCmntCode-> " + cmntVO.getCmntCode());
		model.addAttribute("cmntVO", cmntVO);
		return "cmnt/updateCmnt";	
	}
	
	// 커뮤니티 글 수정
	@RequestMapping("/updateCmnt.do")
	public String updateCmnt(CmntVO cmntVO) {
		cmntService.updateBoard(cmntVO);
		
		// 등록 후 게시글 목록으로 이동
		return "redirect:/cmnt/getCmnt.do?cmntCode=" + cmntVO.getCmntCode();
	}

	
	// 커뮤니티 글 삭제
	@RequestMapping("/deleteCmnt.do")
	public String deleteCmnt(int cmntCode) {
		cmntService.deleteCmnt(cmntCode);
		
		return "redirect:/cmnt/getCmntList.do";
	}
	
	// LIKE
	public void addLike() {
		
	}
	
	// LIKE 취소
	public void delLike() {
		
	}
	
	// 댓글 작성
	@RequestMapping("/addReply.do")	
	public String addReply(ReplyVO replyVO) {
		cmntService.addReply(replyVO);
		
		return "redirect:/cmnt/getCmnt.do?cmntCode=" + replyVO.getCmntCode();
	}
	
	/*
	// 댓글 목록 화면
	@RequestMapping("/getReplyList.do")
	public String getReplyList(Model model, @RequestParam Map<String, String> paramMap) {
		List<ReplyVO> replyList = cmntService.getReplyList(paramMap);
		
		model.addAttribute("replyList", replyList);
		model.addAttribute("cmntCode", paramMap.get("cmntCode"));
		System.out.println(paramMap.get("cmntCode"));
		
		return "cmnt/getCmnt.do?cmntCode=" + paramMap.get("cmntCode");
	}
	*/
	
	// 댓글 삭제
	@RequestMapping("/delReply.do")
	public String delReply(int cmntCode) {
		cmntService.delReply(cmntCode);
		
		return "redirect:/cmnt/getCmnt.do?cmntCode=" + cmntCode;
	}
		
}
