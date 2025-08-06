<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    if (loggedIn == null || !loggedIn) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    String action = request.getParameter("action");
    String routeName = "", startLocation = "", endLocation = "", busName = "";
    int routeId = 0;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Database connection parameters
        String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        if ("edit".equals(action)) {
            routeId = Integer.parseInt(request.getParameter("id"));
            String query = "SELECT * FROM routes WHERE id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, routeId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                routeName = rs.getString("route_name");
                startLocation = rs.getString("start_location");
                endLocation = rs.getString("end_location");
                busName = rs.getString("bus_name");
            }
        } else if ("update".equals(action)) {
            routeId = Integer.parseInt(request.getParameter("id"));
            routeName = request.getParameter("routeName");
            startLocation = request.getParameter("startLocation");
            endLocation = request.getParameter("endLocation");
            busName = request.getParameter("busName");

            if (routeName == null || startLocation == null || endLocation == null || busName == null) {
                throw new Exception("Required fields are missing.");
            }

            String updateQuery = "UPDATE routes SET route_name = ?, start_location = ?, end_location = ?, bus_name = ? WHERE id = ?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, routeName);
            pstmt.setString(2, startLocation);
            pstmt.setString(3, endLocation);
            pstmt.setString(4, busName);
            pstmt.setInt(5, routeId);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("view-routes.jsp?message=Route updated successfully!");
                return;
            } else {
                out.println("<h2>Failed to update the route. Please try again.</h2>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

<% if ("edit".equals(action)) { %>
<div>
    <h2>Edit Route</h2>
    <form action="edit-route.jsp?action=update" method="POST">
        <input type="hidden" name="id" value="<%= routeId %>">
        <input type="text" name="routeName" placeholder="Route Name" value="<%= routeName %>" required>
        <input type="text" name="startLocation" placeholder="Start Location" value="<%= startLocation %>" required>
        <input type="text" name="endLocation" placeholder="End Location" value="<%= endLocation %>" required>
        <input type="text" name="busName" placeholder="Bus Name" value="<%= busName %>" required>
        <button type="submit">Update Route</button>
    </form>
</div>
<% } %>
