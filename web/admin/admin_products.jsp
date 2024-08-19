
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<jsp:include page="adminheader.jsp" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electronic Devices - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    body { background-color: #f8f9fa; }
    .card {
        transition: transform 0.3s, box-shadow 0.3s;
        overflow: hidden;
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .card-img-top {
        object-fit: cover;
        height: 100%;
    }
    .badge {
        font-size: 0.9em;
    }
    .btn-group-sm > .btn, .btn-sm {
        padding: .25rem .5rem;
        font-size: .875rem;
        line-height: 1.5;
        border-radius: .2rem;
    }
</style>




</head>
<body>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-tv me-2"></i>Electronic Devices</h2>
        <a href="addProduct.jsp" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i>Add New Product
        </a>
    </div>

    <% String msg = request.getParameter("msg");
    if ("success".equals(msg)) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>Product created successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        con = ConnectionDatabase.getCon();
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT product.*, user.name AS sellerName FROM product INNER JOIN user ON product.sellerId = user.id");

        if (rs.next()) {
    %>
  <div class="row g-4">
    <% do { %>
    <div class="col-12">
        <div class="card h-100 shadow-sm">
            <div class="row g-0">
                <div class="col-md-4">
                    <img src="<%= request.getContextPath() %>/images/<%= rs.getString("image") %>" 
                         class="img-fluid rounded-start h-100 object-fit-cover" 
                         alt="<%= rs.getString("name") %>">
                </div>
                <div class="col-md-8">
                    <div class="card-body d-flex flex-column h-100">
                        <div class="d-flex justify-content-between align-items-start">
                            <h5 class="card-title"><%= rs.getString("name") %></h5>
                            <span class="badge bg-<%= rs.getString("status").equalsIgnoreCase("Available") ? "success" : "warning" %>">
                                <%= rs.getString("status") %>
                            </span>
                        </div>
                        <p class="card-text mb-1">
                            <span class="badge bg-primary"><%= rs.getString("category") %></span>
                        </p>
                        <p class="card-text mb-1">
                            <strong class="fs-4 text-primary">$<%= String.format("%.2f", rs.getBigDecimal("price")) %></strong>
                        </p>
                        <p class="card-text mb-1"><small class="text-muted"><i class="fas fa-map-marker-alt me-1"></i><%= rs.getString("location") %></small></p>
                        <p class="card-text mb-1"><small class="text-muted"><i class="fas fa-user me-1"></i><%= rs.getString("sellerName") %></small></p>
                        <div class="mt-auto">
                            <div class="d-flex justify-content-end">
                                <a href="updateProduct.jsp?id=<%= rs.getInt("id") %>" class="btn btn-outline-primary btn-sm me-2">
                                    <i class="fas fa-edit me-1"></i>Edit
                                </a>
                                <a href="deleteProduct.jsp?id=<%= rs.getInt("id") %>" class="btn btn-outline-danger btn-sm" 
                                   onclick="return confirm('Are you sure you want to delete this product?');">
                                    <i class="fas fa-trash-alt me-1"></i>Delete
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } while (rs.next()); %>
</div>
    <%
        } else {
    %>
    <div class="alert alert-info" role="alert">
        <i class="fas fa-info-circle me-2"></i>No products found in the database.
    </div>
    <%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    %>
    <div class="alert alert-danger" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>An error occurred while fetching products. Please try again later or contact the administrator.
    </div>
    <%
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* ignored */ }
        if (con != null) try { con.close(); } catch (SQLException e) { /* ignored */ }
    }
    %>
</div>

<jsp:include page="adminfooter.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>