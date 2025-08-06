<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%
    // Ensure the user is logged in
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    if (loggedIn == null || !loggedIn) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem"; // Replace with your database name
    String dbUser = "root"; // Replace with your database username
    String dbPassword = "root"; // Replace with your database password

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Fetch buses from the database
    List<String> buses = new ArrayList<>();
    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to fetch buses
        String query = "SELECT bus_name FROM buses WHERE busSector = 'Public'"; // Assuming 'buses' table has a 'bus_name' column
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            buses.add(rs.getString("bus_name"));
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error fetching buses: " + e.getMessage() + "</h2>");
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Routes</title>
    <style>
        /* General styling for the form and page */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
        }
        .admin-panel {
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 50px auto;
            width: 50%;
        }
        input, select {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
         label {
            font-size: 16px;
            color: #333;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
    </style>
</head>
<body>

    <div class="admin-panel">
        <h2>Add New Route</h2>
        <form action="process-add-route.jsp" method="POST">
            <input type="text" name="routeName" placeholder="Route Name (e.g., City Center to Airport)" required>
            <input type="text" name="startLocation" placeholder="Start Location" required>
            <input type="text" name="endLocation" placeholder="End Location" required>
            <input type="time" name="startTime" placeholder="Start Time" required>
            <input type="time" name="reachTime" placeholder="Reach Time" required>
            
            <select name="busName" >
                <option value="" disabled selected>Select Bus</option>
                <%
                    for (String bus : buses) {
                        out.println("<option value='" + bus + "'>" + bus + "</option>");
                    }
                %>
            </select>
            <div class="form-group">
                <label for="description">Route Description</label>
                <textarea id="description" name="description" rows="4" placeholder="Enter Description (optional)"></textarea>
            </div>
            
            <button type="submit" style="background-color: #28a745;">Add Route</button>
        </form>
        <br><br>
        <a href="./adminPenal.jsp">
            <button>Back</button>
        </a>
    </div>

</body>
</html>
