<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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

	#searchPwForm {
		width: 460px;
		height: 480px;
		text-align: center;
		margin: 50px auto;
	}
	
	#searchPwForm input {
		width: 300px;
		height:40px;
		
	}
	
	input::placeholder {
  		font-size: 15px;
  		font-style: italic;
	}
	
	#searchPwForm .login_append {
		margin-right:20px;
	}
	
	#searchPwForm div {
	
	}
			
	#btnFindPw {
		width: 310px;
		height: 43px;
		background-color:black;
		color:white;
		font-size: 15px;
		font-weight: bold;
		
	}
	.txt_find {
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
	<main>
	<div class="form-wrapper">
		<form id="searchPwForm">
			<h3>비밀번호 찾기</h3>
			<div class="input-wrapper" style="display:block; margin:20px auto;">
				<input type="text" id="userId" name="userId" placeholder=" 아이디" required>
			</div>
			<div class="input-wrapper" style="display:block; margin:20px auto;">
				<input type="text" id="userName" name="userName" placeholder=" 이름" required>
			</div>
			<div class="input-wrapper" style="display:block; margin:20px auto;">
				<input type="text" id="userBirth" name="userBirth" placeholder=" 생년월일 8자리(ex.19001201)" required>
			</div>
			<div id="resultPwDiv" style="display: none; font-weight: bold; font-style: italic;">
				<p id="searchPwResult"></p>
			</div>
			<div style="display:block; margin:20px auto; padding-top:15px;">
				<button type="button" id="btnFindPw">확 인</button>
			</div>
			
			<div class="login_append">
	        <span class="txt_find">
	           <a href="/user/login.do" class="link_find">&nbsp;&nbsp;&nbsp;로그인</a>
	            |
	           <a href="/user/searchId.do" class="link_find">아이디 찾기</a>
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
			$("#btnFindPw").on("click", function() {
				console.log($("#searchPwForm").serialize());
				
				$.ajax({
					url: "/user/searchPw.do",
					type: "post",
					data: $("#searchPwForm").serialize(),
					success: function(obj) {
						const data = JSON.parse(obj);
						
						console.log(data);
						
						$("#resultPwDiv").show();
						
						if(data.msg == "ok") {
							$("#searchPwResult").text("비밀번호는 " + data.searchPw +" 입니다.");
						} else{
							$("#searchPwResult").text("아이디가 존재하지 않습니다.");
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