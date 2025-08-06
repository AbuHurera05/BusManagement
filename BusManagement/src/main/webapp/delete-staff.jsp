<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Ensure the admin is logged in
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    if (loggedIn == null || !loggedIn) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    // Retrieve staff ID from the request
    String staffId = request.getParameter("id");

    if (staffId != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Database connection parameters
            String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
            String dbUser = "root";
            String dbPassword = "root";

            // Load JDBC driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Delete query to remove staff by ID
            String query = "DELETE FROM staff WHERE staffId = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(staffId));

            // Execute the delete query
            int rowsAffected = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }

    // Redirect back to view-staff.jsp
    response.sendRedirect("view-staff.jsp");
%>
