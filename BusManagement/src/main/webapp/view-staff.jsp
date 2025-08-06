<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>View Staff</title>
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

        img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 5px;
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

    <h2>Staff List</h2>

    <table>
        <thead>
            <tr>
                <th>Image</th>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Address</th>
                <th>Contact</th>
                <th>Assigned Bus</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                int totalStaff = 0;

                try {
                    // Database connection
                    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
                    String dbUser = "root";
                    String dbPassword = "root";
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    // Fetching staff details along with assigned bus
                    String query = "SELECT s.staffId, s.staffName, s.staffAge, s.staffGender, s.staffAdress, s.staffContact, s.staffImg, b.bus_number " +
                                   "FROM staff s " +
                                   "LEFT JOIN buses b ON s.assignedBusID = b.id";

                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        totalStaff++;
            %>
            <tr>
                <td><img src="<%= rs.getString("staffImg") %>" alt="<%= rs.getString("staffName") %>"></td>
                <td><%= rs.getString("staffName") %></td>
                <td><%= rs.getInt("staffAge") %></td>
                <td><%= rs.getString("staffGender") %></td>
                <td><%= rs.getString("staffAdress") %></td>
                <td><%= rs.getString("staffContact") %></td>
                <td><%= (rs.getString("bus_number") != null) ? rs.getString("bus_number") : "Not Assigned" %></td>
                <td>
                    <button class="edit-btn" onclick="location.href='edit-staff.jsp?id=<%= rs.getInt("staffId") %>'">Edit</button>
                    <button class="delete-btn" onclick="if(confirm('Are you sure you want to delete this staff?')) location.href='delete-staff.jsp?id=<%= rs.getInt("staffId") %>'">Delete</button>
                </td>
            </tr>
            <%
                    }
                    session.setAttribute("totalStaff", totalStaff);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='8'>Error fetching staff details: " + e.getMessage() + "</td></tr>");
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
