<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    if (loggedIn == null || !loggedIn) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<%
    // Get parameters from the request
    String busName = request.getParameter("busName");
    String routeName = request.getParameter("routeName");
    String numSeatsParam = request.getParameter("numSeats"); // Number of seats booked

    // Database connection settings
    String dbURL = "jdbc:mysql://localhost:3306/busmanagementsystem";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement stmt = null;
    PreparedStatement updateStatusStmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Case 1: Reset for Booked Buses
        if (busName != null && !busName.isEmpty()) {
            // Step 1: Delete the booking from the `bookbus` table
            String deleteBusBookingQuery = "DELETE FROM bookbus WHERE id IN (SELECT id FROM buses WHERE bus_name = ?) LIMIT 1";
            stmt = conn.prepareStatement(deleteBusBookingQuery);
            stmt.setString(1, busName);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                // Step 2: Update the status of the bus to 'Available'
                String updateBusStatusQuery = "UPDATE buses SET status = 'Available' WHERE bus_name = ?";
                updateStatusStmt = conn.prepareStatement(updateBusStatusQuery);
                updateStatusStmt.setString(1, busName);
                updateStatusStmt.executeUpdate();

                out.println("<script>alert('Bus booking reset successfully. Status updated to Available.'); window.location.href='view-tickets.jsp';</script>");
            } else {
                out.println("<script>alert('Error: Could not reset bus booking.'); window.location.href='view-tickets.jsp';</script>");
            }
        }
        // Case 2: Reset for Booked Tickets
        else if (routeName != null && !routeName.isEmpty() && numSeatsParam != null && !numSeatsParam.isEmpty()) {
            int numSeats = Integer.parseInt(numSeatsParam); // Convert seat count to integer

            // Step 1: Get the correct route_id (ensuring it returns a single row)
            String getRouteIdQuery = "SELECT id FROM routes WHERE route_name = ? LIMIT 1";
            stmt = conn.prepareStatement(getRouteIdQuery);
            stmt.setString(1, routeName);
            ResultSet routeRs = stmt.executeQuery();

            if (routeRs.next()) {
                int routeId = routeRs.getInt("id");

                // Step 2: Delete specific ticket
                String deleteTicketQuery = "DELETE FROM bookings WHERE route_id = ? LIMIT 1";
                PreparedStatement deleteStmt = conn.prepareStatement(deleteTicketQuery);
                deleteStmt.setInt(1, routeId);

                int rowsDeleted = deleteStmt.executeUpdate();
                deleteStmt.close();

                if (rowsDeleted > 0) {
                    // Step 3: Increment available seats in buses
                    String updateSeatsQuery = "UPDATE buses SET bus_seats = bus_seats + ? WHERE id IN (SELECT bus_id FROM routes WHERE id = ?)";
                    PreparedStatement updateSeatsStmt = conn.prepareStatement(updateSeatsQuery);
                    updateSeatsStmt.setInt(1, numSeats);
                    updateSeatsStmt.setInt(2, routeId);
                    updateSeatsStmt.executeUpdate();
                    updateSeatsStmt.close();

                    out.println("<script>alert('Ticket reset successfully. Seats updated.'); window.location.href='view-tickets.jsp';</script>");
                } else {
                    out.println("<script>alert('Error: Could not reset ticket.'); window.location.href='view-tickets.jsp';</script>");
                }
            } else {
                out.println("<script>alert('Error: Route not found.'); window.location.href='view-tickets.jsp';</script>");
            }

            // Close result set
            routeRs.close();
        } else {
            out.println("<script>alert('Error: Missing parameters. Please try again.'); window.location.href='view-tickets.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='view-tickets.jsp';</script>");
    } finally {
        if (stmt != null) stmt.close();
        if (updateStatusStmt != null) updateStatusStmt.close();
        if (conn != null) conn.close();
    }
%>
