<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
Connection con = null;
PreparedStatement pstmt = null;
try {
    // Retrieve form parameters
    String sku = request.getParameter("sku");
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    String priceStr = request.getParameter("price");
    String category = request.getParameter("category");
    String stockStr = request.getParameter("stock");
    String status = request.getParameter("status");
    String sellerIdStr = request.getParameter("sellerId");
    String location = request.getParameter("location");

    // Parse numeric values
    BigDecimal price = new BigDecimal(priceStr);
    int stock = Integer.parseInt(stockStr);
    int sellerId = Integer.parseInt(sellerIdStr);

    // Handle file upload
    Part filePart = request.getPart("image");
    String fileName = null;
    if (filePart != null && filePart.getSize() > 0) {
        fileName = getSubmittedFileName(filePart);
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        fileName = sku + fileExtension; // Use SKU as the file name

        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);
    }

    con = ConnectionDatabase.getCon();
    pstmt = con.prepareStatement(
        "INSERT INTO product (sku, name, description, price, category, stock, image, status, sellerId, location) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    );

    // Set the parameters for the prepared statement
    pstmt.setString(1, sku);
    pstmt.setString(2, name);
    pstmt.setString(3, description);
    pstmt.setBigDecimal(4, price);
    pstmt.setString(5, category);
    pstmt.setInt(6, stock);
    pstmt.setString(7, fileName); // Store only the file name
    pstmt.setString(8, status);
    pstmt.setInt(9, sellerId);
    pstmt.setString(10, location);

    // Execute the query
    int rowsAffected = pstmt.executeUpdate();

    if (rowsAffected > 0) {
        // Redirect to the listing page after successful insertion
        response.sendRedirect("admin_products.jsp?msg=success");
    } else {
        throw new SQLException("Failed to insert the product.");
    }
} catch (SQLException e) {
    // Log the error
    e.printStackTrace();
    // Redirect with an error message
    response.sendRedirect("addProduct.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
} catch (Exception e) {
    // Log the error
    e.printStackTrace();
    // Redirect with a generic error message
    response.sendRedirect("addProduct.jsp?error=An unexpected error occurred");
} finally {
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { /* ignored */ }
    if (con != null) try { con.close(); } catch (SQLException e) { /* ignored */ }
}
%>

<%!
// Helper method to get the submitted file name
private String getSubmittedFileName(Part part) {
    for (String cd : part.getHeader("content-disposition").split(";")) {
        if (cd.trim().startsWith("filename")) {
            return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
        }
    }
    return null;
}
%>
