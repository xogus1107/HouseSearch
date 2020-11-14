<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사이트맵</title>
<%@ include file="../style/page.jsp"%>
</head>
<body>
	<div align="center">
		<br>
		<h2>사이트맵</h2>
		<br><a href="${root}/apt/mvsearch"><strong> -거래검색</strong></a>
		<br><br><a href="${root}/qna"><strong>-질문 게시판</strong></a>
	</div>
</body>
</html>