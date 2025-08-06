<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
    // Database connection settings
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    int totalRoutes = 0;
    int totalBuses = 0;
    int totalTickets = 0;
    int totalStaff = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        stmt = conn.createStatement();

        // Fetch total routes
        rs = stmt.executeQuery("SELECT COUNT(*) FROM routes");
        if (rs.next()) {
            totalRoutes = rs.getInt(1);
        }

        // Fetch total buses
        rs = stmt.executeQuery("SELECT COUNT(*) FROM buses");
        if (rs.next()) {
            totalBuses = rs.getInt(1);
        }

        // Fetch total tickets
        rs = stmt.executeQuery("SELECT COUNT(*) FROM bookings");
        if (rs.next()) {
            totalTickets = rs.getInt(1);
        }

        // Fetch total staff
        rs = stmt.executeQuery("SELECT COUNT(*) FROM staff");
        if (rs.next()) {
            totalStaff = rs.getInt(1);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
<%
    // Check if the user is logged in
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");

    if (loggedIn == null || !loggedIn) {
        // If not logged in, redirect to admin login page
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<style>
	.logout-button {
    background: none;
    border: none;
    color: inherit;
    font-size: inherit;
    cursor: pointer;
    text-decoration: none;
    padding: 0;
}

.logout-button:hover {
    color: blue;
    text-decoration: underline;
}
	
</style>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - Bus Management System</title>
  <link rel="stylesheet" href="./css/admin.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <link href="css/responsive.css" rel="stylesheet" />
</head>
<body>
  <!-- Sidebar -->
  <div class="sidebar">
    <div class="sidebar-header">
      <h2>Admin Panel</h2>
    </div>
    <ul class="sidebar-menu">
      <li><a href="./adminPenal.jsp">Dashboard</a></li>
      <li><a href="./add-routes.jsp">Route Management</a></li>
      <li><a href="./add-new-bus.jsp">Bus Management</a></li>
      <li><a href="./add-staff.jsp">Staff Management</a></li>
      
      <!-- Logout Button -->
      <form action="logout.jsp" method="post" style="display: inline;">
      <li> <button type="submit" class="logout-button">Logout</button></li>
        
    </form>

    </ul>
  </div>

  <!-- Main Content -->
  <div class="main-content">
    <header>
      <div class="header">
        <h1>Admin Dashboard</h1>
        <div class="user-info"></div>
      </div>
    </header>

    <section class="dashboard-stats">
      <div class="stat-card">
        <h3>Total Routes</h3>
        <p><%= totalRoutes %></p>
    </div>
    <div class="stat-card">
        <h3>Total Buses</h3>
        <p><%= totalBuses %></p>
    </div>
    <div class="stat-card">
        <h3>Total Tickets</h3>
        <p><%= totalTickets %></p>
    </div>
    <div class="stat-card">
        <h3>Total Staff</h3>
        <p><%= totalStaff %></p>
    </div>
    </section>

    <section class="quick-links">
      <h2>Quick Actions</h2>
      <div class="quick-links-container">
        <div class="link-card">
          <a href="./view-routes.jsp">View Routes</a>
        </div>
        <div class="link-card">
          <a href="./view-buses.jsp">View Buses</a>
        </div>
        <div class="link-card">
          <a href="./view-tickets.jsp">View Tickets</a>
        </div>
        <div class="link-card">
          <a href="./view-staff.jsp">View Staff</a>
        </div>
      </div>
    </section>
  </div>

  
</body>
</html>
