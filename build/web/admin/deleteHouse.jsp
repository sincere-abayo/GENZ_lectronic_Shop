<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%
// Check if the 'id' parameter is present in the request URL
if(request.getParameter("id") != null) {
    int houseId = Integer.parseInt(request.getParameter("id"));
    
    try {
        Connection con = ConnectionDatabase.getCon();
        
        // Check if the house exists in the payment table
        PreparedStatement psCheckPayment = con.prepareStatement("SELECT * FROM payment WHERE houseId = ?");
        psCheckPayment.setInt(1, houseId);
        ResultSet rsPayment = psCheckPayment.executeQuery();
        
        if (rsPayment.next()) {
            // House exists in the payment table, so it cannot be deleted
            out.println("Cannot delete the house. It has pending payments associated with it.");
        } else {
            // House does not exist in the payment table, proceed with deletion
            PreparedStatement psDeleteHouse = con.prepareStatement("DELETE FROM house WHERE id = ?");
            psDeleteHouse.setInt(1, houseId);
            
            // Execute the delete query
            int rowsAffected = psDeleteHouse.executeUpdate();
            
            if(rowsAffected > 0) {
                // House deleted successfully
                response.sendRedirect("admin_houses.jsp?msg=deleted"); // Redirect to admin_houses.jsp with a success message
            } else {
                // No house found with the provided ID
                out.println("House with ID " + houseId + " not found.");
            }
        }
        
        con.close();
    } catch (Exception e) {
        // Print stack trace in case of an exception
        e.printStackTrace();
        out.println("An error occurred while deleting the house.");
    }
} else {
    // 'id' parameter not found in the request URL
    out.println("House ID not provided.");
}
%>
