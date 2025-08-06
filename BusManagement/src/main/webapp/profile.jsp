<%@page import="com.bus.entities.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="error_page.jsp" %>
<%

Users user= (Users) session.getAttribute("currentUser");
if(user==null)
{
	response.sendRedirect("login.jsp");
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> 
 
</head>
<body>
	
    <nav class="navbar">
        <div class="container">
          <a href="./index.jsp" class="logo"><img src="./logo-removebg-preview.png" alt=""></a>
          <ul class="nav-links  ">
            <li><a href="./index.jsp">Home</a></li>
            <li><a href="./about.jsp">About</a></li>
       	    <li><a href="./contact.jsp">Contact</a></li>
          	<li><a href="./book-now.jsp">Book Now</a></li>
          
         	 <li><a href="./signup.jsp">Logout</a></li>
          
          </ul>
          <ul class="nav-links"><li>
           <li><a href="./signup.jsp"><span class="fa fa-user-circle"><%= user.getName() %></span></a></li>
        	<li> <a href="LogoutServlets" metod="post">Logout</a></li>
          </ul>
        </div>
      </nav>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>