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
    <title>View Tickets</title>
    <style>
        /* Styling */
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h3 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-family: Arial, sans-serif;
        }
        table th, table td {
            padding: 12px;
            text-align: left;
        }
        table th {
            background-color: #007bff;
            color: white;
        }
        table td {
            background-color: #f2f2f2;
        }
        table tr:nth-child(even) td {
            background-color: #e7f7ff;
        }
        button {
            padding: 8px 16px;
            margin: 5px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
        }
        button:hover {
            background-color: #0056b3;
        }
        .reset-button {
            background-color: #28a745;
        }
        .reset-button:hover {
            background-color: #218838;
        }
        @media screen and (max-width: 600px) {
            table, th, td {
                font-size: 14px;
                padding: 8px;
            }
            button {
                padding: 6px 12px;
            }
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
<h3>Booked Buses</h3>
<div class="container">
    <table>
        <thead>
            <tr>
                <th>Passenger Name</th>
                <th>Contact</th>
                <th>Bus Name</th>
                <th>Date</th>
                <th>Time</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Database connection parameters
                String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
                String dbUser = "root";
                String dbPassword = "root";

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String query = "SELECT bookbus.passenger_name, bookbus.contact, buses.bus_name AS bus_name, bookbus.booking_date, bookbus.bookBusTime FROM bookbus INNER JOIN buses ON bookbus.id = buses.id";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String passengerName = rs.getString("passenger_name");
                        String contact = rs.getString("contact");
                        String busName = rs.getString("bus_name");
                        String bookingDate = rs.getString("booking_date");
                        String bookBusTime= rs.getString("bookBusTime");
                        
            %>
                        <tr>
                            <td><%= passengerName %></td>
                            <td><%= contact %></td>
                            <td><%= busName %></td>
                            <td><%= bookingDate %></td>
                            <td><%= bookBusTime %> </td>
                            <td>
                                <form method="POST" action="reset-status.jsp">
                                    <input type="hidden" name="busName" value="<%= busName %>">
                                    <button class="reset-button" type="submit">Reset</button>
                                </form>
                            </td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "');</script>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>
</div>

<h3>Booked Tickets</h3>
<div class="container">
    <table>
        <thead>
            <tr>
                <th>Passenger Name</th>
                <th>Contact</th>
                <th>Route Name</th>
                <th>No Seats</th>
                <th>Booking Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    // SQL query to fetch booked tickets along with route name
                    String query = "SELECT bookings.passenger_name, bookings.contact, bookings.num_seats, routes.route_name, bookings.booking_date FROM bookings INNER JOIN routes ON bookings.route_id = routes.id";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        String passengerName = rs.getString("passenger_name");
                        String contact = rs.getString("contact");
                        String routeName = rs.getString("route_name");
                        String seats = rs.getString("num_seats");
                        String bookingDate = rs.getString("booking_date");
            %>
                        <tr>
                            <td><%= passengerName %></td>
                            <td><%= contact %></td>
                            <td><%= routeName %></td>
                            <td><%= seats %></td>
                            <td><%= bookingDate %></td>
                            <td>
                                <form method="POST" action="reset-status.jsp">
                                    <input type="hidden" name="routeName" value="<%= routeName %>">
                                    <input type="hidden" name="numSeats" value="<%= seats %>">
                                    <button class="reset-button" type="submit">Reset</button>
                                </form>
                            </td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "');</script>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>
</div>
<br><br>
 <a href="adminPenal.jsp" class="btn">Go Back to Home</a>
</div>
</body>
</html>
