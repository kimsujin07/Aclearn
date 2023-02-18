<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지(회원정보 수정)</title>
<style>
	main {
		margin-top: 5rem;
	}
	
	h2 {
		padding-bottom: 10px;
	}
	
 	.form-wrapper {
      	text-align: center;
      	margin: 100px auto; 
	}
   	
 	#updateMyInfoForm {
   		width: 700px;
		margin: 50px auto;
    }
    
   	.input-wrapper {
   		margin-top: 20px;
   		margin-left: 180px;
   		padding-bottom: 5px;
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size : 13px;
      	font-weight: bold;
   	}
   	
   	#updateMyInfoForm input {
     	height:35px;
  	 }

   	#btnEdit {
      	width: 165px; 
      	height:40px;
      	background-color:black;
		color:white;
		font-size: 16px;
		font-weight: bold;
   	}
   	#btnQuit {
      	width: 165px; 
      	height:40px;
      	background-color:black;
		color:white;
		font-size: 16px;
		font-weight: bold;
   	}
   	
</style>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
	<main>
		<div class="form-wrapper">
			<form id="updateMyInfoForm" action="/user/updateMyInfo.do" method="post">
			<input type="hidden" id="msg" value="${msg }">
			<h2>회원정보 수정</h2>
			<div class="input-area">
				<div class="input-wrapper" >
					<label for="userId" >아이디</label>
				</div>
				<div>
					<input type="text" id="userId" name="userId" value="${loginUser.userId }" size="50"
							placeholder="아이디고정" required readonly>
				</div>
				<div class="input-wrapper" >
					<label for="userCurrentPw">현재 비밀번호</label>
				</div>
				<div>
					<input type="password" id="userCurrentPw" name="userCurrentPw" size="50"
							placeholder="영문, 숫자, 특수문자 조합으로 8~16자리" >
				</div>
				<p id="userCurrentPwResult" style="color:red; font-size:0.7rem;">
				현재 비밀번호를 입력해주세요.
				</p>
				<div class="input-wrapper" >
					<label for="userPw">새 비밀번호</label>
				</div>
				<div>
					<input type="password" id="userPw" name="userPw" size="50"
							placeholder="영문, 숫자, 특수문자 조합으로 8~16자리" >
				</div>
				<p id="pwValidation" style="color:red; font-size:0.7rem;">
					비밀번호는 영문, 숫자, 특수문자 조합의 8~16자리로 설정해주세요.
				</p>
				<div class="input-wrapper" >
					<label for="userPwCheck">새 비밀번호 확인</label>
				</div>
				<div>
					<input type="password" id="userPwCheck" name="userPwCheck" size="50"
					 		placeholder="영문, 숫자, 특수문자 조합으로 8~16자리">
				</div><br>
				<p id="pwCheckResult" style="font-size:0.8rem;">
				</p>
				<div class="input-wrapper" >
					<label for="userName">이름</label>
				</div>
				<div>
					<input type="text" id="userName" name="userName" size="50" 
							placeholder="이름" value="${loginUser.userName }">
				</div>
				<div class="input-wrapper" >
					<label for="userNickname">닉네임</label>
				</div>
				<div>		
					<input type="text" id="userNickname" name="userNickname" size="38"
							placeholder="영문, 한글, 숫자 조합으로 2~10자리" value="${loginUser.userNickname }">
					<button type="button" id="btnNickCheck" style="width: 70px; height: 40px;">중복체크</button>
				</div>
				<p id="nickValidation" style="color:red; font-size:0.5rem;">
					닉네임은 영문, 한글, 숫자 조합의 2~10자리로 설정해주세요.
				</p>
				<div class="input-wrapper" >
					<label for="userBirth">생년월일</label>
				</div>
				<div>
					<input type="text" id="userBirth" name="userBirth" size="50" 
							placeholder="생년월일 8자리(ex.19001201)" value="${loginUser.userBirth }">
				</div><br>
				<div style="display: block; margin: 10px auto;">
					<button type="submit" id="btnEdit">수 정</button>
					<button type="button" id="btnQuit" >탈 퇴</button>
				</div>

			</div>
		</form>
		</div>
	</main>
	<div class="footer-wrap">
		<jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
	</div>
	<script>
		// 비밀번호 유효성 검사 - 영문, 숫자, 특수문자 조합으로 8~16자리
		function validatePassword(character){
			return /^(?=.*[a-zA-Z])(?=.*[!@#$%^&*+=-])(?=.*[0-9]).{8,16}$/.test(character);
		}
		
		$(function() {
			if($("#msg").val() != null && $("#msg").val() != '') {
				if($("#msg").val() == "editOk")
					alert("수정 성공");
				else
					alert("수정 실패");
			}
			
			// 현재 비밀번호
			var currentPwCheck = false;
			var userCurrentPwResult = false;
			
			// 비밀번호가 형식에 맞는지
			var pwValidation = false;
			// 비밀번호 확인란과 일치하는지
			var pwCheck = false;
			// 이름 중복체크
			var nameCheck = true;
			// 닉네임 중복체크
			var nicknameCheck = true;
			// 닉에임이 형식에 맞는지
			var nickValidation = false;
			
	
			$("#userCurrentPwResult").hide();
			$("#pwValidation").hide();
			$("#pwCheckResult").hide();
			$("#nickValidation").hide();
			$("#btnNickCheck").attr("disabled", true);
			
			
			//현재 비밀번호에서 커서가 나왔을때, 현재 비밀번호가 맞는 지 검사
			$("#userCurrentPw").on("change", function(){
				$("#userCurrentPwResult").show();
				
				$.ajax({
					url: '/user/checkCurrentPw.do',
					type: 'post',
					data: {
						userId: $("#userId").val(),
						userPw: $("#userCurrentPw").val()
					},
					success: function(obj) {
						console.log(obj);
						if(obj == "checkFail") {
							
							$("#userCurrentPwResult").css("color", "red");
							$("#userCurrentPwResult").text("현재 비밀번호와 일치하지 않습니다.");
							currentPwCheck = false;
							
						} else {
						
							$("#userCurrentPwResult").css("color", "green");
							$("#userCurrentPwResult").text("현재 비밀번호와 일치합니다.");
							currentPwCheck = ture;
						}
					},
					error: function(e) {
						console.log(e);
					}
					
				});
			});
			
			// 비밀번호 입력될때마다 유효성 검사
			$("#userPw").on("change",function(){
				// 비밀번호 유효성 처리
				if(!validatePassword($("#userPw").val())){
					pwValidation = false;
					$("#pwValidation").show();
					$("#userPw").focus();
				} else {
					pwValidation = true;
					$("#pwValidation").hide();
				}
				
				// 비밀번호 확인까지 입력한 후 다시 비밀번호 재설정할 경우
				if($("#userPw").val() == $("#userPwCheck").val()){
					pwCheck = true;
					$("#pwCheckResult").css("color", "green");
					$("#pwCheckResult").text("비밀번호가 일치합니다.");
				} else {
					pwCheck = false;
					$("#pwCheckResult").css("color", "red");
					$("#pwCheckResult").text("비밀번호가 일치하지 않습니다.");
				}
			});
			
			// 비밀번호 확인란 입력할 때 일치하는지
			$("#userPwCheck").on("change", function(){
				$("#pwCheckResult").show();
				
				if($("#userPw").val() == $("#userPwCheck").val()){
					pwCheck = true;
					$("#pwCheckResult").css("color", "green");
					$("#pwCheckResult").text("비밀번호가 일치합니다.");
				} else {
					pwCheck = false;
					$("#pwCheckResult").css("color", "red");
					$("#pwCheckResult").text("비밀번호가 일치하지 않습니다.");
				}
			});
			
			$("#userNickname").on("change", function(){
			// 닉네임 중복체크
				$("#btnNickCheck").attr("disabled", false);
				$("#btnNickCheck").on("click",function(){
					$.ajax({
						url: '/user/nicknameCheck.do',
						type: 'post',
						data: $("#updateMyInfoForm").serialize(),
						success: function(obj){
							console.log(obj);
							
							if(obj == 'duplicatedNickname'){
								alert("중복된 닉네임 입니다.");
								$("#userNickname").focus();
							
							} else {
								if(confirm("사용 가능한 닉네임 입니다. '" + $("#userNickname").val() + 
										"'를(을) 사용하시겠습니까?")) {
									nicknameCheck = true;
									$("#btnNickCheck").attr("disabled", true);
									
								}
							}
						},
						error: function(e){
							console.log(e);
						}
					})
				});
			});
			
			// 닉네임 중복체크 후 다시 변경
			$("#userNickname").on("change",function(){
				nicknameCheck = false;
				$("#btnNickCheck").attr("disabled", false);
			});
			
			// 닉넴 유효성 - 영문, 한글, 숫자 조합으로 2~10자리
			$("#userNickname").on("change", function(){
				var regexNick = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,10}$/;
				var resultNick = regexNick.exec($("#userNickname").val());
				
				  if(resultNick != null){
					  $("#nickValidation").hide(); 
		           }else{
		        	   $("#nickValidation").show();
						   $("#userNickname").focus();
		           }
			});
			
			// 회원탈퇴
			$("#btnQuit").click(function(){
			    if(confirm("회원탈퇴 하시겠습니까?") == true){
			        alert("탈퇴되었습니다");
			        location.href=("quitUser.do?userId=${loginUser.userId}");
			    }
			    else{
			        return false;
			    }
			});
			 
			// 수정버튼 클릭시 진행
			$("#updateMyInfoForm").on("submit", function(e){
				if(confirm("수정하시겠습니까?")) {
					if($("#userPw").val() != null && $("#userPw").val() != '') {
						// 비밀번호 유효성 검사가 틀렸을 때 
						if(!pwValidation){
							alert("영문, 숫자, 특수문자 조합의 8~16자리로 설정하세요.");
							$("#userPw").focus();
							e.preventDefault();
							return;
						}
						//번호 재확인이 일치하지 않을 때
						if(!pwCheck) {
							alert("비밀번호가 일치하지 않습니다.");
							$("#userPwCheck").focus();
							e.preventDefault();
							return;
						}
						//현재 비밀번호가 틀렸을 떄
						if(!currentPwCheck) {
							alert("현재 비밀번호가 일치하지 않습니다.");
							$("#currentPwCheck").focus();
							e.preventDefault();
							return;
						}
					}
					
					// 닉네임 중복체크
					if(!nicknameCheck) {
						alert("닉네임 중복체크를 진행하세요.");
						$("#userNickname").focus();
						e.preventDefault();
						return false;
					} 
					// 모두 true일 경우 아무것도 작성하지 X
				} else {
					e.preventDefault();
					alert("취소하셨습니다.");
					return;
				}
			});
		
		});
	</script>
</body>
</html>