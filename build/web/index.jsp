<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to GENZ Electronic Shop</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Custom CSS -->
    <style>
        .hero-section {
            background: url('images/shop-banner-2.jpeg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 100px 0;
            text-align: center;
        }
        .hero-section h1 {
            font-size: 3.5rem;
            font-weight: bold;
        }
        .hero-section p {
            font-size: 1.2rem;
            margin-bottom: 30px;
        }
        .product-card img {
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <h1>Welcome to GENZ Electronic Shop</h1>
            <p>Your one-stop shop for the latest electronics and gadgets.</p>
            <a href="signup.jsp" class="btn btn-primary btn-lg">Join Now</a>
            <a href="login.jsp" class="btn btn-secondary btn-lg">Login</a>
        </div>
    </div>

    <!-- Featured Products Section -->
   <div class="container mt-5">
    <h2 class="text-center mb-4">Featured Products</h2>
    <div class="row">
        <%
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        boolean hasProducts = false; // Flag to check if there are any products

        try {
            con = ConnectionDatabase.getCon();
            st = con.createStatement();
            String query = "SELECT * FROM product ORDER BY created_at DESC LIMIT 4";
            rs = st.executeQuery(query);

            if (rs.isBeforeFirst()) {
                hasProducts = true;
            }

            while (rs.next()) {
        %>
        <div class="col-md-3 mb-4">
            <div class="card product-card h-100">
                <img src="images/<%= rs.getString("image") %>" class="card-img-top" alt="<%= rs.getString("name") %>">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= rs.getString("name") %></h5>
                    <p class="card-text">$<%= String.format("%.2f", rs.getDouble("price")) %></p>
                    <a href="product.jsp?id=<%= rs.getInt("id") %>" class="btn btn-primary mt-auto">View Details</a>
                </div>
            </div>
        </div>
        <%
            }
            if (!hasProducts) {
        %>
        <div class="col-12">
            <div class="alert alert-info text-center">
                No products are available at the moment. Please check back later!
            </div>
        </div>
        <%
            }
        } catch (SQLException e) {
            // Log the error and redirect to an error page
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            // Close resources in reverse order of creation
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
            if (st != null) try { st.close(); } catch (SQLException e) { /* ignored */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* ignored */ }
        }
        %>
    </div>
</div>

    <!-- Footer -->
    <footer class="footer mt-5 py-3 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>Address</h5>
                    <address>
                        GENZ Electronic Shop<br>
                        456 Tech Avenue<br>
                        City, State ZIP<br>
                        Country
                    </address>
                </div>
                <div class="col-md-4">
                    <h5>Contact</h5>
                    <p><i class="fas fa-envelope"></i> support@genzelectronicshop.com</p>
                    <p><i class="fas fa-phone"></i> +1234567890</p>
                    <p>
                        <a href="#" class="text-dark me-2"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-dark me-2"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-dark"><i class="fab fa-instagram"></i></a>
                    </p>
                </div>
                <div class="col-md-4">
                    <h5>System Settings</h5>
                    <p>Version: 1.0</p>
                    <p>Language: English</p>
                    <a href="admin/admin_login.jsp" class="btn btn-outline-primary">Admin Login</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
