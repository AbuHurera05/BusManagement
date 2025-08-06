<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    	Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    	if (loggedIn == null || !loggedIn) {
        response.sendRedirect("admin-login.jsp");
        return;
    	}
%>
<%
    int routeId = Integer.parseInt(request.getParameter("id"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Database connection
        String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Delete route query
        String query = "DELETE FROM routes WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, routeId);

        int rowsDeleted = pstmt.executeUpdate();

        if (rowsDeleted > 0) {
            response.sendRedirect("view-routes.jsp");
        } else {
            out.println("<h2>Failed to delete the route. Please try again.</h2>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
