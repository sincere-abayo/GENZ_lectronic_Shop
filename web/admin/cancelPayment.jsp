<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="ohsms.ConnectionDatabase" %>

<%
    // Retrieve houseId parameter from request
    int houseId = Integer.parseInt(request.getParameter("houseId"));
    
    try {
        // Update payment status in the database
        Connection con = ConnectionDatabase.getCon();
        PreparedStatement ps = con.prepareStatement("UPDATE payment SET status = 'Canceled' WHERE houseId = ?");
        ps.setInt(1, houseId);
        int rowsAffected = ps.executeUpdate();
        
        if (rowsAffected > 0) {
        	PreparedStatement pstmt = con.prepareStatement("UPDATE house SET status=? WHERE id=?");
        	pstmt.setString(1, "Available");
        	pstmt.setInt(2, houseId);
        	int rowsAffected2 = pstmt.executeUpdate();
            // Payment canceled successfully
            out.println("Payment canceled for House ID: " + houseId);
        } else {
            // No rows affected, payment cancellation failed
            out.println("Error: Payment cancellation failed for House ID: " + houseId);
        }
        
        // Close resources
        ps.close();
        con.close();
    } catch (Exception e) {
        // Log exception
        e.printStackTrace();
        out.println("Error: An unexpected error occurred. Please try again later.");
    }
%>
