<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원정보수정</title>
<%@ include file="../style/page.jsp"%>
<script type="text/javascript">
	function modifyInfo() {
		if ($("#name").val() == "") {
			alert("이름 입력!!!");
			return;
		} else if ($("#password").val() == "") {
			alert("비밀번호 입력!!!");
			return;
		} else if ($("#password").val() != $("#pwdcheck").val()) {
			alert("비밀번호 확인!!!");
			return;
		} else {
			document.getElementById("memberform").action = "${root}/user/modify";
			document.getElementById("memberform").submit();
		}
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<div class="col-lg-6" align="center">
			<form id="memberform" method="post" action="">
				<input type="hidden" name="act" id="act" value="modify">
				<div class="form-group" align="left">
					<input type="hidden" name="id" id="id"
						value="${userinfo.id}">
				</div>
				<div class="form-group" align="left">
					<label for="name">이름</label> <input type="text"
						class="form-control" id="name" name="name"
						value="${userinfo.name}">
				</div>
				<div class="form-group" align="left">
					<label for="">비밀번호</label> <input type="password"
						class="form-control" id="password" name="password" placeholder="">
				</div>
				<div class="form-group" align="left">
					<label for="">비밀번호재입력</label> <input type="password"
						class="form-control" id="pwdcheck" name="pwdcheck" placeholder="">
				</div>
				<div class="form-group" align="left">
					<label for="">전화번호</label> <input type="text" class="form-control"
						id="phone" name="phone" placeholder="" 	value="${userinfo.phone}">
				</div>
				<div class="form-group" align="left">
					<label for="">주소</label><br> <input type="text"
						class="form-control" id="addr" name="addr" placeholder=""
						value = "${userinfo.addr}">
				</div>
				<div class="form-group" align="center">
					<button type="button" class="btn btn-primary" id="registerBtn"
						onclick="javascript:modifyInfo();">수정완료</button>
					<button type="reset" class="btn btn-warning">초기화</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>