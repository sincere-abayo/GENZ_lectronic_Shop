<%@ page import="java.sql.*" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Houses</title>

    <!-- Include Bootstrap CSS -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2>List of Houses</h2>

    <!-- Add House Button -->
    <a href="addHouse.jsp" class="btn btn-success mb-3">Add House</a>

    <% 
    try {
        Connection con = ConnectionDatabase.getCon();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM house");

        // Check if the result set is not empty
        if (rs.next()) {
    %>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>UPI Number</th>
                <th>Description</th>
                <th>Price</th>
                <th>Location</th>
                <th>Seller ID</th>
                <th>Status</th>
                <!-- Add more columns as needed -->
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            // Iterate through the result set
            do {
                int houseId = rs.getInt("id");

                // Check if the house is in the payment table
                PreparedStatement psPayment = con.prepareStatement("SELECT * FROM payment WHERE houseId = ? and status=?");
                psPayment.setInt(1, houseId);
                psPayment.setString(2, "Approved");
                ResultSet rsPayment = psPayment.executeQuery();

                // If the house is not in the payment table, display it
                if (!rsPayment.next()) {
            %>
            <tr>
                <td><%= houseId %></td>
                <td><%= rs.getString("upiNumber") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getBigDecimal("price") %></td>
                <td><%= rs.getString("location") %></td>
                <td><%= rs.getInt("sellerId") %></td>
                <td><%= rs.getString("status") %></td>
                <!-- Add more cells for additional columns -->
                <td>
                    <!-- Buy Button -->
                    <a href="buyHouse.jsp?id=<%= houseId %>" class="btn btn-primary btn-sm">Buy</a>
                </td>
            </tr>
            <%
                }
                rsPayment.close();
                psPayment.close();
            } while (rs.next());
            %>
        </tbody>
    </table>
    <%
        } else {
    %>
    <p>No houses found.</p>
    <%
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>

</div>
<jsp:include page="footer.jsp" />


<!-- Include Bootstrap JS and Popper.js -->
<script src="../bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
