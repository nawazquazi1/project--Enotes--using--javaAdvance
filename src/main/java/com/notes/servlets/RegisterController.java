package com.notes.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.notes.dao.UserDao;
import com.notes.entities.User;
import com.notes.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/newa")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
//            fetch all form data
			String name = request.getParameter("user_name");
			String email = request.getParameter("user_email");
			String password = request.getParameter("user_password");
			String gender = request.getParameter("gender");
			String about = request.getParameter("about");
			// create user object and set all data to that object..
			User user = new User(name, email, password, gender, about);

			// create a user dao object..
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			if (dao.saveUser(user)) {
				request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "failed");
			}
			request.getRequestDispatcher("registration.jsp").forward(request, response);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	public String getServletInfo() {
		return "Short description";
	}

}
