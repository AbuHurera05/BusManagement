<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    	Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    	if (loggedIn == null || !loggedIn) {
    		response.sendRedirect("admin_login.jsp");
        return;
    	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Routes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            text-align: center;
        }

        h2 {
            margin-top: 20px;
        }

        /* Table Styling */
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
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

        td {
            color: #333;
        }

        /* Buttons */
        .edit-btn, .delete-btn {
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
        }

        .edit-btn {
            background-color: #007bff;
        }

        .edit-btn:hover {
            background-color: #0056b3;
        }

        .delete-btn {
            background-color: red;
        }

        .delete-btn:hover {
            background-color: darkred;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            table {
                width: 100%;
                font-size: 14px;
            }
            th, td {
                padding: 8px;
            }
        }
        .back-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
            width: 99%;
            border-radius: 30px;
        }
        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <h2>Routes List</h2>

    <table>
        <thead>
            <tr>
                <th>Route Name</th>
                <th>Start Location</th>
                <th>End Location</th>
                <th>Bus Name</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Database connection
                    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
                    String dbUser = "root";
                    String dbPassword = "root";
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    // Fetching routes
                    String query = "SELECT id, route_name, start_location, end_location, bus_name FROM routes";
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int routeId = rs.getInt("id");
                        String routeName = rs.getString("route_name");
                        String startLocation = rs.getString("start_location");
                        String endLocation = rs.getString("end_location");
                        String busName = rs.getString("bus_name");
            %>
            <tr>
                <td><%= routeName %></td>
                <td><%= startLocation %></td>
                <td><%= endLocation %></td>
                <td><%= busName %></td>
                <td>
                    <button class="edit-btn" onclick="location.href='edit-route.jsp?id=<%= routeId %>'">Edit</button>
                    <button class="delete-btn" onclick="if(confirm('Are you sure you want to delete this route?')) location.href='delete-route.jsp?id=<%= routeId %>'">Delete</button>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='5'>Error loading routes: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>
	 <!-- Back Button -->
    <div style="text-align: center;">
        <button class="back-button" onclick="window.history.back()">Back</button>
    </div>
</body>
</html>
