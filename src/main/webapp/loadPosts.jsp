<%@page import="com.notes.entities.User"%>
<%@page import="com.notes.entities.Post"%>
<%@page import="com.notes.entities.Message"%>
<%@page import="java.util.List"%>
<%@page import="com.notes.helper.ConnectionProvider"%>
<%@page import="com.notes.dao.PostDao"%>
<div class="row">

	<%
	User uuu = (User) session.getAttribute("currentUser");
	PostDao d = new PostDao(ConnectionProvider.getConnection());
	List<Post> posts = null;
	posts = d.getAllPosts();
	if (posts.size() == 0) {
		out.println("<h3 class='display-3 text-center'>No Posts in this category..</h3>");
		return;
	}

	for (Post p : posts) {
	%>

	<div class="col-md-6 mt-2">
		<div class="card">
			<img class="card-img-top" src="blog_pics/<%=p.getpPic()%>"
				alt="Card image cap">
			<div class="card-body">
				<b><%=p.getpTitle()%></b> <br>
				<p><%=p.getpContent()%></p>

			</div>
			<div class="card-footer primary-background text-center">



				<a href="show_blog_page.jsp?post_id=<%=p.getPid()%>"
					class="btn btn-outline-light btn-sm">Read More...</a> <a href="#!"
					class="btn btn-outline-light btn-sm"> <i
					class="fa fa-commenting-o"></i> <span>20</span>
				</a>
			</div>

		</div>


	</div>


	<%
	}
	%>

</div>