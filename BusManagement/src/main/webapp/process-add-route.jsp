<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Ensure the user is logged in
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    if (loggedIn == null || !loggedIn) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    // Retrieve form data
    String routeName = request.getParameter("routeName");
    String startLocation = request.getParameter("startLocation");
    String endLocation = request.getParameter("endLocation");
    String startTime = request.getParameter("startTime");
    String reachTime = request.getParameter("reachTime");
   
    String busName = request.getParameter("busName");
    String description = request.getParameter("description");
    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem"; // Replace with your database name
    String dbUser = "root"; // Replace with your database username
    String dbPassword = "root"; // Replace with your database password

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Insert query to save route
        String query = "INSERT INTO routes (route_name, start_location, end_location, start_time, reach_time, bus_name, route_description) VALUES (?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, routeName);
        pstmt.setString(2, startLocation);
        pstmt.setString(3, endLocation);
        pstmt.setString(4, startTime);
        pstmt.setString(5, reachTime);
        pstmt.setString(6, busName);
        pstmt.setString(7, description);
        
        
              

        // Execute the query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("view-routes.jsp");
        } else {
            out.println("<h2>Failed to add the route. Please try again.</h2>");
            out.println("<a href='add-routes.jsp'>Back to Add Routes</a>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
        out.println("<a href='add-routes.jsp'>Back to Add Routes</a>");
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
