<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%

    // Logged-in user email
    String userEmail = (String) session.getAttribute("loggedInUser");
    if (userEmail == null || userEmail.isEmpty()) {
        out.println("<script>alert('Error: Please log in first!'); window.location.href='login-page.jsp';</script>");
        return;
    }

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    int userId = -1;  // Default value

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // ✅ Get user ID from the users table using email
        String userQuery = "SELECT id FROM users WHERE email = ?";
        stmt = conn.prepareStatement(userQuery);
        stmt.setString(1, userEmail);
        rs = stmt.executeQuery();

        if (rs.next()) {
            userId = rs.getInt("id");
        } else {
            out.println("<script>alert('Error: User not found!'); window.location.href='login-page.jsp';</script>");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        return;
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
    }

    // Get the route_id from the request parameter
    String routeId = request.getParameter("route_id");
    if (routeId == null || routeId.isEmpty()) {
        out.println("<h3 style='color:red;'>Error: Route ID is missing!</h3>");
        return;
    }

    String routeName = "";
    int remainingSeats = 0;

    try {
        // Query to fetch route and bus details using bus_name
        String query = "SELECT r.route_name, b.bus_seats " +
                       "FROM routes r " +
                       "JOIN buses b ON r.bus_name = b.bus_name " +
                       "WHERE r.id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(routeId));
        rs = stmt.executeQuery();

        if (rs.next()) {
            routeName = rs.getString("route_name");
            remainingSeats = rs.getInt("bus_seats");
        } else {
            out.println("<h3 style='color:red;'>Error: Route not found!</h3>");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        return;
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Ticket</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 50%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        h3 {
            text-align: center;
        }
        label {
            display: block;
            margin-top: 10px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>Book Ticket for Route: <%= routeName %></h3>
        <p><strong>Remaining Seats:</strong> <%= remainingSeats %></p>
        <form action="confirm_booking.jsp" method="POST">
            <input type="hidden" name="route_id" value="<%= routeId %>">
            <input type="hidden" name="user_id" value="<%= userId %>">
            <input type="hidden" name="remaining_seats" value="<%= remainingSeats %>">

            <label for="passengerName">Passenger Name:</label>
            <input type="text" id="passengerName" name="passengerName" required>

            <label for="contact">Contact:</label>
            <input type="text" id="contact" name="contact" required>

            <label for="numSeats">Number of Seats:</label>
            <input type="number" id="numSeats" name="numSeats" min="1" max="<%= remainingSeats %>" required>

            <button type="submit">Confirm Booking</button>
        </form>
    </div>
</body>
</html>
