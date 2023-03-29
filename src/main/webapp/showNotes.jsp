<%@page import="com.notes.entities.User"%>
<%@page import="com.notes.entities.Post"%>
<%@page import="com.notes.entities.Message"%>
<%@page import="java.util.List"%>
<%@page import="com.notes.helper.ConnectionProvider"%>
<%@page import="com.notes.dao.PostDao"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Notes</title>
<%@include file="includes/allCss.jsp"%>
</head>
<body>

	<!--navbar-->

	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="profile.jsp"> <span
			class="fa fa-book"></span> E Notes
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"> <span
						class="fa fa-address-card-o"></span> Contact<span class="sr-only">(current)</span></a>
				</li>

				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#add-post-modal"> <span
						class="	fa fa-asterisk"></span> Add Notes
				</a></li>
			</ul>

			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile-modal"> <span
						class="fa fa-user-circle "></span> <%=user.getName()%>
				</a></li>

				<li class="nav-item"><a class="nav-link" href="LogoutServlet">
						<span class="fa fa-user-plus "></span> Logout
				</a></li>
			</ul>
		</div>
	</nav>



	<!--end of navbar-->

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

	<main>
		<div class="container">
			<h2 class="text-center">All Notes</h2>
			<div class="row">
				<div class="col-md-12">
					<div class="card mt-3">
						<img alt="" src="img/paper.png" class="card-img-top mt-2 mx-auto"
							style="max-width: 100px;" />
						<div class="card-body p-4">
							<h5 class="card-title"></h5>
							<p></p>

							<p>   
							<b class="text-success">published by: </b><br><b
							class="text-primary"></b>
							</p>
							
							<div class="container text-center mt-2">
							<a href="" class="btn btn-damger">Delete</a>
							</div>
							
							<div class="container text-center mt-2">
							<a href="" class="btn btn-damger">Edite</a>
							</div>
						</div>

					</div>

				</div>
			</div>

		</div>

	</main>



	<!--profile modal-->
	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">Notes</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfile()%>" class="img-fluid"
							style="border-radius: 50%; max-width: 150px;"> <br>
						<h5 class="modal-title mt-3" id="exampleModalLabel">
							<%=user.getName()%>
						</h5>
						<!--//details-->

						<div id="profile-details">
							<table class="table">

								<tbody>
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>

									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getAbout()%></td>

									</tr>
									<tr>
										<th scope="row">Registered on :</th>
										<td><%=user.getDateTime().toString()%></td>

									</tr>
								</tbody>
							</table>
						</div>

						<!--profile edit-->

						<div id="profile-edit" style="display: none;">
							<h3 class="mt-2">Please Edit Carefully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>ID :</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td>Email :</td>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<td>Name :</td>
										<td><input type="text" class="form-control" name="name"
											value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td>Password :</td>
										<td><input type="password" class="form-control"
											name="user_password" value="<%=user.getPassword()%>">
										</td>
									</tr>
									<tr>
										<td>Gender :</td>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<td>About :</td>
										<td><textarea rows="3" class="form-control"
												name="user_about"><%=user.getAbout()%>
                                                </textarea></td>
									</tr>
									<tr>
										<td>New Profile:</td>
										<td><input type="file" name="image" class="form-control">
										</td>
									</tr>

								</table>
								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>

							</form>

						</div>

					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>

				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						post details..</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form id="add-post-form" action="AddPostServlet" method="post"
						enctype="multipart/form-data">

						<div class="form-group">
							<input name="pTitle" type="text" placeholder="Enter note Title"
								class="form-control" />
						</div>

						<div class="form-group">
							<textarea name="pContent" class="form-control"
								style="height: 200px;" placeholder="Enter your content"></textarea>
						</div>
						<div class="form-group">
							<textarea name="pCode" class="form-control"
								style="height: 200px;" placeholder="Enter your program (if any)"></textarea>
						</div>
						<div class="form-group">
							<label>Select your pic..</label> <br> <input type="file"
								name="pic">
						</div>

						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Add
							</button>
						</div>

					</form>


				</div>

			</div>
		</div>
	</div>

	<!--  END add post modal-->
	<!--now add post js -->
	<script>
		$(document)
				.ready(
						function(e) {
							//
							$("#add-post-form")
									.on(
											"submit",
											function(event) {
												//this code gets called when form is submitted....
												event.preventDefault();
												console
														.log("you have clicked on submit..")
												let form = new FormData(this);
												//now requesting to server
												$
														.ajax({
															url : "AddPostServlet",
															type : 'POST',
															data : form,
															success : function(
																	data,
																	textStatus,
																	jqXHR) {
																//success ..
																console
																		.log(data);
																if (data.trim() == 'done') {
																	swal(
																			"Good job!",
																			"saved successfully",
																			"success");
																} else {
																	swal(
																			"Error!!",
																			"Something went wrong try again...",
																			"error");
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																//error..
																swal(
																		"Error!!",
																		"Something went wrong try again...",
																		"error");
															},
															processData : false,
															contentType : false
														})
											})
						})
	</script>

	<%@include file="/includes/footer.jsp"%>

</body>
</html>