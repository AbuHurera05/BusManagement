<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Ensure the user is logged in
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    if (loggedIn == null || !loggedIn) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bus List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            text-align: center;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #fff;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .edit-btn, .delete-btn {
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            color: white;
        }
        .edit-btn { background-color: #007bff; }
        .delete-btn { background-color: red; }
    </style>
</head>
<body>
    <h2>Bus List</h2>
    <table>
        <thead>
            <tr>
                <th>Bus Name</th>
                <th>Bus Number</th>
                <th>Type</th>
                <th>Description</th>
                <th>Sector</th>
                <th>Driver Name</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                    
                    String query = "SELECT b.id, b.bus_name, b.bus_number, b.bus_type, b.description, b.busSector, s.staffName "
                                 + "FROM buses b "
                                 + "LEFT JOIN staff s ON b.id = s.assignedBusID"; // Assuming staff has busId as foreign key
                    
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int busId = rs.getInt("id");
                        String busName = rs.getString("bus_name");
                        String busNumber = rs.getString("bus_number");
                        String busType = rs.getString("bus_type");
                        String description = rs.getString("description");
                        String busSector = rs.getString("busSector");
                        String driverName = rs.getString("staffName") != null ? rs.getString("staffName") : "No Driver Assigned";
            %>
            <tr>
                <td><%= busName %></td>
                <td><%= busNumber %></td>
                <td><%= busType %></td>
                <td><%= description %></td>
                <td><%= busSector %></td>
                <td><%= driverName %></td>
                <td>
                    <button class="edit-btn" onclick="location.href='edit-bus.jsp?id=<%= busId %>'">Edit</button>
                    <button class="delete-btn" onclick="if(confirm('Are you sure?')) location.href='delete-bus.jsp?id=<%= busId %>'">Delete</button>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='7'>Error loading buses: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>
</body>
</html>
