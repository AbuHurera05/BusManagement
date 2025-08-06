<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Ensure the user is logged in
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
    <link href="css/responsive.css" rel="stylesheet" />
    <title>Add Bus</title>
    <style>
        /* General styling for add bus page */
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
        input, select, textarea {
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
    </style>
</head>
<body>

    <div class="admin-panel">
        <h2>Add New Bus</h2>
        <form action="process-add-bus.jsp" method="POST">
            <input type="text" name="busName" placeholder="Bus Name" required>
            <input type="text" name="busNumber" placeholder="Bus Number (e.g., B123)" required>
            <select name="busType" required>
                <option value="" disabled selected>Select Bus Type</option>
                <option value="Luxury">Luxury</option>
                <option value="Semi-Luxury">Semi-Luxury</option>
                <option value="Standard">Standard</option>
            </select>
            <textarea name="description" placeholder="Bus Description (e.g., Capacity, Amenities, etc.)" required></textarea>
            <input type="number" name="busSeats" placeholder="Bus Seats" required>
            <select name="busSector" >
                <option value="" disabled selected>Select Sector</option>
                <option value="Public">Public</option>
                <option value= "Private">Private</option>
                
            </select>
            <button type="submit" style="background-color: #28a745;">Add Bus</button>
        </form>
        <br><br>
        <a href="./adminPenal.jsp">
            <button>Back</button>
        </a>
    </div>

</body>
</html>
