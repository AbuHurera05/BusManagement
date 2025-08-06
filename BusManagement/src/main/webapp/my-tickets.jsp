<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String userEmail = (String) session.getAttribute("loggedInUser");
    if (userEmail == null) {
        response.sendRedirect("login-page.jsp"); 
        return;
    }

    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";
    
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    int userId = -1;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        // Get user ID from users table
        String userQuery = "SELECT id FROM users WHERE email = ?";
        stmt = conn.prepareStatement(userQuery);
        stmt.setString(1, userEmail);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            userId = rs.getInt("id");
        } else {
            response.sendRedirect("login-page.jsp");
            return;
        }
        rs.close();
        stmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tickets</title>
    <style>
        body { 
        font-family: Arial, sans-serif; background-color: #f4f7fa; text-align: center; }
        .container { max-width: 800px; margin: auto; padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
        h2 { color: #007bff; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        table th, table td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        table th { background-color: #007bff; color: white; }
        table tr:nth-child(even) { background-color: #f2f2f2; }
        .btn { margin-top: 20px; padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; }
        .btn:hover { background-color: #0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h2>My Booked Buses</h2>
    <table>
        <thead>
            <tr>
                <th>Passenger Name</th>
                <th>Contact</th>
                <th>Bus Name</th>
                <th>Booking Date</th>
                <th>Time</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    String query = "SELECT bookbus.passenger_name, bookbus.contact, buses.bus_name, bookbus.booking_date, bookbus.bookBusTime " +
                                   "FROM bookbus " +
                                   "INNER JOIN buses ON bookbus.bus_id = buses.id " +
                                   "WHERE bookbus.user_id = ?";
                    stmt = conn.prepareStatement(query);
                    stmt.setInt(1, userId);
                    rs = stmt.executeQuery();
                    boolean hasData = false;

                    while (rs.next()) {
                        hasData = true;
            %>
                        <tr>
                            <td><%= rs.getString("passenger_name") %></td>
                            <td><%= rs.getString("contact") %></td>
                            <td><%= rs.getString("bus_name") %></td>
                            <td><%= rs.getString("booking_date") %></td>
                            <td><%= rs.getString("bookBusTime") %></td>
                        </tr>
            <%
                    }
                    if (!hasData) {
            %>
                        <tr>
                            <td colspan="5" style="text-align: center;">No booked buses found</td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</div>

<h2>My Booked Tickets</h2>
<div class="container">
    <table>
        <thead>
            <tr>
                <th>Passenger Name</th>
                <th>Contact</th>
                <th>Route Name</th>
                <th>No. of Seats</th>
                <th>Booking Date</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    String query2 = "SELECT bookings.passenger_name, bookings.contact, routes.route_name, bookings.num_seats, bookings.booking_date " +
                                    "FROM bookings " +
                                    "INNER JOIN routes ON bookings.route_id = routes.id " +
                                    "WHERE bookings.user_id = ?";
                    stmt = conn.prepareStatement(query2);
                    stmt.setInt(1, userId);
                    rs = stmt.executeQuery();
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getString("passenger_name") %></td>
                            <td><%= rs.getString("contact") %></td>
                            <td><%= rs.getString("route_name") %></td>
                            <td><%= rs.getInt("num_seats") %></td>
                            <td><%= rs.getString("booking_date") %></td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</div>
<br><br>
<a href="index.jsp" class="btn">Go Back to Home</a>
</div>
</body>
</html>
