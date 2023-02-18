<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ACLearn - 배우고, 나누고, 성장하세요</title>
<style>
	main {
		width: 1200px;
		margin: 100px auto;
		margin-top: 100px;
	}
	.review-el__star-cover{
	  letter-spacing: -4px;
      font-size: 1.3em;
      color: transparent;
      text-shadow: 0 0 0 #f0f0f0;
  }
  .review-el__star-cover{
      letter-spacing: -4px;
      text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
  }
</style>
</head>
<body>
<div class="entire-wrap" style="justify-content: normal;">
<jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
<main>
<section class="content_review aa" id="tnrkdvud">
	<div class="review_header" style="display: flex; align-items: baseline;">
		<span style=" padding: 10px; margin-right: 8px; margin-left: 8px; ling-height: 1.4; box-sizing: inherit;">수강평</span>
		<span style="font-size: 13px;">${getLctrReviewCnt }개</span>
	</div>
	
	<div class="review_content" style="box-sizing: inherit; margin-top: 10px;">
	<c:forEach items="${review}" var="review">
		<div class="review-list__filter review-filter" style="display: flex; overflow-x: auto; align-item; padding: 0 16px 10px; bordor-bottom: 1px solid lightgray; white-space: nowrap; box-sizing: inherit;">
			<div class="review-list__el-cover" style="border: 1px solid lightgray; border-radius:10px; padding: 32px 0; width: 100%; box-sizing: inherit; display: block;">
				<div class="review-list__el review-el" style="margin-left: 20px; margin-right: 20px; box-sizing: inherit; display: block">
					<div class="review-el__header" style="margin-bottom: 12px; display: flex; align-items: center; box-sizing: inherit;">
						<div class="review-el__header--left" style="display: flex; align-items: flex-start">
							<div class="review-el__thumbnail" style="margin-right: 8px; flex-shrink:0; overflow: hidden; width: 42px; height: 42px; border-radius: 100%; border: 1px solid lightgray;">
								<img src="/resources/images/user.png" alt="회원사진" style="width:100%; height: 100%; object-fit: cover; max-width: 100%; display:block;">
							</div>
							<div class="review-el__user-info" style="display: flex; flex-direction: column; box-sizing: inherit;">
								<div class="review-el__star-cover" style="display: inline-flex; align-items: center; margin-bottom: 4px;">
										<c:forEach var="rating" items="${ ratingOptions }" varStatus="status" begin="1" end="${ review.reScore }">★</c:forEach>
										<!--<span style="line-height: 1.3; letter-space: -.3px; font-size: 15px; font-wight: 700;">${review.reScore}점</span>  -->
								</div>
								<div class="review-el__name" style="line-height: 1.3; letter-space: -.3px; font-size: 13px; font-wegit: 700; box-sizing: inherit; display: block">${review.userNickname}</div>
							</div>
						</div>
					</div>
					<div class="review-el__body" style="margin-bottom: 12px; line-height:1.6; letter-spacing: -.3px; font-size: 15px; white-space: pre-line;">${review.reContents}</div>
					<div class="review-el__tools" style="display: flex; align-items: center; box-sizing: inherit;">
						<div class="review-el__tools--left" style="box-sizing: inherit; display: block;">
							<span class="review-el__tool" style="line-height: 1.3; display: inline-flex; align-items: center; font-size: 13px;">${review.reRegdate}</span>
						</div>
						<c:choose>
							<c:when test="${review.userId == loginUser.userId }">
							<div class="review-el__tools--right" style="margin-left: auto; box-sizing: inherit; display: block;">
								<!-- <a href="#">수정</a> -->
								<a href="/lctr/deleteReview.do?lctrCode=${lctr.lctrCode}&reCode=${review.reCode}&userId=${review.userId}" style="line-decoration: none; font-size: 13px;">삭제 x</a>
							</div>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
	</div>
	<!-- <div class="review_more">
		<button>수강평 더보기</button>
	</div> -->
</section>
</main><%-- 
<div class="footer-wrap">
<jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
</div> --%>
</div>
</body>
</html>