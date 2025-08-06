<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="">
  <title>Bus menagment system</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />
  <style>
       body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        h2 {
            font-size: 38px;
            color: white;
            margin: 20px;
            text-align: center;
        }

        
        .appointment-btn {
            display: inline-block;
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .appointment-btn:hover {
            background-color: #0056b3;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .doctor-card {
                width: calc(50% - 20px); /* 2 cards per row on medium screens */
            }
        }

        @media (max-width: 480px) {
            .doctor-card {
                width: 100%; /* 1 card per row on small screens */
            }
        }
  </style>
</head>
<body>
  <div class="hero_area">

    <div class="hero_bg_box">
      <img src="./images/image.jpg" alt="">
    </div>
    <header class="header_section">
   <div class="container">

<%
    // Check if user is logged in
    String loggedInUser = (String) session.getAttribute("loggedInUser");
%>

<nav class="navbar navbar-expand-lg custom_nav-container fixed-navbar" style="background-color: #007bff;">
    <a class="navbar-brand" href="index.jsp">
        <span>
            <img src="./images/bus-removebg-preview.png" alt="" style="height: 115px;">
        </span>
    </a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" 
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class=""> </span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp" style="color: aliceblue;">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="about.jsp" style="color: aliceblue;">About</a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="my-tickets.jsp" style="color: aliceblue;">View Ticket</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="contact.jsp" style="color: aliceblue;">Contact Us</a>
            </li>

            <% if (loggedInUser != null) { %>
                <!-- If user is logged in, show logout button -->
                <li class="nav-item">
                    <a class="nav-link" href="logout1.jsp" style="color: aliceblue;">Logout</a>
                </li>
            <% } else { %>
                <!-- If not logged in, show login button -->
                <li class="nav-item">
                    <a class="nav-link" href="login-page.jsp" style="color: aliceblue;">Login</a>
                </li>
            <% } %>
        </ul>
    </div>
</nav>

        
        
      </div>
    </header>
          <div class="carousel-item ">
            <div class="container ">
              <div class="row">
                <div class="col-md-7">
                  <div class="detail-box">
                    <h1>
                      We Provide best Transport Services
                    </h1>
                    <p>
                      Explicabo esse amet tempora quibusdam laudantium, laborum eaque magnam fugiat hic? Esse dicta aliquid error repudiandae earum suscipit fugiat molestias, veniam, vel architecto veritatis delectus repellat modi impedit sequi.
                    </p>
                   
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <div class="container ">
              <div class="row">
                <div class="col-md-7">
                  <div class="detail-box">
                    <h1>
                      We Provide Best Transport
                    </h1>
                    <p>
                      Explicabo esse amet tempora quibusdam laudantium, laborum eaque magnam fugiat hic? Esse dicta aliquid error repudiandae earum suscipit fugiat molestias, veniam, vel architecto veritatis delectus repellat modi impedit sequi.
                    </p>
                 
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <ol class="carousel-indicators">
          <li data-target="#customCarousel1" data-slide-to="0" class="active"></li>
          <li data-target="#customCarousel1" data-slide-to="1"></li>
          <li data-target="#customCarousel1" data-slide-to="2"></li>
        </ol>
      </div>
    </section>
  </div>
<section class="department_section layout_padding">
    <div class="department_container">
        <div class="container">
            <div class="heading_container heading_center">
                <h2 style="color: black;">Our Routes</h2>
                <p>Asperiores sunt consectetur impedit nulla molestiae delectus repellat laborum dolores doloremque accusantium</p>
            </div>
            <div class="row" style="background-color: #007bff; border-radius: 23px;">
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

                        // Fetch routes from the database
                        String query = "SELECT id, route_name, start_location, end_location, start_time, reach_time, route_description FROM routes";
                        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                        rs = stmt.executeQuery(query);

                        if (!rs.next()) {
                            out.println("<h3>No routes available in the database.</h3>");
                        } else {
                            rs.beforeFirst();
                            while (rs.next()) {
                                int routeId = rs.getInt("id");
                                String routeName = rs.getString("route_name");
                                String startLocation = rs.getString("start_location");
                                String endLocation = rs.getString("end_location");
                                String startTime = rs.getString("start_time");
                                String reachTime = rs.getString("reach_time");
                                String description = rs.getString("route_description");
                %>
                <div class="col-md-3" style="background-color: #007bff; border-radius: 35px;">
                    <div class="box" style="border-radius: 15px;">
                        <div class="img-box" style="background-color: #007bff;">
                            <img src="./images/bus-removebg-preview.png" alt="" style="height: 120px;">
                        </div>
                        <div class="detail-box">
                            <h4><%= routeName %></h4>
                            <p><strong>Start Location:</strong> <%= startLocation %></p>
                            <p><strong>End Location:</strong> <%= endLocation %></p>
                            <p><strong>Start Time:</strong> <%= startTime %></p>
                            <p><strong>Reach Time:</strong> <%= reachTime %></p>
                            <p><strong>Description:</strong> <%= description %></p>
                            <div class="btn-box">
    							<a href="./ticket.jsp?route_id=<%= rs.getInt("id") %>" style="color: azure; background-color: #007bff;">
        						Book Ticket
    							</a>
							</div>

                        </div>
                    </div>
                </div>
                <%
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<h3>Error: " + e.getMessage() + "</h3>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>
            </div>
        </div>
    </div>
</section>

  <section class="about_section layout_margin-bottom">
    <div class="container  ">
      <div class="row">
        <div class="col-md-6 ">
          <div class="img-box">
            <img src="./images/sindh.jpg" alt="">
          </div>
        </div>
        <div class="col-md-6">
          <div class="detail-box">
            <div class="heading_container">
              <h2 style="color: black;">
                About <span>Us</span>
              </h2>
            </div>
            <p>
              There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration
              in some form, by injected humour, or randomised words which don't look even slightly believable. If you
              are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in
              the middle of text. All
            </p>
            
          </div>
        </div>
      </div>
    </div>
  </section>
  <section class="doctor_section layout_padding" style="background-color: #007bff;">
    <div class="container">
        <div class="heading_container heading_center">
            <h2>Available Private Buses</h2>
        </div>
        <div class="row" id="busList">
<%
    // Database connection parameters
    

    try {
        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to fetch bus details with busSector = 'Private'
        String query = "SELECT id, bus_name, bus_number, bus_type, description, status FROM buses WHERE busSector = 'Private'";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);

        while (rs.next()) {
            int id = rs.getInt("id");
            String busName = rs.getString("bus_name");
            String busNumber = rs.getString("bus_number");
            String busType = rs.getString("bus_type");
            String description = rs.getString("description");
            String status = rs.getString("status");
%>
<div class="col-md-4">
    <div class="card" style="margin: 15px; padding: 10px; background-color: #fff; border-radius: 8px; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);">
        <img src="./sindh.jpg" alt="<%= busName %>" style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px;">
        <div class="card-body">
            <h5 style="font-size: 18px; font-weight: bold; color: #333;">Bus Name: <%= busName %></h5>
            <h6 style="font-size: 16px; color: #555;">Bus Number: <%= busNumber %></h6>
            <h6 style="font-size: 14px; color: #555;">Bus Type: <%= busType %></h6>
            <p style="font-size: 14px; color: #777;">Description: <%= description %></p>
            
            <%
                if ("Booked".equals(status)) {
            %>
                <button class="btn btn-danger" style="display: block; text-align: center; padding: 10px; background-color: #dc3545; color: #fff; border-radius: 5px; margin-top: 10px;" disabled>Bus Booked</button>
            <%
                } else {
            %>
                <a href="book-ticket.jsp?id=<%= id %>" class="btn btn-primary" style="display: block; text-align: center; padding: 10px; background-color: #28a745; color: #fff; text-decoration: none; border-radius: 5px; margin-top: 10px;">Book Bus Now</a>
            <%
                }
            %>
        </div>
    </div>
</div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

        </div>
    </div>
</section>
  <section class="contact_section layout_padding">
    <div class="container">
      <div class="heading_container">
        <h2>
          Get In Touch
        </h2>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="form_container contact-form">
            <form action="">
              <div class="form-row">
                <div class="col-lg-6">
                  <div>
                    <input type="text" placeholder="Your Name" />
                  </div>
                </div>
                <div class="col-lg-6">
                  <div>
                    <input type="text" placeholder="Phone Number" />
                  </div>
                </div>
              </div>
              <div>
                <input type="email" placeholder="Email" />
              </div>
              <div>
                <input type="text" class="message-box" placeholder="Message" />
              </div>
              <div class="btn_box">
                <button style="background-color: #007bff;;">
                  SEND
                </button>
              </div>
            </form>
          </div>
        </div>
        <div class="col-md-6">
          <div class="map_container">
            <div class="map">
              <div id="googleMap"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
        <div class="carousel_btn-container">
          <a class="carousel-control-prev" href="#carouselExample2Controls" role="button" data-slide="prev">
            <i class="fa fa-long-arrow-left" aria-hidden="true"></i>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExample2Controls" role="button" data-slide="next">
            <i class="fa fa-long-arrow-right" aria-hidden="true"></i>
            <span class="sr-only">Next</span>
          </a>
        </div>
      </div>
    </div>
  </section>
  <footer class="footer_section" style="background-color: #007bff;;">
    <div class="container">
      <div class="row">
        <div class="col-md-6 col-lg-3 footer_col">
          <div class="footer_contact">
            <h4>
              Reach at..
            </h4>
            <div class="contact_link_box">
              <a href="https://www.google.com/maps?q=40.712775,-74.005973" target="_blank">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                <span>Location</span>
            </a>
            
              <a href="">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>
                  Call 03242938640
                </span>
              </a>
              <a href="">
                <i class="fa fa-envelope" aria-hidden="true"></i>
                <span>
                 junejoabuhurera52@gmial.com
                </span>
              </a>
            </div>
          </div>
          <div class="footer_social">
            <a href="">
              <i class="fa fa-facebook" aria-hidden="true"></i>
            </a>
            <a href="">
              <i class="fa fa-twitter" aria-hidden="true"></i>
            </a>
            <a href="">
              <i class="fa fa-linkedin" aria-hidden="true"></i>
            </a>
            <a href="">
              <i class="fa fa-instagram" aria-hidden="true"></i>
            </a>
          </div>
        </div>
        <div class="col-md-6 col-lg-3 footer_col">
          <div class="footer_detail">
            <h4>
              About
            </h4>
            <p>
              Beatae provident nobis mollitia magnam voluptatum, unde dicta facilis minima veniam corporis laudantium alias tenetur eveniet illum reprehenderit fugit a delectus officiis blanditiis ea.
            </p>
          </div>
        </div>
        <div class="col-md-6 col-lg-2 mx-auto footer_col">
          <div class="footer_link_box">
            <h4>
              Links
            </h4>
            <div class="footer_links">
              <a class="active" href="index.html">
                Home
              </a>
              <a class="" href="about.html">
                About
              </a>
              <a class="" href="ticket.html">
                Book Now
              </a>
              
              <a class="" href="contact.html">
                Contact Us
              </a>
            
            </div>
            
          </div>
        </div>
        <div class="col-md-6 col-lg-3 footer_col ">
          <h4>
            Newsletter
          </h4>
          <form action="#">
            <input type="email" placeholder="Enter email" />
            <button type="submit" style="background-color: #0056b3;">
              Subscribe
            </button>
          </form>
        </div>
      </div>
      <div class="footer-info">
      </div>
    </div>
  </footer>
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
  </script>
  <script type="text/javascript" src="js/custom.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap">
  </script>
  <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
  <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
 
</body>
</html>