package com.ezen.aclearn.service.lctr;

import java.util.List;
import java.util.Map;

import com.ezen.aclearn.vo.LctrLikeVO;
import com.ezen.aclearn.vo.LctrVO;
import com.ezen.aclearn.vo.ReviewVO;
import com.ezen.aclearn.vo.UserLctrVO;

public interface LctrService {
	// 강의 목록 조회
	List<LctrVO> getLctrList();
	
	// 강의 세부 조회
	LctrVO getLctr(int lctrCode);
	
	// 좋아요 클릭 여부
	int getLctrLike(LctrLikeVO lctrLike);
	
	// 좋아요 개수 카운트
	int getLctrLikeCnt(int lctrCode);
	
	// 좋아요 삭제
	void deleteLctrLike(LctrLikeVO lctrLike);
	
	// 좋아요 추가
	void addLctrLike(LctrLikeVO lctrLike);
	
	// 좋아요 개수 카운트 테이블 기록
	void updateLctrLike(int lctrCode);
	
	// 수강신청 클릭 여부
	int getLctrUser(UserLctrVO lctrUser);
	
	// 수강신청 개수 카운트
	int getLctrUserCnt(int lctrCode);
	
	// 수강 취소
	void deleteLctrUser(UserLctrVO lctrUser);
	
	// 수강 신청
	void addLctrUser(UserLctrVO lctrUser);
	
	// 회원의 수강중인 강의번호에 대한 강의정보
	List<LctrVO> getLctrUserList(String userId);
	
	// 수강평 추가
	void addReview(ReviewVO reviewVO);
	
	// 수강평 보기
	List<ReviewVO> getReview(int lctrCode);
	
	// 수강평 개수
	int getReviewCnt(int lctrCode);
	
	// 수강평 삭제
	void deleteReview(ReviewVO reviewVO);
	
	// 강의 조회수 증가
	void updateLctrCnt(int lctrCode);
	
	// 평점 조회
	float avgScore(int lctrCode);
	
	// 
	List<ReviewVO> getLctrReviewList();
	
	// 강의 검색 목록 조회
	List<LctrVO> getSearchLctrList(Map<String, String> paramMap);
	
	//메인페이지 강의 목록 조회
	List<LctrVO> getMainLctrList();
	
	//추천강의 목록 조회
	List<LctrVO> getSubLctrList();
	
	// 수강평 수
	int getLctrReviewCnt();
}
