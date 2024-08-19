<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ONLINE HOUSE SELLING MANAGEMENT SYSTEM</title>
    <!-- Include Bootstrap CSS -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Additional CSS to position elements */
        .navbar-brand {
            margin-right: auto; /* Pushes the brand/logo to the left corner */
        }

        .navbar-text {
            margin-left: auto; /* Pushes the "Welcome" message to the left */
            margin-right: 1rem; /* Provides some space between the "Welcome" message and the "Logout" button */
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">OHSMS</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0"> <!-- Centered elements -->
                <li class="nav-item">
                    <a class="nav-link" href="default_dashboard.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="house.jsp">House</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="aboutus.jsp">About Us</a>
                </li>
            </ul>
            <% 
            // Check if the user is logged in
            HttpSession sessions = request.getSession(false);
            if (sessions != null && sessions.getAttribute("userId") != null) {
                // User is logged in
                int userId = (int) sessions.getAttribute("userId");
                String username = (String) sessions.getAttribute("userName");
            %>
                <span class="navbar-text">
                    Welcome, <%= username %>
                </span>
                <a href="logout.jsp" class="btn btn-outline-danger">Logout</a>
            <% } else { %>
                <a href="../login.jsp" class="btn btn-outline-primary">Login</a>
            <% } %>
        </div>
    </div>
</nav>

<!-- Include Bootstrap JS and Popper.js -->
<script src="../bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
