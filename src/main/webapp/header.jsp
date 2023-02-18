<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ACLearn - 배우고, 나누고, 성장하세요</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
  <link href="${pageContext.request.contextPath }/resources/css/styles.css?ver=1" rel="stylesheet" />
  <script>
    $(document).ready(function () {
      $(".banner-imgs").bxSlider({ slideWidth: 1500,
        adaptiveHeight: true, maxSlides: 1, moveSlides: 1, slideMargin: 20, pause: 5000, speed: 2000, 
        auto: true, autoHover: true, infiniteLoop: true, controls: false, captions:true})
    })
  </script>
</head>
<body>

	<header class="top-nav-bar">
    <a href="/index.jsp" class="logo"><img src="${pageContext.request.contextPath }/resources/images/Logo_AcLearn_최종(1).png" alt="" style="height: 50px;"></a>
    <nav class="nav-bar">
      <a href="/lctr/getLctrList.do">강의</a>
      <a href="/lctr/getLctrReviewList.do">수강평</a>
      <a href="/cmnt/getCmntList.do">커뮤니티</a>
      <c:choose>
		<c:when test="${loginUser != null}">
			<a href="/lctr/getUserLctrList.do">${loginUser.userNickname }(${loginUser.userId })님 강의목록</a>
		</c:when>
	  </c:choose>
    </nav>
  
	<form id="search" action="/lctr/getSearchLctrList.do" method="post">
		<input type="text" class="search-bar" name="searchKeyword" placeholder="검색어 입력" value="${searchKeyword }">
		<button type="submit" id="search-btn">🔍︎</button>
	</form>
    <div id="sign">
	    <c:choose>
			<c:when test="${loginUser == null}">
				<a href="/user/login.do" class="sign-in-btn">로그인</a>
				<a href="/user/join.do" class="sign-up-btn">회원가입</a>
			</c:when>
			<c:otherwise>
				<a href="/user/mypage.do" style="text-decoration: underline;">${loginUser.userNickname }님</a>
				<a href="/user/logout.do" style="text-decoration: underline;">로그아웃</a>
			</c:otherwise>
		</c:choose>
    </div>
  </header>
</body>
</html>