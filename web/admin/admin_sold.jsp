<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.math.BigDecimal" %>
<jsp:include page="adminheader.jsp" />
<html>
<head>
    <title>Admin Sold Products</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">
    <!-- Display list of sold products -->
    <h1>Sold Products</h1>
    <%
        try {
            Connection con = ConnectionDatabase.getCon();
            // Fetch sold products (orders) with a status of "Pending"
            String query = "SELECT orders.*, product.name AS productName, user.name AS customerName " +
                           "FROM orders " +
                           "INNER JOIN product ON orders.productId = product.id " +
                           "INNER JOIN user ON orders.userId = user.id " +
                           "WHERE orders.status = 'Pending'";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) { // Check if the ResultSet is empty
    %>
                <div class="alert alert-info" role="alert">
                    No pending orders found.
                </div>
    <%
            } else {
    %>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product Name</th>
                        <th>Customer Name</th>
                        <th>Quantity</th>
                        <th>Total Amount</th>
                        <th>Order Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    while (rs.next()) {
                        int orderId = rs.getInt("id");
                        String productName = rs.getString("productName");
                        String customerName = rs.getString("customerName");
                        int quantity = rs.getInt("quantity");
                        BigDecimal totalAmount = rs.getBigDecimal("totalAmount");
                        Timestamp orderDate = rs.getTimestamp("orderDate");
                        String status = rs.getString("status");
                    %>
                    <tr>
                        <td><%= orderId %></td>
                        <td><%= productName %></td>
                        <td><%= customerName %></td>
                        <td><%= quantity %></td>
                        <td>$<%= totalAmount.setScale(2) %></td>
                        <td><%= orderDate %></td>
                        <td>
                            <span class="badge bg-<%= status.equalsIgnoreCase("Pending") ? "warning" : "success" %>">
                                <%= status %>
                            </span>
                        </td>
                        <td>
                            <!-- Add buttons for approve and cancel actions -->
                            <button onclick="approveOrder(<%= orderId %>)" class="btn btn-success btn-sm">Approve</button>
                            <button onclick="cancelOrder(<%= orderId %>)" class="btn btn-danger btn-sm">Cancel</button>
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
    <%
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>
<br>
<jsp:include page="adminfooter.jsp" />

<!-- Include Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- JavaScript functions for handling approve and cancel actions -->
<script>
    function approveOrder(orderId) {
        // Send AJAX request to approveOrder.jsp to update order status
        $.ajax({
            url: 'approveOrder.jsp',
            type: 'POST',
            data: {
                orderId: orderId
            },
            success: function(response) {
                // Handle success response
                alert("Order approved for Order ID: " + orderId);
                location.reload(); // Reload the page to reflect changes
            },
            error: function(error) {
                console.error("Error object:", error);
                alert("Error approving order. Please check the console for details.");
            }
        });
    }

    function cancelOrder(orderId) {
        // Send AJAX request to cancelOrder.jsp to update order status
        $.ajax({
            url: 'cancelOrder.jsp',
            type: 'POST',
            data: {
                orderId: orderId
            },
            success: function(response) {
                // Handle success response
                alert("Order canceled for Order ID: " + orderId);
                location.reload(); // Reload the page to reflect changes
            },
            error: function(error) {
                console.error("Error object:", error);
                alert("Error canceling order. Please check the console for details.");
            }
        });
    }
</script>

</body>
</html>
