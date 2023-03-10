<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ACLearn - 배우고, 나누고, 성장하세요</title>
<style>
   
   main {
     margin-top: 120px;
     margin-bottom: 100px;
   }
   .container {
     width: 1200px;
     margin: 0 auto;
   }
    .main_content { 
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 10px;
      margin: 0 auto;
      margin-top: 30px;
    }
    .item { 
      border: 1px solid lightgray;
      border-radius: 5px;
      text-align: left;
    }
    img {
      width: 100%;
    }
    .pagination {
      text-align: center;
      margin-top: 20px;
    }
    .content, h3 {
     margin:10px;
    }
    .lctrListContents {
       width:100%;
    }
    .main_menu {
      display: flex;
      border-bottom: 1px solid lightgray;
    }
    .contentImg {
      border-radius: 5px 5px 0 0;
    }
    .user_menu {
      height: 40px;
      margin-right:30px;
      text-decoration: none;
      color: gray;
    }
</style>
</head>
<body>
	<div class="entire-wrap">
<jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
   <main>
   <div class="container">
      <div class="main_menu">
      	<div class="user_menu"><b>${loginUser.userNickname }(${loginUser.userId })님 강의목록</b></div>
      </div>
      <div class="main_content" id="user" style="margin-top: 30px;">
         <c:forEach items="${lctrUserList }" var="lctrUserList">
            <div class="item">
               <img class="contentImg" src="/resources/images/${lctrUserList.lctrOriImg1}" alt="NoImg">
               <h3><a href="/lctr/updateLctrCnt.do?lctrCode=${lctrUserList.lctrCode }">${lctrUserList.lctrTitle }</a></h3>
               <div class="content lctrListContents">
                  <c:choose>
                        <c:when test="${fn:length(lctrUserList.lctrDetails) > 20 }">
                           <c:out value="${fn:substring(lctrUserList.lctrDetails, 0, 19)}..."></c:out>
                        </c:when>
                        <c:otherwise>
                           <c:out value="${lctr.lctrDetails}"></c:out>
                        </c:otherwise>
                     </c:choose> 
                  </div>
            </div>
         </c:forEach>
      </div>
      <!-- Pagination -->
      <!-- 한 페이지에 보여줄 최대 강의 수도 페이지내이션에서 설정 -->
      <!-- <div class="pagination">
         <div>
            <a href="#">«</a>
            <a href="#">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">»</a>
         </div>
      </div> -->
   </div>
   </main>
   <jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
   </div>
</body>
</html>