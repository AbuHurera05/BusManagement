<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page errorPage="error_page.jsp" %>
<%
    // Ensure the user is logged in
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    if (loggedIn == null || !loggedIn) {
    	response.sendRedirect("admin_login.jsp");
        return;
    }

    // Retrieve form data
    String busName = request.getParameter("busName");
    String busNumber = request.getParameter("busNumber");
    String busType = request.getParameter("busType");
    String description = request.getParameter("description");
    String busSeats = request.getParameter("busSeats");
    String busSector = request.getParameter("busSector");

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

        // Insert query to save bus details
        String query = "INSERT INTO buses (bus_name, bus_number, bus_type, description, bus_seats,busSector) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, busName);
        pstmt.setString(2, busNumber);
        pstmt.setString(3, busType);
        pstmt.setString(4, description);
        pstmt.setInt(5, Integer.parseInt(busSeats));
        pstmt.setString(6, busSector);

        // Execute the query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
        	response.sendRedirect("view-buses.jsp?message=Route updated successfully!");
        } else {
            out.println("<h2>Failed to add the bus. Please try again.</h2>");
            out.println("<a href='add-bus.jsp'>Back to Add Bus</a>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
        out.println("<a href='add-bus.jsp'>Back to Add Bus</a>");
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
