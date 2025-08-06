<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page errorPage="error_page.jsp" %>
<%@ page import="java.sql.*" %>

<%
    String userEmail = (String) session.getAttribute("loggedInUser");
    if (userEmail == null || userEmail.isEmpty()) {
        out.println("<script>alert('Error: Please log in first!'); window.location.href='login-page.jsp';</script>");
        return;
    }

    // بس کی ID حاصل کریں
    String id = request.getParameter("id");
    if (id == null || id.isEmpty()) {
        out.println("<script>alert('Error: Bus ID is missing or invalid!'); window.location.href='index.jsp';</script>");
        return;
    }

    int busId = -1;
    try {
        busId = Integer.parseInt(id);
    } catch (NumberFormatException e) {
        out.println("<script>alert('Error: Invalid Bus ID format!'); window.location.href='index.jsp';</script>");
        return;
    }

    // ڈیٹا بیس کنکشن کی تفصیلات
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement userStmt = null;
    PreparedStatement checkStatusStmt = null;
    PreparedStatement insertStmt = null;
    PreparedStatement updateStmt = null;
    ResultSet rs = null;

    int userId = -1; // یوزر ID اسٹور کرنے کے لیے

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // یوزر کی ID نکالنے کے لیے query
        String userQuery = "SELECT id FROM users WHERE email = ?";
        userStmt = conn.prepareStatement(userQuery);
        userStmt.setString(1, userEmail);
        rs = userStmt.executeQuery();

        if (rs.next()) {
            userId = rs.getInt("id"); // یوزر کی ID حاصل کریں
        } else {
            out.println("<script>alert('Error: User not found!'); window.location.href='login-page.jsp';</script>");
            return;
        }

        // چیک کریں کہ بس بک ہو چکی ہے یا نہیں
        String checkStatusQuery = "SELECT status FROM buses WHERE id = ?";
        checkStatusStmt = conn.prepareStatement(checkStatusQuery);
        checkStatusStmt.setInt(1, busId);
        rs = checkStatusStmt.executeQuery();

        if (rs.next()) {
            String status = rs.getString("status");
            if ("Booked".equalsIgnoreCase(status)) {
                out.println("<script>alert('Error: This bus is already booked!'); window.location.href='index.jsp';</script>");
                return;
            }
        } else {
            out.println("<script>alert('Error: Bus not found!'); window.location.href='index.jsp';</script>");
            return;
        }

        // اگر فارم سبمٹ ہوا ہے
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String passengerName = request.getParameter("passengerName");
            String cnic = request.getParameter("cnic");
            String address = request.getParameter("address");
            String bookingDate = request.getParameter("bookingDate");
            String contact = request.getParameter("contact");

            if (passengerName == null || cnic == null || address == null || bookingDate == null || contact == null ||
                passengerName.isEmpty() || cnic.isEmpty() || address.isEmpty() || bookingDate.isEmpty() || contact.isEmpty()) {
                out.println("<script>alert('Error: All fields are required!'); window.location.href='book-ticket.jsp?id=" + busId + "';</script>");
                return;
            }

            // `bookbus` ٹیبل میں بکنگ کا اندراج کریں
            String insertQuery = "INSERT INTO bookbus (id, passenger_name, cnic, contact, address, booking_date, user_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setInt(1, busId);
            insertStmt.setString(2, passengerName);
            insertStmt.setString(3, cnic);
            insertStmt.setString(4, contact);
            insertStmt.setString(5, address);
            insertStmt.setString(6, bookingDate);
            insertStmt.setInt(7, userId); // user_id شامل کریں

            int rowsInserted = insertStmt.executeUpdate();

            if (rowsInserted > 0) {
                // بس کا اسٹیٹس اپڈیٹ کریں
                String updateQuery = "UPDATE buses SET status = 'Booked' WHERE id = ?";
                updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, busId);
                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<script>alert('Bus successfully booked!'); window.location.href='index.jsp';</script>");
                    return;
                } else {
                    out.println("<script>alert('Error: Unable to update bus status.'); window.location.href='index.jsp';</script>");
                    return;
                }
            } else {
                out.println("<script>alert('Error: Unable to insert booking details.'); window.location.href='index.jsp';</script>");
                return;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='index.jsp';</script>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (userStmt != null) userStmt.close();
            if (checkStatusStmt != null) checkStatusStmt.close();
            if (insertStmt != null) insertStmt.close();
            if (updateStmt != null) updateStmt.close();
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
    <title>Book Ticket</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
        }
        .booking-form {
            width: 50%;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        input, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="booking-form">
        <h2>Book Bus: <%= busId %></h2>
        <form method="POST" action="book-ticket.jsp?id=<%= busId %>">
            <input type="text" name="passengerName" placeholder="Your Name" required>
            <input type="text" name="cnic" placeholder="CNIC" required>
            <input type="text" name="contact" placeholder="Contact Number" required>
            <input type="text" name="address" placeholder="Your Address" required>
            <input type="date" name="bookingDate" required>
            
            <button type="submit">Confirm Booking</button>
        </form>
        <a href="index.jsp">
            <button type="button" style="background-color: #6c757d;">Cancel</button>
        </a>
    </div>
</body>
</html>
