<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style>
	main {
		margin-top: 5rem;
	}
	
	h3 {
		padding-bottom: 12px;
		font-size: 30px;
	}
	.form-wrapper {
      	text-align: center;
      	margin: 200px auto; 
	}

	#searchIdForm {
		width: 460px;
		height: 420px;
		text-align: center;
		margin: 50px auto;
	}
	
	#searchIdForm input {
		width: 300px;
		height:40px;
		
	}
	
	input::placeholder {
  		font-size: 15px;
  		font-style: italic;
	}
	
	#searchIdForm .login_append {
		margin-right:10px;
	}
	
	#searchIdForm .resultIdDiv {
	
	}
			
	#btnFindId {
		width: 310px;
		height: 43px;
		background-color:black;
		color:white;
		font-size: 15px;
		font-weight: bold;
	}
</style>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
	<main>
	<div class="form-wrapper">
		<form id="searchIdForm">
			<h3>아이디 찾기</h3>
			<div class="input-wrapper" style="display:block; margin:20px auto;">
				<input type="text" id="userName" name="userName" placeholder=" 이름" required>
			</div>
			<div class="input-wrapper" style="display:block; margin:20px auto;">
				<input type="text" id="userBirth" name="userBirth" placeholder=" 생년월일 8자리(ex.19001201)" required>
			</div>
			<div id="resultIdDiv" style="display: none; font-weight: bold; font-style: italic; ">
				<p id="searchIdResult"></p>
			</div>
			<div style="display:block; margin:20px auto; padding-top:15px;">
				<button type="button" id="btnFindId">확 인</button>
			</div>
			<div class="login_append">
	        <span class="txt_find">
	           <a href="/user/login.do" class="link_find">로그인</a>
	            |
	           <a href="/user/searchPw.do" class="link_find">비밀번호 찾기</a>
	            |
	           <a href="/user/join.do" class="link_find">회원가입</a>
	         </span>
	       </div>	
		</form>
	</div>
	</main>
	<div class="footer-wrap">
		<jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
	</div>
	<script>
		$(function() {
			$("#btnFindId").on("click", function() {
				console.log($("#searchIdForm").serialize());
				
				$.ajax({
					url: "/user/searchId.do",
					type: "post",
					data: $("#searchIdForm").serialize(),
					success: function(obj) {
						const data = JSON.parse(obj);
						
						console.log(data);
						
						$("#resultIdDiv").show();
						
						if(data.msg == "ok") {
							$("#searchIdResult").text("아이디는 " + data.searchId +" 입니다.");
						} else{
							$("#searchIdResult").text("존재하지 않는 사용자입니다.");
						}
					},
					error: function(e) {
						console.log(e);
					}
				});
			});
		});
		
	</script>
</body>
</html>