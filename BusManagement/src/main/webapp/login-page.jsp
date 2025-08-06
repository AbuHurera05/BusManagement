<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    String message = ""; // Error message ke liye variable

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
        String dbUser = "root"; 
        String dbPassword = "root"; 

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // **User Found: Set session**
                session.setAttribute("loggedInUser", email); // Store user in session
                response.sendRedirect("index.jsp"); // Redirect to homepage
                return;
            } else {
                message = "Try again! Please enter the correct email or password.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Database error: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Bus Management System</title>
    <style>
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
        input[type="email"], input[type="password"] {
            margin-bottom: 15px;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
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
        .error-message {
            color: red;
            margin-top: 10px;
            font-size: 14px;
        }
        .signup-link {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }
        .signup-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form method="POST" action="login-page.jsp">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <% if (!message.isEmpty()) { %>
            <div class="error-message"><%= message %></div>
        <% } %>
        <a href="signup.jsp" class="signup-link">Don't have an account? Sign up</a>
    </div>
</body>
</html>
