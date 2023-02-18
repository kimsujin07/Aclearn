package com.ezen.aclearn.service.lctr.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ezen.aclearn.vo.LctrLikeVO;
import com.ezen.aclearn.vo.LctrVO;
import com.ezen.aclearn.vo.ReviewVO;
import com.ezen.aclearn.vo.UserLctrVO;

@Repository
public class LctrDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public List<LctrVO> getLctrList() {
		return mybatis.selectList("LctrDAO.getLctrList");
	}
	
	public LctrVO getLctr(int lctrCode) {
		return mybatis.selectOne("LctrDAO.getLctr", lctrCode);
	}
	
	// 좋아요 클릭 여부
	public int getLctrLike(LctrLikeVO lctrLike) {
		return mybatis.selectOne("LctrDAO.getLctrLike", lctrLike);
	}
	
	// 좋아요 개수 카운트
	public int getLctrLikeCnt(int lctrCode) {
		return mybatis.selectOne("LctrDAO.getLctrLikeCnt", lctrCode);
	}
	
	public void deleteLctrLike(LctrLikeVO lctrLike) {
		mybatis.delete("LctrDAO.deleteLctrLike", lctrLike);
	}

	public void addLctrLike(LctrLikeVO lctrLike) {
		mybatis.insert("LctrDAO.addLctrLike", lctrLike);
	}
	
	public void updateLctrLike(int lctrCode) {
		mybatis.update("LctrDAO.updateLctrLike", lctrCode);
	}
	
	public int getLctrUser(UserLctrVO lctrUser) {
		return mybatis.selectOne("LctrDAO.getLctrUser", lctrUser);
	}
	
	public int getLctrUserCnt(int lctrCode) {
		return mybatis.selectOne("LctrDAO.getLctrUserCnt", lctrCode);
	}
	
	public void deleteLctrUser(UserLctrVO lctrUser) {
		mybatis.delete("LctrDAO.deleteLctrUser", lctrUser);
	}

	public void addLctrUser(UserLctrVO lctrUser) {
		mybatis.insert("LctrDAO.addLctrUser", lctrUser);
	}
	
	public List<LctrVO> getLctrUserList(String userId) {
		return mybatis.selectList("LctrDAO.getLctrUserList", userId);
	}
	
	public void addReview(ReviewVO reviewVO) {
		mybatis.insert("LctrDAO.addReview", reviewVO);
	}
	
	public List<ReviewVO> getReview(int lctrCode) {
		return mybatis.selectList("LctrDAO.getReview", lctrCode);
	}
	
	public int getReviewCnt(int lctrCode) {
		return mybatis.selectOne("LctrDAO.getReviewCnt", lctrCode);
	}
	
	public void deleteReview(ReviewVO reviewVO) {
		mybatis.update("LctrDAO.deleteReview", reviewVO);
	}
	
	public void updateLctrCnt(int lctrCode) {
		mybatis.update("LctrDAO.updateLctrCnt", lctrCode);
	}
	
	public float avgScore(int lctrCode) {
		return mybatis.selectOne("LctrDAO.avgScore", lctrCode);
	}
	
	public List<ReviewVO> getLctrReviewList() {
		return mybatis.selectList("LctrDAO.getLctrReviewList");
	}

	public List<LctrVO> getSearchLctrList(Map<String, String> paramMap) {
		return mybatis.selectList("LctrDAO.getSearchLctrList", paramMap);
	}
	
	public List<LctrVO> getMainLctrList() {
		return mybatis.selectList("LctrDAO.getMainLctrList");
	}

	public List<LctrVO> getSubLctrList() {
		return mybatis.selectList("LctrDAO.getSubLctrList");
	}
	
	public int getLctrReviewCnt() {
		return mybatis.selectOne("LctrDAO.getLctrReviewCnt");
	}
}	
