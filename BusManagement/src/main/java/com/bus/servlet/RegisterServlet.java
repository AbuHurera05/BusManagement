package com.bus.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.bus.dao.UserDao;
import com.bus.entities.Users;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//   
//    public RegisterServlet() {
//        super();
//        
//    }
//
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
//		doGet(request, response);
		response.setContentType("text/html");

        // Create a PrintWriter to send output to the client
        

        try(PrintWriter out = response.getWriter();) {
            // Output HTML content
            out.println("<html>");
            out.println("<head><title>Servlet Example</title></head>");
            out.println("<body>");
           
            String name= request.getParameter("name");
            String email=request.getParameter("email");
            String phone=request.getParameter("contact");
            String password=request.getParameter("password");
            
            String ageStr= request.getParameter("age");
            String gender=request.getParameter("gender");
            
            int age = 0;
            try {
                age = Integer.parseInt(ageStr); // Convert to integer
            } catch (NumberFormatException e) {
                out.println("<p>Error: Invalid age format</p>");
                return;
            }
            
            Users user=new Users(name,email,gender,age,phone,password);
           
            	
                
//                create user dao object
                UserDao dao= new UserDao(MyConnectionTest.getConnection());
                if(dao.saveUser(user)) 
                {
                	out.print("done");
                }else
                {
                	out.print("error");
                }
                
                out.println("</body>");
                out.println("</html>");
        
        }
                
            
            
           
            
           
    } 
}


