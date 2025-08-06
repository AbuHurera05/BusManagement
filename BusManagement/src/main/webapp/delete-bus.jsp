<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Ensure the admin is logged in
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    if (loggedIn == null || !loggedIn) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    // Retrieve the bus ID from the request
    String busId = request.getParameter("id");

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Delete query to remove the bus from the database
        String query = "DELETE FROM buses WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, Integer.parseInt(busId));

        // Execute the delete query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("view-buses.jsp?message=Bus deleted successfully!");
        } else {
            out.println("<h2>Failed to delete the bus. Please try again.</h2>");
            out.println("<a href='view-buses.jsp'>Back to View Buses</a>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
        out.println("<a href='view-buses.jsp'>Back to View Buses</a>");
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
