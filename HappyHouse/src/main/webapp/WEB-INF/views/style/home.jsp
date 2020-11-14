<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
* {
  box-sizing: border-box;
}

body {
  font-family: Arial;
  padding: 10px;
  background: #f1f1f1;
}

/* Header/Blog Title */
.header {
  padding: 30px;
  text-align: center;
  background: white;
}

.header h1 {
  font-size: 50px;
}

/* Style the top navigation bar */
.topnav {
  overflow: hidden;
  background-color: #333;
}

/* Style the topnav links */
.topnav a {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

/* Change color on hover */
.topnav a:hover {
  background-color: #ddd;
  color: black;
}

/* Create two unequal columns that floats next to each other */
/* Left column */
.leftcolumn {   
  float: left;
  width: 75%;
}

/* Right column */
.rightcolumn {
  float: left;
  width: 25%;
  background-color: #f1f1f1;
  padding-left: 20px;
}

/* Fake image */
.fakeimg {
  background-color: #aaa;
  width: 100%;
  padding: 20px;
}

/* Add a card effect for articles */
.card {
  background-color: white;
  padding: 20px;
  margin-top: 20px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Footer */
.footer {
  padding: 20px;
  text-align: left;
  background: #ddd;
  margin-top: 20px;
}

/* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 800px) {
  .leftcolumn, .rightcolumn {   
    width: 100%;
    padding: 0;
  }
}

/* Responsive layout - when the screen is less than 400px wide, make the navigation links stack on top of each other instead of next to each other */
@media screen and (max-width: 400px) {
  .topnav a {
    float: none;
    width: 100%;
  }
}

</style>
</head>
<body>
<div class="header">
  <h1>Happy House</h1>
  <p>행복한 우리집에 오신걸 환영합니다.</p>
</div>
<div class="topnav">
 <c:if test="${userinfo == null}">
  <a href="${root}/">홈</a>
  <a href="${root}/user/mvlogin">로그인</a>
  <a href="${root}/user/mvjoin">회원가입</a>
  <a href="${root}/apt/mvsearch">거래검색</a>
  <!--   <a href="${root}/notice.do?act=notice&pg=1">공지사항</a> -->
  <a href="${root}/sitemap">사이트맵</a>
  <a href="${root}/qna">질문 게시판</a>
  <a href="${root}/user.do?act=mvlogin" style="float:right">로그인을 해주세요!</a>

  </c:if>
  <c:if test="${userinfo != null}">
  <a href="${root}/">홈</a>
  <a href="${root}/user/logout">로그아웃</a>
  <a href="${root}/user/info">회원정보</a>
  <a href="${root}/apt/mvsearch">거래검색</a>
  <!-- <a href="${root}/notice.do?act=notice&pg=1">공지사항</a>-->
  <a href="${root}/sitemap">사이트맵</a>
  <a href="${root}/qna">질문 게시판</a>
  <a href="${root}/user/info.jsp" style="float:right" >${userinfo.id}(${userinfo.name})님 환영합니다!</a>
  </c:if>
</div>
</body>
</html>