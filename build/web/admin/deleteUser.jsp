<%@ page import="java.sql.*" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
try {
    // Get the user ID from the request parameter
    int userId = Integer.parseInt(request.getParameter("id"));

    // Check if the user exists in the payment table
    Connection con = ConnectionDatabase.getCon();
    PreparedStatement psPayment = con.prepareStatement("SELECT * FROM payment WHERE buyerId = ?");
    psPayment.setInt(1, userId);
    ResultSet rsPayment = psPayment.executeQuery();

    if (rsPayment.next()) {
        // If the user has payments, display a message indicating so
        response.sendRedirect("listusers.jsp?msg=payment_exists");
    } else {
        // If the user has no payments, proceed with the deletion
        PreparedStatement psDelete = con.prepareStatement("DELETE FROM user WHERE id = ?");
        psDelete.setInt(1, userId);
        int rowsAffected = psDelete.executeUpdate();
        if (rowsAffected > 0) {
            // Redirect to the list of users with a success message
            response.sendRedirect("listusers.jsp?msg=deleted");
        } else {
            // Redirect to the list of users with an error message
            response.sendRedirect("listusers.jsp?msg=delete_failed");
        }
    }

    con.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("listUsers.jsp?msg=delete_error");
}
%>
