<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%

    // Logged-in user email
    String userEmail = (String) session.getAttribute("loggedInUser");
    if (userEmail == null || userEmail.isEmpty()) {
        out.println("<script>alert('Error: Please log in first!'); window.location.href='user_login.jsp';</script>");
        return;
    }

    // Retrieve form parameters
    String routeId = request.getParameter("route_id");
    String passengerName = request.getParameter("passengerName");
    String contact = request.getParameter("contact");
    String numSeats = request.getParameter("numSeats");

    if (routeId == null || passengerName == null || contact == null || numSeats == null) {
        out.println("<h3 style='color:red;'>Error: Missing required data!</h3>");
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
    int availableSeats = 0;
    int bookedSeats = Integer.parseInt(numSeats);

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
            out.println("<script>alert('Error: User not found!'); window.location.href='user_login.jsp';</script>");
            return;
        }
        rs.close();
        stmt.close();

        // ✅ Get current available seats
        String query = "SELECT b.bus_seats FROM buses b JOIN routes r ON r.bus_name = b.bus_name WHERE r.id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, Integer.parseInt(routeId));
        rs = stmt.executeQuery();

        if (rs.next()) {
            availableSeats = rs.getInt("bus_seats");
        }
        rs.close();
        stmt.close();

        // ✅ Check if enough seats are available
        if (availableSeats >= bookedSeats) {
            // ✅ Update available seats in the buses table
            String updateSeatsQuery = "UPDATE buses b JOIN routes r ON r.bus_name = b.bus_name SET b.bus_seats = b.bus_seats - ? WHERE r.id = ?";
            stmt = conn.prepareStatement(updateSeatsQuery);
            stmt.setInt(1, bookedSeats);
            stmt.setInt(2, Integer.parseInt(routeId));
            int rowsUpdated = stmt.executeUpdate();
            stmt.close();

            if (rowsUpdated > 0) {
                // ✅ Insert booking details into bookings table
                String bookingQuery = "INSERT INTO bookings (route_id, passenger_name, contact, num_seats, user_id) VALUES (?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(bookingQuery);
                stmt.setInt(1, Integer.parseInt(routeId));
                stmt.setString(2, passengerName);
                stmt.setString(3, contact);
                stmt.setInt(4, bookedSeats);
                stmt.setInt(5, userId); // Insert user's ID
                stmt.executeUpdate();
                stmt.close();

                out.println("<h3 style='color:green;'>Booking Confirmed!</h3>");
                out.println("<p>Thank you, " + passengerName + ". Your booking has been saved.</p>");
                out.println("<p><strong>Contact:</strong> " + contact + "</p>");
                out.println("<p><strong>Number of Seats:</strong> " + bookedSeats + "</p>");
                out.println("<p><strong>Route ID:</strong> " + routeId + "</p>");
                out.println("<p><strong>Remaining Seats in Bus:</strong> " + (availableSeats - bookedSeats) + "</p>");
            } else {
                out.println("<h3 style='color:red;'>Error: Unable to update bus seats.</h3>");
            }
        } else {
            out.println("<h3 style='color:red;'>Error: Not enough seats available!</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
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
            color: green;
        }
        .details {
            margin-top: 20px;
            font-size: 16px;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>Booking Confirmation</h3>
        <p>Your booking has been successfully saved in our system.</p>

        <div class="details">
            <p><strong>Passenger Name:</strong> <%= passengerName %></p>
            <p><strong>Contact:</strong> <%= contact %></p>
            <p><strong>Number of Seats:</strong> <%= numSeats %></p>
            <p><strong>Route ID:</strong> <%= routeId %></p>
        </div>

        <a href="index.jsp" class="btn">Go Back to Home</a>
    </div>
</body>
</html>
