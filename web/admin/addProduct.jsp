<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page errorPage="error.jsp" %>
<jsp:include page="adminheader.jsp" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - GENZ Electronic Shop</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
        }
        .card {
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body class="bg-light">

<div class="container mt-5 mb-5">
    <div class="form-container">
        <div class="card">
            <div class="card-header">
                <h2 class="text-center mb-0"><i class="fas fa-box me-2"></i>Add Product</h2>
            </div>
            <div class="card-body">
                <form action="../AddProduct" method="post" enctype="multipart/form-data">
                   
                    <div class="mb-3">
                        <label for="name" class="form-label"><i class="fas fa-tag me-2"></i>Name</label>
                        <input type="text" class="form-control" id="name" name="name" required maxlength="100">
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label"><i class="fas fa-align-left me-2"></i>Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label"><i class="fas fa-dollar-sign me-2"></i>Price</label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                    </div>
                    <div class="mb-3">
                        <label for="category" class="form-label"><i class="fas fa-folder me-2"></i>Category</label>
                        <input type="text" class="form-control" id="category" name="category" required maxlength="50">
                    </div>
                    <div class="mb-3">
                        <label for="stock" class="form-label"><i class="fas fa-cubes me-2"></i>Stock</label>
                        <input type="number" class="form-control" id="stock" name="stock" required>
                    </div>
                    <div class="mb-3">
                        <label for="image" class="form-label"><i class="fas fa-image me-2"></i>Image</label>
                        <input type="file" class="form-control" id="image" name="image" accept="image/*">
                    </div>
                    <div class="mb-3">
                        <label for="status" class="form-label"><i class="fas fa-info-circle me-2"></i>Status</label>
                        <select class="form-select" id="status" name="status">
                            <option value="Available">Available</option>
                            <option value="Out of Stock">Out of Stock</option>
                            <option value="Discontinued">Discontinued</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="sellerId" class="form-label"><i class="fas fa-user me-2"></i>Seller</label>
                        <select class="form-select" id="sellerId" name="sellerId" required>
                            <option value="">Select a seller</option>
                            <% 
                            Connection con = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                con = ConnectionDatabase.getCon();
                                stmt = con.createStatement();
                                rs = stmt.executeQuery("SELECT id, name FROM user ORDER BY name");
                                while (rs.next()) {
                            %>
                            <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %></option>
                            <% 
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
                                if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* ignored */ }
                                if (con != null) try { con.close(); } catch (SQLException e) { /* ignored */ }
                            }
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="location" class="form-label"><i class="fas fa-map-marker-alt me-2"></i>Location</label>
                        <input type="text" class="form-control" id="location" name="location" required>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="fas fa-plus-circle me-2"></i>Add Product
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
