<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>
 
           
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GENZ Electronic Shop</title>
    <!-- Include Bootstrap CSS -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   
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
        <a class="navbar-brand" href="#">GES</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0"> <!-- Centered elements -->
                <li class="nav-item">
                    <a class="nav-link" href="admin_home.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="listusers.jsp">Users</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="admin_products.jsp">Devices</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="admin_sold.jsp">Sold</a> <!-- Added Sold link -->
                </li>
                
            </ul>
            
          
        </div>
    </div>
</nav>

<!-- Include Bootstrap JS and Popper.js -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
