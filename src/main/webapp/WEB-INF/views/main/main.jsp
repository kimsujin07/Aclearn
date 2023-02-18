<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>ACLearn - 배우고, 나누고, 성장하세요</title>
    </head>
    <style>
    	body {
    		margin-top: 50px;
    	}
    </style>
<body>
	<jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
	
   <section class="top-banner">
    <div class="banner">
        <div class="banner-imgs">
          <div><a href="/cmnt/getCmntList.do"><img src="${pageContext.request.contextPath }/resources/images/1.webp"></a></div>
          <div><a href="/lctr/getLctrList.do"><img src="${pageContext.request.contextPath }/resources/images/2.webp"></a></div>
          <div><a href="#"><img src="${pageContext.request.contextPath }/resources/images/3.webp"></a></div>
          <div><a href="/lctr/getLctrList.do"><img src="${pageContext.request.contextPath }/resources/images/4.webp"></a></div>
        </div>
    </div>
  </section>
	
  <section class="most-like-1">
    <div class="test2">
      <div class="test4"><a href="#" id="rank-lctr-1" class="common-1">인기 강의</a></div>
      <div id="container-lctr">
        <div class="rank-lctr-1">
        	<c:forEach items="${lctrList }" var ="lctr">
	          <div class="main-Lctr">
	          	<!--클릭시 이동(비로그인 -> 로그인창, 로그인 -> 강의 창) -->
	          	<div><img src="/resources/images/${lctr.lctrOriImg1}" id="rank-lctr" class="test3" width="700px" height="500px"></div>
	            <div><a href="${lctr.lctrCode }"><span class="text-centre">${lctr.lctrTitle }</span></a></div>
	            <p class="word-break">	            	
	            	<c:choose>
           				<c:when test="${fn:length(lctr.lctrDetails) > 110 }">
           					<c:out value="${fn:substring(lctr.lctrDetails, 0, 109)}..."></c:out>
           				</c:when>
           				<c:otherwise>
           					<c:out value="${lctr.lctrDetails}"></c:out>
           				</c:otherwise>
           			</c:choose>
	            </p>
	          </div>
	          <%-- <c:if test="${loginUser == null }">
	          	$(click).ready(function () {
				  $(click).on("click", function () {
				  <jsp:include page="${pageContext.request.contextPath }/user/login.do"></jsp:include>
				  });
				});
	          </c:if>
	          <c:if test="${loginUser != null }">
	          	$(click).ready(function () {
				  $(click).on("click", function () {
				  <jsp:include page="${pageContext.request.contextPath }${lctr.lctrCode }"></jsp:include>
				  });
				});
	          </c:if> --%>
	        </c:forEach>
        </div>
      </div>
    </div>
  </section>
  
  <section class="most-like-2">
    <div class="test2">
      <div class="test5"><a href="/lctr/getLctrList.do" id="rank-lctr-2" class="common-1">추천 강의+</a></div>
      <div id="container-lctr">
        <div class="rank-lctr-2">
        <c:forEach items="${lctrSubList }" var ="lctr">
          <div class="test">
          	<img src="/resources/images/${lctr.lctrOriImg1}" class="rank-lctr" width="100%" height="250px">
          	<div></div>
          	<h3 class="title">${lctr.lctrTitle }</h3>
            <div class="popup">
            	<a href="${lctr.lctrCode }">
            		<span class="test6">
            			<c:choose>
            				<c:when test="${fn:length(lctr.lctrDetails) > 50 }">
            					<c:out value="${fn:substring(lctr.lctrDetails, 0, 49)}..."></c:out>
            				</c:when>
            				<c:otherwise>
            					<c:out value="${lctr.lctrDetails}"></c:out>
            				</c:otherwise>
            			</c:choose> 
					</span>
				</a>
            </div>
          </div>
        </c:forEach>
        </div>
      </div>
    </div>
  </section>

  <script>
    $(function() {	
      $flag = 0; 
      $(".test").on('mouseover', 
        function () { 
          console.log($(this));
          $(this).find(".popup").attr("style", "visibility:visible"); 
        } 
      ); 

      $(".test").on('mouseout', 
        function () { 
          $(this).find(".popup").attr("style", "visibility:hidden"); 
        } 
      ); 
    });
    
    $(".popup a, .main-Lctr a").on("click", function(e) {
    	e.preventDefault();
    	
    	const loginUserId = '${loginUser.userId}';
    	
    	if(loginUserId != null && loginUserId != '') 
    		window.location.href = "/lctr/getLctr.do?lctrCode=" + $(this).attr("href");
   		else
   			window.location.href = "/user/login.do";
    });
  </script>
  
  <jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
</body>
</html>
