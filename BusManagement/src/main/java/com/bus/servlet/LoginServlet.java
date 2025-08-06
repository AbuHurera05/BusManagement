package com.bus.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.bus.dao.UserDao;
import com.bus.entities.Message;
import com.bus.entities.Users;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
//	
//    public LoginServlet() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	
//    
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}
//
//	/**
//	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
//	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
//		doGet(request, response);
		response.setContentType("text/html");
		try(PrintWriter out = response.getWriter();) {
            // Output HTML content
            out.println("<html>");
            out.println("<head><title>Servlet Example</title></head>");
            out.println("<body>");
            
            // login
//             	fetch usernaem and password
            String userEmail= request.getParameter("email");
            String userPassword= request.getParameter("password");
            
            UserDao dao=new UserDao(MyConnectionTest.getConnection());
            Users user=dao.getUserByEmailAndPassword(userEmail, userPassword);
            if(user== null) 
            {
            	
            	Message msg = new Message("Invalid Details ! try with another","errr","alert-danger");
            	HttpSession s = request.getSession();
            	s.setAttribute("msg", msg);
            	response.sendRedirect("login-pagejsp");
            } else 
            {
            	//....
            	// login succes
            	
            	HttpSession s=request.getSession();
            	s.setAttribute("currentUser", user);
            	response.sendRedirect("profile.jsp");
            	
            }
            
            out.println("</body>");
            out.println("</html>");
    
    }
	}

}
