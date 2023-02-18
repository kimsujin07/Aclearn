<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACLearn - 배우고, 나누고, 성장하세요</title>
<style>
	main {margin-top: 10rem;}
	
    #container { margin: 0 auto;}
    table { 
    	width: 800px;
    	margin: 0 0 30px 0;
    	border: 0;
    }
    td {
        padding: 20px 10px;
    }
    
    #cmntRegdate, #cmntModfdate {
        float: right; margin-left: 30px;
    }
    .acBtn1 {
		color: white;
		background-color: gray;
		border: 0;
		width: 70px; height: 40px;
		margin: 0 10px 0 0;
		border-radius: 3px;
	}
	.acBtn2 {
		color: white;
		background-color: rgb(69, 185, 69);
		border: 0;
		width: 70px; height: 40px;
		margin: 0 0 0 10px;
		border-radius: 3px;
	}
	.acBtn3 {
		color: white;
		background-color: rgb(69, 185, 69);
		border: 0;
		border-radius: 3px;
	}
	
    .btnleft {float: left;}

    .btnRight {float:right;}

    #insertReply { float: right;}
    
    #addReplyForm {
    	margin: 30px 0;
    }
    
    #rpContents { 
    	width: 694px; height: 98px;
    	float: left;
    }
    
    #addReplyBtn {
    	width: 90px; height: 100px;
    	margin-left: 10px;
    }
    
    #replyContainer {
    	display: inline-block;
    	width: 800px; 
    }
    
   	.replyBox {
   		width: 760px;	
   		height: 80px;
   		border-top: 2px solid gray;
   		margin-bottom: 20px;
   		padding:20px;
   	} 
   	.replyBox:last-child {
   		padding-bottom: 40px;
   		border-bottom: 2px solid gray;
   	}
	.replyNn {
		float: left;
		height: 20px;
		margin-bottom: 10px;
	}
    .replyRd {
		float: right;
		height: 20px;
	}
	.replyCt {
		height: 50px;
		clear: both;
	}
	

</style>
</head>
<body>

<div class="entire-wrap" style="justify-content: normal;">
    <jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
    <main>
	<div style="display: flex; flex-direction: column; justify-content: center; align-items: center;" id="container">
		<h1 id="title" style="margin-bottom: 20px;">Community</h1>
		<form action="/cmnt/updateCmntView.do" method="post">
			<input type="hidden" id="cmntCode" name="cmntCode" value="<c:out value='${cmnt.cmntCode}'/>" />
			<table border="1" style="border-collapse: collapse;">
				<tr>
					<td style="width: 800px">
						<p id="cmntTitleTag">${cmnt.cmntTitle}</p>
						<input type="hidden" id="cmntTitle" name="cmntTitle" value="<c:out value='${cmnt.cmntTitle}'/>" />
					</td>
				</tr>
				<tr>
					<td>
						<div style="float: left;">
							<label>작성자 :&nbsp;${cmnt.userNickname}</label>
							<input type="hidden" id="userNickname" name="userNickname" value="<c:out value='${cmnt.userNickname}'/>" />
						</div>
	                    <div style="float: right;">
		                    <!-- 기본 출력 -->
		                    <label>작성일 : ${cmnt.cmntRegdate}</label>
		                    <input type="hidden" id="cmntRegdate" name="cmntRegdate" value="<c:out value='${cmnt.cmntRegdate}'/>" />
		                    <!-- 작성일과 수정일이 다를 때(수정된 게시물에는 추가 출력) -->
		                     <c:if test="${cmnt.cmntModfdate ne cmnt.cmntRegdate}">
		                   		<label>&nbsp;&nbsp;수정일 : ${cmnt.cmntModfdate}</label>
		                   		<input type="hidden" id="cmntModfdate" name="cmntModfdate" value="<c:out value='${cmnt.cmntModfdate}'/>" />
		                    </c:if>
	                    </div>
					</td>
				</tr>
				<tr>
					<td style="text-align: left; width: 780px; padding: 20px 10px;">
						<c:if test="${cmnt.cmntOriImg ne null && cmnt.cmntNowImg ne null}">
							<img id="cmntImg" src="/upload/${cmnt.cmntNowImg}" style="width: 100%; z-index:none; cursor:pointer;" class="fileImg" ><br><br>
						</c:if>
						${cmnt.cmntContents}
						<input type="hidden" id="cmntContents" name="cmntContents" value="<c:out value='${cmnt.cmntContents}'/>" />
					
					</td>				
				</tr>
				<%-- <tr>
					<td style="text-align: center">
						<div>♥</div>
	                       <p>${cmntLike}</p>
					</td>
				</tr> --%>
			</table>
		        <button type="button" id="btnList" class="btnleft acBtn1" onclick="location.href='getCmntList.do'">목록</button>
		        <c:if test="${cmnt.userId eq loginUser.userId}">
			        <button type="button" id="btnDelete" class="btnRight acBtn2" onclick="location.href='deleteCmnt.do?cmntCode=${cmnt.cmntCode}'">삭제</button>
			        <button type="submit" id="btnUpdate" class="btnRight acBtn2">수정</button>
				</c:if>
		</form>		
		<hr/>
        <!-- 댓글 영역 -->
        <div>
            <!-- 댓글 입력 영역 -->
            <c:if test="${loginUser ne null}">
            <form id="addReplyForm" action="/cmnt/addReply.do" method="post">	
				<input type="hidden" id="cmntCode" name="cmntCode" value="<c:out value='${cmnt.cmntCode}'/>" />
				<input type="hidden" id="userId" name="userId" value="<c:out value='${loginUser.userId}'/>" />
				<input type="hidden" id="userNickname" name="userNickname" value="<c:out value='${loginUser.userNickname}'/>" />
                <textarea name="rpContents" id="rpContents" cols="90" rows="5" style="resize: none;"></textarea>
                <button type="submit" id="addReplyBtn" class="acBtn3">입력</button>
            </form>
 			</c:if>
 			<!-- 댓글 리스트 -->
            <div id="replyContainer">
                <c:forEach items="${replyList}" var="reply">
                <div class="replyBox">
                    <div class="replyNn">[&nbsp;${reply.userNickname}&nbsp;]</div>
                    <div class="replyRd">${reply.rpRegdate}</div>
                    <div class="replyCt" style="border-top: 1px dotted gray; padding-top: 10px;">${reply.rpContents}</div>
                </div>
                </c:forEach>
            </div>
        </div>
	</div>
	</main>
	<%-- <div class="footer-wrap">
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp"></jsp:include>
	</div> --%>
	</div>
</body>
