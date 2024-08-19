<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="ohsms.ConnectionDatabase" %>

<%
String houseIdParam = request.getParameter("id");
String upiNumber = request.getParameter("upiNumber");
String description = request.getParameter("description");
String priceParam = request.getParameter("price");
String location = request.getParameter("location");
String sellerIdParam = request.getParameter("sellerId");
String status = request.getParameter("status");

if (houseIdParam != null && upiNumber != null && description != null && priceParam != null
        && location != null && sellerIdParam != null && status != null) {
    int houseId = Integer.parseInt(houseIdParam);
    BigDecimal price = new BigDecimal(priceParam);
    int sellerId = Integer.parseInt(sellerIdParam);

    try {
        Connection con = ConnectionDatabase.getCon();
        PreparedStatement pstmt = con.prepareStatement("UPDATE house SET upiNumber=?, description=?, price=?, location=?, sellerId=?, status=? WHERE id=?");
        pstmt.setString(1, upiNumber);
        pstmt.setString(2, description);
        pstmt.setBigDecimal(3, price);
        pstmt.setString(4, location);
        pstmt.setInt(5, sellerId);
        pstmt.setString(6, status);
        pstmt.setInt(7, houseId);

        int rowsUpdated = pstmt.executeUpdate();

        if (rowsUpdated > 0) {
            response.sendRedirect("admin_houses.jsp?msg=update_success");
        } else {
            response.sendRedirect("admin_houses.jsp?msg=update_failed");
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("admin_houses.jsp?msg=error");
    }
} else {
    response.sendRedirect("admin_houses.jsp?msg=invalid_parameters");
}
%>
