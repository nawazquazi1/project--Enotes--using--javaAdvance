package com.notes.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.notes.dao.UserDao;
import com.notes.entities.Message;
import com.notes.entities.User;
import com.notes.helper.ConnectionProvider;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet LoginServlet</title>");
			out.println("</head>");
			out.println("<body>");
//          login 
//          fetch username and password from request
			String userEmail = request.getParameter("email");
			String userPassword = request.getParameter("password");

			UserDao dao = null;
			try {
				dao = new UserDao(ConnectionProvider.getConnection());
				User u = dao.getUserByEmailAndPassword(userEmail, userPassword);
				if (u == null) {
					// login.................
//                    error///
//                    out.println("Invalid Details..try again");
					Message msg = new Message("Invalid Details ! try with another", "error", "alert-danger");
					HttpSession s = request.getSession();
					s.setAttribute("msg", msg);
					response.sendRedirect("login.jsp");
				} else {
					// ......
//                    login success
					HttpSession s = request.getSession();
					s.setAttribute("currentUser", u);
					response.sendRedirect("profile.jsp");
				}
			} catch (ClassNotFoundException | SQLException e) {
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
		processRequest(request, response);
	}

	@Override
	public String getServletInfo() {
		return "Short description";
	}

}
