package com.notes.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.notes.dao.PostDao;
import com.notes.entities.Post;
import com.notes.entities.User;
import com.notes.helper.ConnectionProvider;
import com.notes.helper.Helper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jakarta.servlet.annotation.MultipartConfig;

import jakarta.servlet.http.Part;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			/* TODO output your page here. You may use following sample code. */

			int cid = Integer.parseInt(request.getParameter("cid"));
			String pTitle = request.getParameter("pTitle");
			String pContent = request.getParameter("pContent");
			String pCode = request.getParameter("pCode");
			Part part = request.getPart("pic");
//            getting currentuser id
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("currentUser");

//            out.println("your post title is " + pTitle);
//            out.println(part.getSubmittedFileName());
			Post p = new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), null, cid, user.getId());
			PostDao dao = new PostDao(ConnectionProvider.getConnection());
			if (dao.savePost(p)) {

				String path = request.getRealPath("/") + "blog_pics" + File.separator + part.getSubmittedFileName();
				Helper.saveFile(part.getInputStream(), path);
				out.println("done");
			} else {
				out.println("error");
			}

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
