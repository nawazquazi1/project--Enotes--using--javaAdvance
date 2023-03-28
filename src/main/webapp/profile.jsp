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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Profile</title>




<!--css-->
<%@include file="includes/allCss.jsp"%>
<style>
body {
	background: url(img/bg.jpeg);
	background-size: cover;
	background-attachment: fixed;
}
</style>
</head>
<body>
	<!--navbar-->

	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="profile.jsp"> <span
			class="fa fa-asterisk"></span> Tech Blog
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
						class="	fa fa-bell-o"></span> Techblog<span class="sr-only">(current)</span></a>
				</li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="	fa fa-check-square-o"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>

				<li class="nav-item"><a class="nav-link" href="#"> <span
						class="	fa fa-address-card-o"></span> Contact
				</a></li>

				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#add-post-modal"> <span
						class="	fa fa-asterisk"></span> Do Post
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

	<!--main body of the page-->

	<main>
		<div class="container">
			<div class="row mt-4">
				<!--first col-->


				<!--second col-->
				<div class="col-md-8">
					<!--posts-->
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>

					<div class="container-fluid" id="post-container"></div>
				</div>

			</div>

		</div>

	</main>


	<!--end main body of the page-->


	<!--profile modal-->
	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
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
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">EDIT</button>
				</div>
			</div>
		</div>
	</div>


	<!--end of profile modal-->

	<!--add post modal-->



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

				<!--  END add post modal-->
				<script>
					$(document).ready(function() {
						let editStatus = false;
						$('#edit-profile-button').click(function() {
							if (editStatus == false) {
								$("#profile-details").hide()
								$("#profile-edit").show();
								editStatus = true;
								$(this).text("Back")
							} else {
								$("#profile-details").show()
								$("#profile-edit").hide();
								editStatus = false;
								$(this).text("Edit")
							}
						})
					});
				</script>
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
															event
																	.preventDefault();
															console
																	.log("you have clicked on submit..")
															let form = new FormData(
																	this);
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
																			if (data
																					.trim() == 'done') {
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


				<!--loading post using ajax -->
				<script>
					function getPosts(catId, temp) {
						$("#loader").show();
						$("#post-container").hide()
						$(".c-link").removeClass('active')
						$.ajax({
							url : "loadPosts.jsp",
							data : {
								cid : catId
							},
							success : function(data, textStatus, jqXHR) {
								console.log(data);
								$("#loader").hide();
								$("#post-container").show();
								$('#post-container').html(data)
								$(temp).addClass('active')
							}
						})
					}
					$(document).ready(function(e) {
						let allPostRef = $('.c-link')[0]
						getPosts(0, allPostRef)
					})
				</script>

				<%@include file="/includes/footer.jsp"%>
</body>
</html>