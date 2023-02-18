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
		background-color: rgb(69, 185, 69);
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
		<form id="insertCmnt" action="/cmnt/insertCmnt.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="userId" value="${loginUser.userId}">
			<input type="hidden" name="userNickname" value="${loginUser.userNickname}">
			<table>
				<tr>
					<td style="text-align: left; width: 770px;">
						<input type="text" name="cmntTitle" id="cmntTitle" placeholder="제목">
					</td>
				</tr>
				<tr>
					<td style="text-align: left">
						<label id="userNickname">작성자 :&nbsp;&nbsp;${loginUser.userNickname}</label>
					</td>
				</tr>
				<tr>
					<td style="text-align: left; width: 770px; height: 500px; " class="marginTd">
						<textarea name="cmntContents" id="cmntContents" cols="110" rows="20" style="resize: none;"></textarea>
					</td>
				</tr>
				<tr>
					<td style="text-align: left">
						<div class="fileArea"><label for="cmntFile">이미지 업로드 :&nbsp;&nbsp;</label>
						<input type="file" id="btnAtt" name="uploadFiles"></div>
					</td>
				</tr>
			</table>
            <button type="button" id="btnList" class="acBtn1 btnleft" onclick="location.href='/cmnt/getCmntList.do'" >목록</button>
            <button type="submit" id="btnInsert" class="acBtn2 btnRight">등록</button>
		</form>
		<hr/>
	</div>
	</main><%-- 
	<div class="footer-wrap">
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp"></jsp:include>
	</div> --%>
</body>
<script>
		let uploadFiles = "";
	
		$(function() {
			$("#btnAtt").on("change", function(e) {
				const files = e.target.files;
			});
			
			$("#insertCmnt").on("submit", function() {
				dt = new DataTransfer();
				
				const file = uploadFiles;
				dt.items.add(file);
				
				$("#btnAtt").files = dt.files;
			});
		});
		
		// 미리보기 영역에 들어갈 img태그 생성 및 선택된 파일을 Base64 인코딩된 문자열 형태로
		// 미리보기가 가능하게 해줌
		function imageLoader(file) {
			uploadFiles.push(file);
			
			const reader = new FileReader();
			
			reader.onload = function(e) {
				// 이미지를 표출해줄 img태그 선언
				let img	= document.createElement("img");
				img.setAttribute("style", "width:100%; height: 100%; z-index: none;");
				
				// 이미지 파일인지 아닌지 체크
				if(file.name.toLowerCase().match(/(.*?)\.(jpg|jpeg|png|gif|svg|bmp)$/)) {
					// 이미지 파일 미리보기 처리
					img.src = e.target.result;
				} else {
					// 일반 파일 미리보기 처리
					img.src = "/images/defaultFileImg.png";
				}
				
				// 미리보기 영역에 추가
				// 미리보기 이미지 태그와 삭제버튼 그리고 파일명을 표출하는 p태그를 묶어주는 div 만들어서
				// 미리보기 영역에 추가
				$("#attZone").append(makeDiv(img, file));
			};
			
			// 파일을 Base64 인코딩된 문자열로 변경 
			reader.readAsDataURL(file);
		}
		
		// 미리보기 영역에 들어갈 div(img + button + p)를 생성하고 리턴
		function makeDiv(img, file) {
			// div 생성
			let div = document.createElement("div");
			div.setAttribute("style", "display: inline-block; position: relative;"
			+ " width: 150px; height: 120px; margin: 5px; border: 1px solid #00f; z-index: 1;");
			
			// button 생성
			let btn = document.createElement("input");
			btn.setAttribute("type", "button");
			btn.setAttribute("value", "x");
			btn.setAttribute("delFile", file.name);
			btn.setAttribute("style", "width: 30px; height: 30px; position: absolute;"
			+ " right: 0px; bottom: 0px; z-index: 999; background-color: rgba(255, 255, 255, 0.1);"
			+ " color: #f00;");
			
			// 버튼 클릭 이벤트
			// 버튼 클릭 시 해당 파일이 삭제되도록 설정
			btn.onclick = function(e) {
				// 클릭된 element
				const ele = e.srcElement;
				// delFile(파일이름) 속성 꺼내오기: 삭제될 파일명
				const delFile = ele.getAttribute("delFile");
		
				uploadFiles.slice;
				
				// 버튼 클릭 시 btnAtt에 첨부된 파일도 삭제
				// input type=file은 첨부된 파일들을 fileList 형태로 관리
				// fileList에 일반적인 File객체를 넣을 수 없고
				// DateTransfer라는 클래스를 이용하여 완전한 fileList 형태로 만들어서
				// input.files에 넣어줘야 된다.
				dt = new DataTransfer();
				

				const file = uploadFiles;
				dt.items.add(file);
				
				console.log($("#btnAtt"));
				$("#btnAtt").files = dt.files;
				
				// 해당 img를 담고 있는 부모태그인 div 삭제
				const parentDiv = ele.parentNode;
				$(parentDiv).remove();
			}
			
			// 파일명 표출할 p태그 생성
			const fName = document.createElement("p");
			fName.setAttribute("style", "display: inline-block; font-size: 8px;");			
			fName.textContent = file.name;
			
			// div에 하나씩 추가
			div.appendChild(img);
			div.appendChild(btn);
			div.appendChild(fName);
			
			// 완성된 div 리턴
			return div;
		}
	</script>

</html>