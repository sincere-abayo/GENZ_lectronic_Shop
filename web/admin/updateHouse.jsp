<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<jsp:include page="adminheader.jsp" />

<%
String houseIdParam = request.getParameter("id");

if (houseIdParam != null) {
    int houseId = Integer.parseInt(houseIdParam);

    try {
        Connection con = ConnectionDatabase.getCon();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM house WHERE id = ?");
        ps.setInt(1, houseId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // Fetch house details
            String upiNumber = rs.getString("upiNumber");
            String description = rs.getString("description");
            BigDecimal price = rs.getBigDecimal("price");
            String location = rs.getString("location");
            int sellerId = rs.getInt("sellerId");
            String status = rs.getString("status");

            // Fetch the list of sellers
            PreparedStatement sellerStatement = con.prepareStatement("SELECT * FROM user WHERE id = ?");
			sellerStatement.setInt(1, sellerId); // assuming sellerId is the ID you want to use
			ResultSet sellerResultSet = sellerStatement.executeQuery();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update House</title>
    <!-- Include Bootstrap CSS -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h2 class="text-center">Update House</h2>
                </div>
                <div class="card-body">
                    <form action="updateHouseAction.jsp" method="post">
                        <!-- Include houseId as a hidden input to pass it to updateHouseAction.jsp -->
                        <input type="hidden" name="id" value="<%= houseId %>">
                        <div class="mb-3">
                            <label for="upiNumber" class="form-label">UPI Number</label>
                            <input type="text" class="form-control" name="upiNumber" value="<%= upiNumber %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" name="description" required><%= description %></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="text" class="form-control" name="price" value="<%= price %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="location" class="form-label">Location</label>
                            <input type="text" class="form-control" name="location" value="<%= location %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="sellerId" class="form-label">Seller</label>
                            <select class="form-control" name="sellerId" required>
                                <% 
                                // Iterate through the result set and create options
                                while (sellerResultSet.next()) {
                                %>
                                <option value="<%= sellerResultSet.getInt("id") %>" <%= (sellerResultSet.getInt("id") == sellerId) ? "selected" : "" %>><%= sellerResultSet.getString("name") %></option>
                                <%
                                }
                                sellerResultSet.close();
                                sellerStatement.close();
                                %>
                            </select>
                        </div>
               
                        <div class="mb-3">
						    <label for="status" class="form-label">Status</label>
						    <select class="form-control" name="status" required>
						        <option value="Available" <%= "Available".equals(status) ? "selected" : "" %>>Available</option>
						        <option value="Sold" <%= "Sold".equals(status) ? "selected" : "" %>>Sold</option>
						        <!-- Add other options if needed -->
						    </select>
						</div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="adminfooter.jsp" />

<!-- Include Bootstrap JS and Popper.js -->
<script src="../bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
        } else {
            // House not found
            response.sendRedirect("admin_houses.jsp?msg=house_not_found");
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        System.out.print(e);
        response.sendRedirect("admin_houses.jsp?msg=error");
    }
} else {
    // houseIdParam is null
    response.sendRedirect("admin_houses.jsp?msg=invalid_id");
}
%>
