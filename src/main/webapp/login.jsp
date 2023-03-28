<%@page import="com.notes.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
<!--css-->
<%@include file="includes/allCss.jsp"%>
</head>
<body>

	<!--navbar-->
	<%@include file="/includes/navbar.jsp"%>


	<main class="d-flex align-items-center div-colorl"
		style="height: 70vh">
		<div class="container">
			<div class="row">
				<div class="col-md-4 offset-md-4 ">

					<div class="card">
						<div class="card-header primary-background text-white text-center">
							<span class="fa fa-user-plus fa-3x"></span> <br>
							<p>Login here</p>
						</div>
						<%
						Message m = (Message) session.getAttribute("msg");
						if (m != null) {
						%>
						<div class="alert <%=m.getCssClass()%>" role="alert">
							<%=m.getContent()%>
						</div>
						<%
						session.removeAttribute("msg");
						}
						%>
						


						<div class="card-body">
							<form action="LoginController" method="post">
								<div class="form-group">
									<label for="exampleInputEmail1">Email address</label> <input
										name="email" required type="email" class="form-control"
										id="exampleInputEmail1" aria-describedby="emailHelp"
										placeholder="Enter email"> <small id="emailHelp"
										class="form-text text-muted">We'll never share your
										email with anyone else.</small>
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1">Password</label> <input
										name="password" required type="password" class="form-control"
										id="exampleInputPassword1" placeholder="Password">
								</div>

								<div class="container text-center">
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!--javascripts-->
	<%@include file="/includes/footer.jsp"%>
</body>
</html>