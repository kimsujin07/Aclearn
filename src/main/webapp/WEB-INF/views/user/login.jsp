<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	#loginForm {
		width: 460px;
		text-align: center;
		margin: 50px auto;
	}
	#loginForm input {
		width: 300px;
		height:40px;
		
	}	
	input::placeholder {
  		font-size: 15px;
  		font-style: italic;
	}	
	#btnLogin {
		width: 310px;
		height: 43px;
		background-color:black;
		color:white;
		font-size: 15px;
		font-weight: bold;
	}
	.entire-wrap {
   		justify-content: end;
   	}
</style>
</head>

<body>
	<div class="entire-wrap" style="justify-content: end;">
	<jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
	<main>
	<div class="form-wrapper">
		<form id="loginForm">
			<h3>AC LEARN</h3>
			<div class="input-wrapper" style="display:block; margin:20px auto;">
				<input type="text" id="userId" name="userId" placeholder=" ID" required>
			</div>
			<div class="input-wrapper" style="display:block; margin:20px auto;">
				<input type="password" id="userPw" name="userPw" placeholder=" Password" required>
			</div>
			<div style="display:block; margin:20px auto;">
				<button type="button" id="btnLogin">LOGIN</button>
			</div>
			
			<div class="login_append">
	        <span class="txt_find">
	           <a href="/user/searchId.do" class="link_find">아이디 찾기</a>
	            |
	           <a href="/user/searchPw.do" class="link_find">비밀번호 찾기</a>
	            |
	           <a href="/user/join.do" class="link_find">회원가입</a>
	         </span>
	       </div>
				
		</form>
	</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
	</div>
</body>
	<script>
      $(function() {
         //회원가입 성공 시 메시지 출력
         if($("#joinMsg").val() != "" && $("#joinMsg").val() != null) {
            alert($("#joinMsg").val());
         }
         
         //로그인 시 아이디나 비밀번호가 틀렸을 경우에 대비하여 폼 서브밋 대신 ajax로 처리
         $("#btnLogin").on("click", function() {
            $.ajax({
               url: "/user/login.do",
               type: "post",
               data: $("#loginForm").serialize(),
               success: function(obj) {
                  console.log(obj);
                  if(obj =="idFail") {
                     alert("존재하지 않는 아이디입니다.");
                     $("#userId").focus();
                     return;
                  }
                  
                  if(obj == "pwFail") {
                     alert("비밀번호가 틀렸습니다. 비밀번호를 확인해주세요");
                     $("#userPw").focus();
                     return;
                  }
                  // 로그인 성공시 홈화면으로 처리
                  location.href="/index.jsp";
               },
               error: function(e) {
                  console.log(e);
               }
            });
         });
      });
   </script>

</html>