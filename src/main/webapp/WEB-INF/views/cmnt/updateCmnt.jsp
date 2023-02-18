<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACLearn - 배우고, 나누고, 성장하세요</title>
<style>
	main {padding-top: 10rem;}
    #container { text-align: center;}
    
	#cmntTitle {
		width:100%; height: 40px;
		border:2px solid #aaa;
		border-radius:4px;
		margin: 8px 0;
		outline: none;
		padding:8px;
		box-sizing: border-box;
		transition:.3s;
	}
	
	#cmntTitle:focus{
		border-color:dodgerBlue;
		box-shadow:0 0 8px 0 dodgetBlue;
	}
	
	#cmntContents {
		width:100%;
		border: 2px solid #aaa;
		border-radius:4px;
		margin: 8px 0;
		outline: none;
		padding:8px;
		box-sizing: border-box;
		transition:.3s;
	}
	
	#userNickname {
		margin-left: 10px;
		font-size: 0.9rem;
	}
	.fileArea {
		margin: 10px 10px 40px 10px;
	}
	.btnleft {float: left;}
    .btnRight {float:right;}
	.acBtn1 { /* 커뮤니티 하단 왼쪽 버튼 */
		color: white;
		background-color: gray;
		border: 0;
		width: 70px; height: 40px;
		margin: 0 10px 0 0;
		border-radius: 3px;
	}
	.acBtn2 { /* 커뮤니티 하단 오른쪽 버튼 */
		color: white;
		background-color: green;
		border: 0;
		width: 70px; height: 40px;
		margin: 0 0 0 10px;
		border-radius: 3px;
	}


</style>
</head>
<body>
    <jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
    <main>
	<div style="display: flex; flex-direction: column; justify-content: center; align-items: center;" id="container">
		<h3>ACLearn - Community</h3>
		<form id="updateCmnt" action="/cmnt/updateCmnt.do" method="post">
			<input type="hidden" name="cmntCode" value="${cmntVO.cmntCode}"/>
			<table>
				<tr>
					<td style="text-align: left; width: 800px;">
						<input type="text" name="cmntTitle" id="cmntTitle" value="${cmntVO.cmntTitle}" >
						<input type="hidden" name="cmntTitle1" id="cmntTitle1" value="${cmntVO.cmntTitle}" >
					</td>
				</tr>
				<tr>
					<td style="text-align: left">
						<label id="userNickname">작성자 :&nbsp;&nbsp;${cmntVO.userNickname}</label>
					</td>
				</tr>
				<tr>
					<td style="text-align: left; width: 800px; height: 500px; ">
						<textarea name="cmntContents" id="cmntContents" cols="110" rows="20" style="resize: none;">${cmntVO.cmntContents}</textarea>
					</td>
				</tr>
			</table>
            <button type="button" id="btnList" class="acBtn1 btnleft" onclick="location.href='/cmnt/getCmntList.do'">목록</button>
            <button type="submit" id="btnInsert" class="acBtn2 btnRight">등록</button>
		</form>
		<hr/>
	</div>
	</main><%-- 
	<div class="footer-wrap">
		<jsp:include page="${pageContext.request.contextPath}/footer.jsp"></jsp:include>
	</div> --%>
</body>
</html>