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
    String busName = "";
    String busNumber = "";
    String busType = "";
    String description = "";
    int busSeats = 0;
    String busSector = "";

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to fetch bus details
        String query = "SELECT * FROM buses WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, Integer.parseInt(busId));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            busName = rs.getString("bus_name");
            busNumber = rs.getString("bus_number");
            busType = rs.getString("bus_type");
            description = rs.getString("description");
            busSeats = rs.getInt("bus_seats");
            busSector = rs.getString("busSector");
        } else {
            out.println("<h2>Bus not found!</h2>");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
        return;
    } finally {
        // Close resources
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Bus</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        button:hover {
            background-color: #0056b3;
        }
        .back-button {
            margin-top: 15px;
            background-color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Edit Bus</h2>
        <form action="edit-bus.jsp" method="POST">
            <input type="hidden" name="id" value="<%= busId %>">

            <div class="form-group">
                <label for="busName">Bus Name:</label>
                <input type="text" id="busName" name="busName" value="<%= busName %>" required>
            </div>

            <div class="form-group">
                <label for="busNumber">Bus Number:</label>
                <input type="text" id="busNumber" name="busNumber" value="<%= busNumber %>" required>
            </div>

            <div class="form-group">
                <label for="busType">Bus Type:</label>
                <input type="text" id="busType" name="busType" value="<%= busType %>" required>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="3" required><%= description %></textarea>
            </div>

            <div class="form-group">
                <label for="busSeats">Seats:</label>
                <input type="number" id="busSeats" name="busSeats" value="<%= busSeats %>" required>
            </div>

            <div class="form-group">
                <label for="busSector">Sector:</label>
                <input type="text" id="busSector" name="busSector" value="<%= busSector %>" required>
            </div>

            <button type="submit">Update Bus</button>
            <button type="button" class="back-button" onclick="window.history.back()">Cancel</button>
        </form>
    </div>
    
   
<%
    // Ensure the admin is logged in
   

    // Retrieve form data
     busId = request.getParameter("id");
     busName = request.getParameter("busName");
     busNumber = request.getParameter("busNumber");
     busType = request.getParameter("busType");
     description = request.getParameter("description");
     String busS = request.getParameter("busSeats");
     busSector = request.getParameter("busSector");

    

   

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Update query to modify bus details
        String query = "UPDATE buses SET bus_name = ?, bus_number = ?, bus_type = ?, description = ?, bus_seats = ?, busSector = ? WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, busName);
        pstmt.setString(2, busNumber);
        pstmt.setString(3, busType);
        pstmt.setString(4, description);
        pstmt.setInt(5, Integer.parseInt(busS));
        pstmt.setString(6, busSector);
        pstmt.setInt(7, Integer.parseInt(busId));

        // Execute the update query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("view-buses.jsp?message=Bus updated successfully!");
        } else {
            out.println("<h2>Failed to update the bus. Please try again.</h2>");
            out.println("<a href='edit-bus.jsp?id=" + busId + "'>Back to Edit Bus</a>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
        out.println("<a href='edit-bus.jsp?id=" + busId + "'>Back to Edit Bus</a>");
    } finally {
        // Close resources
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
    
</body>
</html>
