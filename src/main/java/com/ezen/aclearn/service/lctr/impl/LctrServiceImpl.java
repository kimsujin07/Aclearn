package com.ezen.aclearn.service.lctr.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.aclearn.service.lctr.LctrService;
import com.ezen.aclearn.vo.LctrLikeVO;
import com.ezen.aclearn.vo.LctrVO;
import com.ezen.aclearn.vo.ReviewVO;
import com.ezen.aclearn.vo.UserLctrVO;

@Service
public class LctrServiceImpl implements LctrService {
	@Autowired
	private LctrDAO lctrDAO;
	
	@Override
	public List<LctrVO> getLctrList() {
		return lctrDAO.getLctrList();
	}
	
	@Override
	public LctrVO getLctr(int lctrCode) {
		return lctrDAO.getLctr(lctrCode);
	}
	
	// 좋아요 클릭 여부
	@Override
	public int getLctrLike(LctrLikeVO lctrLike) {
		return lctrDAO.getLctrLike(lctrLike);
	};
	
	// 좋아요 개수 카운트
	@Override
	public int getLctrLikeCnt(int lctrCode) {
		return lctrDAO.getLctrLikeCnt(lctrCode);
	};
	
	@Override
	public void deleteLctrLike(LctrLikeVO lctrLike) {
		lctrDAO.deleteLctrLike(lctrLike);
	}

	@Override
	public void addLctrLike(LctrLikeVO lctrLike) {
		lctrDAO.addLctrLike(lctrLike);
	}
	
	// 좋아요 개수 카운트 테이블 기록
	public void updateLctrLike(int lctrCode) {
		lctrDAO.updateLctrLike(lctrCode);
	}
	
	// 수강신청 클릭 여부
	@Override
	public int getLctrUser(UserLctrVO lctrUser) {
		return lctrDAO.getLctrUser(lctrUser);
	}
	
	// 수강신청 개수 카운트
	public int getLctrUserCnt(int lctrCode) {
		return lctrDAO.getLctrUserCnt(lctrCode);
	}
	
	// 수강 취소
	public void deleteLctrUser(UserLctrVO lctrUser) {
		lctrDAO.deleteLctrUser(lctrUser);
	}
	
	// 수강 신청
	public void addLctrUser(UserLctrVO lctrUser) {
		lctrDAO.addLctrUser(lctrUser);
	}
	
	// 회원의 수강중인 강의번호에 대한 강의정보
	public List<LctrVO> getLctrUserList(String userId) {
		return lctrDAO.getLctrUserList(userId);
	}
	
	// 수강평 추가
	public void addReview(ReviewVO reviewVO) {
		lctrDAO.addReview(reviewVO);
	}
	
	// 수강평 보기
	public List<ReviewVO> getReview(int lctrCode) {
		return lctrDAO.getReview(lctrCode);
	}
	
	// 수강평 개수
	public int getReviewCnt(int lctrCode) {
		return lctrDAO.getReviewCnt(lctrCode);
	}
	
	// 수강평 삭제
	public void deleteReview(ReviewVO reviewVO) {
		lctrDAO.deleteReview(reviewVO);
	}
	
	// 강의 조회수 증가
	public void updateLctrCnt(int lctrCode) {
		lctrDAO.updateLctrCnt(lctrCode);
	}
	
	// 평점 조회
	public float avgScore(int lctrCode) {
		return lctrDAO.avgScore(lctrCode);
	}
	
	public List<ReviewVO> getLctrReviewList() {
		return lctrDAO.getLctrReviewList();
	}

	@Override
	public List<LctrVO> getSearchLctrList(Map<String, String> paramMap) {
		return lctrDAO.getSearchLctrList(paramMap);
	}
	
	@Override
	public List<LctrVO> getMainLctrList() {
		return lctrDAO.getMainLctrList();
	}
	
	@Override
	public List<LctrVO> getSubLctrList() {
		return lctrDAO.getSubLctrList();
	}
	
	@Override
	public int getLctrReviewCnt() {
		return lctrDAO.getLctrReviewCnt();
	}
}
