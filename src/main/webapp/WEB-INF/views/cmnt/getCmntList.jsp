<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"><meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACLearn - Community</title>
<style>
    main { 
		width: 1200px;
		margin: 100px auto;
	}
    #title{ 
       margin-top: 50px;
       margin-bottom:50px;}
    #container { 
       margin: 0 auto; 
       text-align: center;
    }
    td { padding: 10px; }
    th { height: 30px; }
    #cmntRegdate { float: right; }
   .acBtn2 {
      color: white;
      background-color: rgb(69, 185, 69);
      border: 0;
      width: 90px; height: 40px;
      margin: 0 0 0 10px;
      border-radius: 3px;
      font-weight: bold;
      font-size: 16px;
      
   }
   .searchSelect { width: 90px; height: 30px;}
   .textBox1 { height: 24px;}
   .acBtn3 {
      color: white;
      background-color: rgb(69, 185, 69);
      border: 0;
      border-radius: 3px;
      
      
   }
   .cmntSearchBtn{
      width: 40px; height: 30px;
      margin: 0 0 0 3px;
   }
   .listLink {
      text-decoration: none;
      color: black;
      font-weight: bold; 
   }
   #btnSearch{
      width: 45px;
   }
   
</style>
</head>
<body>
	<div class="entire-wrap">
    <jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
    <main>
   <div style="display: flex; flex-direction: column; justify-content: center; align-items: center;" id="container">
      <h1 id="title">Community</h1>
      <form id="searchForm" action="/cmnt/getCmntList.do" method="post">
         <table border="1" style="width: 800px; border-collapse: collapse; border:0px">
            <tr>
               <td align="right">
                  <select name="searchCondition" class="searchSelect" >
                     <option value="all"
                        <c:if test="${searchCondition eq 'all' || searchCondition eq '' || searchCondition eq null}">
                           selected = "selected"
                        </c:if>
                     >전체</option>
                     <option value="title"
                        <c:if test="${searchCondition eq 'title'}">
                           selected = "selected"
                        </c:if>
                     >제목</option>
                     <option value="content"
                        <c:if test="${searchCondition eq 'content'}">
                           selected = "selected"
                        </c:if>
                     >내용</option>
                     <option value="writer"
                        <c:if test="${searchCondition eq 'writer'}">
                           selected = "selected"
                        </c:if>
                     >작성자</option>
                  </select>
                  <input type="text" class="textBox1" name="searchKeyword" value="${searchKeyword}" size="27">
                  <button type="submit" id="btnSearch" class="acBtn3 cmntSearchBtn" >검색</button>
               </td>
            </tr>
         </table>
      </form>
      
      <table id="cmntTable" border="1" style="width: 800px; border-collapse: collapse;">
         <tr>
            <th width="5%">번호</th>
            <th width="50%">제목</th>
            <th width="12%">작성자</th>
            <th width="25%">작성일</th>
            <th width="8%">조회수</th> 
         </tr>
         <c:forEach items="${cmntList}" var="cmnt">
         <tr>
            <td style="text-align: center;">${cmnt.cmntCode}</td>
            <td><a href="/cmnt/updateCmntCnt.do?cmntCode=${cmnt.cmntCode}" class="listLink">${cmnt.cmntTitle}</a></td>
            <td style="text-align: center;">${cmnt.userNickname}</td>
            <td style="text-align: center;">${cmnt.cmntRegdate}</td>
            <td style="text-align: center;">${cmnt.cmntCnt}</td>
         <tr>
         </c:forEach>
      </table>
      <br>
      
        <button type="button" class="acBtn2" onclick="location.href='/cmnt/insertCmnt.do'">등 록</button>
   </div>
   </main>
   <jsp:include page="${pageContext.request.contextPath}/footer.jsp"></jsp:include>
   </div>
</body>
</html>