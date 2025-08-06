<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Signup - Hospital Management</title>
  <style>
    /* Styling for the container */
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f7fa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .container {
        background-color: #fff;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        width: 300px;
        text-align: center;
    }

    h2 {
      color: #007bff;
      margin-bottom: 20px;
    }

    form {
        display: flex;
        flex-direction: column;
    }

    input[type="text"], input[type="email"], input[type="password"], input[type="number"] {
        margin-bottom: 15px;
        padding: 12px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .gender-container {
        margin-bottom: 15px;
        font-size: 16px;
    }

    .gender-container label {
        margin-right: 20px;
        font-weight: normal;
    }

    button {
      width: 100%;
      padding: 10px;
      background-color: #007bff;
      color: #fff;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
    }

    button:hover {
        background-color: #0056b3;
    }

    .login-link {
        display: block;
        text-align: center;
        margin-top: 10px;
        color: #007bff;
        text-decoration: none;
    }

    .login-link:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>



  <div class="container">
    <h2>Signup</h2>
    <form action="signup.jsp" method="POST">
        <input type="text" name="name" placeholder="Username" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>

        <input type="text" name="contact" placeholder="Contact Number" required>
        <input type="number" name="age" placeholder="Age" >

        <div class="gender-container">
          <label><input type="radio" name="gender" value="Male" required> Male</label>
          <label><input type="radio" name="gender" value="Female" required> Female</label>
      </div>
        
        <button type="submit">Sign Up</button>
    </form>
    <a href="./login-page.jsp" class="login-link">Already have an account? Login</a>
</div>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    // صرف تبھی execute ہوگا جب فارم submit کیا جائے گا
    if (request.getMethod().equalsIgnoreCase("POST")) {
        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");

        int age = 0; // Default age value
        
        try {
            if (ageStr != null && !ageStr.trim().isEmpty()) {
                age = Integer.parseInt(ageStr);
            }
        } catch (NumberFormatException e) {
            out.println("<script>alert('Invalid age. Please enter a valid number.'); window.location='signup.jsp';</script>");
            return;
        }

        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem"; // Replace with your DB name
        String dbUser = "root"; // Replace with your DB username
        String dbPassword = "root"; // Replace with your DB password

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Insert query
            String query = "INSERT INTO users (name, email, password, contact, age, gender) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, password); 
            pstmt.setString(4, contact);
            pstmt.setInt(5, age);
            pstmt.setString(6, gender);

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                out.println("<script>alert('Signup successful!');window.location='login-page.jsp';</script>");
            } else {
                out.println("<script>alert('Error signing up. Please try again.');window.location='signup.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Database error: " + e.getMessage() + "');window.location='signup.jsp';</script>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
%>
</body>
</html>
