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
    <title>Add Staff</title>
    <style>
        /* General styling */
        {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
        }

        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
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

        .back-button {
            margin-top: 15px;
            background-color: #6c757d;
        }

        .back-button:hover {
            background-color: #5a6268;
        }
        .gender-container 
        {
    		display: flex;
   			gap: 10px; /* Space between options */
    		align-items: center; /* Vertically align items */
		}
			.gender-container label 
			{
    			display: flex;
    			align-items: center;
    			gap: 5px; /* Space between radio button and label */
			}

    </style>
</head>
<body>
	
	<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rsBuses = null;
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        stmt = conn.createStatement();

        // وہ بسیں لانا جو کسی ڈرائیور کو اسائن نہیں ہوئیں
        String query = "SELECT id, bus_number FROM buses WHERE id NOT IN (SELECT assignedBusID FROM staff WHERE assignedBusID IS NOT NULL)";
        rsBuses = stmt.executeQuery(query);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
	

    <div class="form-container">
        <h2>Add Staff</h2>
        <form method="post" action="add-staff.jsp">
            <input type="text" name="name" placeholder="Staff Name" required>
            <input type="number" name="age" placeholder="Age" min="1" required>
            <div class="gender-container">
                <label><input type="radio" name="gender" value="Male" required> Male</label>
                <label><input type="radio" name="gender" value="Female" required> Female</label>
            </div>
            <input type="text" name="address" placeholder="Address" required>
            <input type="text" name="contact" placeholder="Contact" required>
            <select name="assignedBus">
    <option value="">Select Bus</option>
    <% while (rsBuses.next()) { %>
        <option value="<%= rsBuses.getInt("id") %>"><%= rsBuses.getString("bus_number") %></option>
    <% } %>
</select>
            
            <input type="text" name="image" placeholder="Image URL" required>
            <button type="submit">Add Staff</button>
        </form>
        <button class="back-button" onclick="window.history.back()">Back</button>
    </div>

    <%
        // Database connection parameters
       

        
        PreparedStatement pstmt = null;

        // Retrieve form data from the request
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String image = request.getParameter("image");
        String assignedBus = request.getParameter("assignedBus"); // بس ID حاصل کریں

        if (name != null && contact != null && address != null && age != null && gender != null && image != null) {
            try {
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                String query = "INSERT INTO staff (staffName, staffAge, staffGender, staffAdress, staffContact, staffImg, assignedBusID) VALUES (?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, name);
                pstmt.setInt(2, Integer.parseInt(age));
                pstmt.setString(3, gender);
                pstmt.setString(4, address);
                pstmt.setString(5, contact);
                pstmt.setString(6, image);
                
                if (assignedBus != null && !assignedBus.isEmpty()) {
                    pstmt.setInt(7, Integer.parseInt(assignedBus)); // Foreign Key سے Relate کرنا
                } else {
                    pstmt.setNull(7, java.sql.Types.INTEGER);
                }

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<script>alert('Staff added successfully!'); window.location.href='view-staff.jsp';</script>");
                } else {
                    out.println("<script>alert('Failed to add staff. Please try again.');</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
            }
        } 
    %>

</body>
</html>
