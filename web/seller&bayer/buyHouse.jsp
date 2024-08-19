<%@ page import="java.sql.*" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.math.BigDecimal" %>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy House</title>
    <!-- Include Bootstrap CSS -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2>Buy House</h2>
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <% 
            int buyerId = (int) session.getAttribute("userId");
            
            int houseId = Integer.parseInt(request.getParameter("id"));

            try {
                Connection con = ConnectionDatabase.getCon();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM house WHERE id = ?");
                ps.setInt(1, houseId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String upiNumber = rs.getString("upiNumber");
                    String description = rs.getString("description");
                    BigDecimal price = rs.getBigDecimal("price");
                    String location = rs.getString("location");
                    int sellerId = rs.getInt("sellerId");
                    String status = rs.getString("status");

                    if (status.equals("Sold")) {
            %>
            <div class="alert alert-danger" role="alert">
                This house has already been sold.
            </div>
            <%
                    } else {
                        // Update house status to 'Sold'
                        PreparedStatement updateHousePs = con.prepareStatement("UPDATE house SET status = 'Sold' WHERE id = ?");
                        updateHousePs.setInt(1, houseId);
                        updateHousePs.executeUpdate();

                        // Insert payment record
                        PreparedStatement insertPaymentPs = con.prepareStatement("INSERT INTO payment (houseId, buyerId, amount, status) VALUES (?, ?, ?, 'Pending')");
                        insertPaymentPs.setInt(1, houseId);
                        insertPaymentPs.setInt(2, buyerId);                  
                        insertPaymentPs.setBigDecimal(3, price);
                        insertPaymentPs.executeUpdate();
            %>
            <div class="alert alert-success" role="alert">
                Booking House to buy successful, pay amount <%= price %> RWF!
            </div>
            <%
                    }
                } else {
            %>
            <div class="alert alert-danger" role="alert">
                House not found.
            </div>
            <%
                }
                con.close();
            } catch (Exception e) {
                // Display a user-friendly error message or log the error for debugging
                out.println("<div class='alert alert-danger' role='alert'>An error occurred while processing your request. Please try again later.</div>");
                e.printStackTrace(); // Log the exception for debugging purposes
            }
            %>
        </div>
    </div>
</div>

<!-- Include Bootstrap JS and Popper.js -->
<script src="../bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
