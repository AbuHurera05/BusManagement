   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Ensure the admin is logged in
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    if (loggedIn == null || !loggedIn) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    // Retrieve staff ID
    String staffId = request.getParameter("id");
    if (staffId == null) {
        response.sendRedirect("view-staff.jsp");
        return;
    }

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String staffName = "", staffContact = "", staffAddress = "", staffAge = "", staffGender = "", staffImage = "";

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to fetch staff details
        String query = "SELECT * FROM staff WHERE staffId = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, Integer.parseInt(staffId));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            staffName = rs.getString("staffName");
            staffContact = rs.getString("staffContact");
            staffAddress = rs.getString("staffAdress");
            staffAge = rs.getString("staffAge");
            staffGender = rs.getString("staffGender");
            staffImage = rs.getString("staffImg");
        } else {
            response.sendRedirect("view-staff.jsp");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("view-staff.jsp?error=Error fetching staff details");
        return;
    } finally {
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
    <title>Edit Staff</title>
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
    <form action="edit-staff.jsp" method="POST">
        <input type="hidden" name="id" value="<%= staffId %>">
        
        <label>Staff Name:</label>
        <input type="text" name="staffName" value="<%= staffName %>" required>

        <label>Age:</label>
        <input type="number" name="staffAge" value="<%= staffAge %>" required>

        <label>Gender:</label>
        <select name="staffGender" required>
            <option value="Male" <%= "Male".equals(staffGender) ? "selected" : "" %>>Male</option>
            <option value="Female" <%= "Female".equals(staffGender) ? "selected" : "" %>>Female</option>
        </select>

        <label>Address:</label>
        <input type="text" name="staffAddress" value="<%= staffAddress %>" required>

        <label>Contact:</label>
        <input type="text" name="staffContact" value="<%= staffContact %>" required>

        <label>Image URL:</label>
        <input type="text" name="staffImage" value="<%= staffImage %>" required>

        <button type="submit">Update Staff</button>
    </form>
</body>
</html>

<%
    // Handle the update process
    String staffNameInput = request.getParameter("staffName");
    String staffAgeInput = request.getParameter("staffAge");
    String staffGenderInput = request.getParameter("staffGender");
    String staffAddressInput = request.getParameter("staffAddress");
    String staffContactInput = request.getParameter("staffContact");
    String staffImageInput = request.getParameter("staffImage");

    if (staffNameInput != null) {
        try {
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            String updateQuery = "UPDATE staff SET staffName = ?, staffAge = ?, staffGender = ?, staffAdress = ?, staffContact = ?, staffImg = ? WHERE staffId = ?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, staffNameInput);
            pstmt.setInt(2, Integer.parseInt(staffAgeInput));
            pstmt.setString(3, staffGenderInput);
            pstmt.setString(4, staffAddressInput);
            pstmt.setString(5, staffContactInput);
            pstmt.setString(6, staffImageInput);
            pstmt.setInt(7, Integer.parseInt(staffId));

            int rowsUpdated = pstmt.executeUpdate();
            response.sendRedirect("view-staff.jsp?message=Staff updated successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit-staff.jsp?id=" + staffId + "&error=Update failed");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>
