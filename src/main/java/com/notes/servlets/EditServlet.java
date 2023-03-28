package com.notes.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.notes.dao.UserDao;
import com.notes.entities.Message;
import com.notes.entities.User;
import com.notes.helper.ConnectionProvider;
import com.notes.helper.Helper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			/* TODO output your page here. You may use following sample code. */
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet EditServlet</title>");
			out.println("</head>");
			out.println("<body>");

//            fetch all data
			String userEmail = request.getParameter("user_email");
			String userName = request.getParameter("user_name");
			String userPassword = request.getParameter("user_password");
			String userAbout = request.getParameter("user_about");
			Part part = request.getPart("image");

			String imageName = part.getSubmittedFileName();

			// get the user from the session...
			HttpSession s = request.getSession();
			User user = (User) s.getAttribute("currentUser");
			user.setEmail(userEmail);
			user.setName(userName);
			user.setPassword(userPassword);
			user.setAbout(userAbout);
			String oldFile = user.getProfile();

			user.setProfile(imageName);

			// update database....
			UserDao userDao = null;
			try {
				userDao = new UserDao(ConnectionProvider.getConnection());
				boolean ans = userDao.updateUser(user);
				if (ans) {

					String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();
					// start of photo work
					// delete code
					String pathOldFile = request.getRealPath("/") + "pics" + File.separator + oldFile;

					if (!oldFile.equals("default.png")) {
						Helper.deleteFile(pathOldFile);
					}
					if (Helper.saveFile(part.getInputStream(), path)) {
						out.println("Profile updated...");
						Message msg = new Message("Profile details updated...", "success", "alert-success");
						s.setAttribute("msg", msg);
					} else {
						Message msg = new Message("Something went wrong..", "error", "alert-danger");
						s.setAttribute("msg", msg);
					}
					out.println("done");
				} else {
					out.println("not updated..");
					Message msg = new Message("Something went wrong..", "error", "alert-danger");
					s.setAttribute("msg", msg);
				}

				response.sendRedirect("profile.jsp");

			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			out.println("</body>");
			out.println("</html>");
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
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String userEmail = request.getParameter("user_email");
			String userName = request.getParameter("name");
			String userPassword = request.getParameter("user_password");
			String userAbout = request.getParameter("user_about");
			Part part = request.getPart("image");

			String imageName = part.getSubmittedFileName();

			// get the user from the session...
			HttpSession s = request.getSession();
			User user = (User) s.getAttribute("currentUser");
			user.setEmail(userEmail);
			user.setName(userName);
			user.setPassword(userPassword);
			user.setAbout(userAbout);
			String oldFile = user.getProfile();

			user.setProfile(imageName);

			// update database....
			UserDao userDao = null;
			try {
				userDao = new UserDao(ConnectionProvider.getConnection());
				boolean ans = userDao.updateUser(user);
				if (ans) {

					String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();
					// start of photo work
					// delete code
					String pathOldFile = request.getRealPath("/") + "pics" + File.separator + oldFile;
					if (!oldFile.equals("default.png")) {
						Helper.deleteFile(pathOldFile);
					}

					if (Helper.saveFile(part.getInputStream(), path)) {
						out.println("Profile updated...");
						Message msg = new Message("Profile details updated...", "success", "alert-success");
						s.setAttribute("msg", msg);

					} else {
						//////////////
						Message msg = new Message("Something went wrong..", "error", "alert-danger");
						s.setAttribute("msg", msg);
					}

					// end of phots work
					out.println("Profile updated...");
					Message msg = new Message("Profile details updated...", "success", "alert-success");
					s.setAttribute("msg", msg);
				} else {
					out.println("not updated..");
					Message msg = new Message("Something went wrong..", "error", "alert-danger");
					s.setAttribute("msg", msg);
				}

				response.sendRedirect("profile.jsp");

			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				out.println(e.getMessage());
				e.printStackTrace();
			}
		}

	}

	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
