<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.back-img {
	background: url("img/Home.jpg");
	width: 100%;
	height: 100vh;
	background-size: cover;
	background-attachment: fixed;
}
</style>

<meta charset="UTF-8">
<title>Home</title>
<%@include file="includes/allCss.jsp"%>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>
	<div class="container-fluid back-img">
		<div class="text-center">
			<h1 class="text-white"><span class="fa fa-book mt-4" aria-hidden="true"></span> E Notes-Save Your Notes</h1>
			<a href="login.jsp" class="btn btn-light mt-4"><span
				class="fa fa-user-circle " aria-hidden="true"></span> Login</a> <a href="registration.jsp"
				class="btn btn-light mt-4"><span class="fa fa-user-plus " aria-hidden="true"></span>
				 Register</a>
		</div>
	</div>
	<%@include file="/includes/footer.jsp"%>
</body>
</html>