<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%
try {
    Connection con = ConnectionDatabase.getCon();
    int houseId = Integer.parseInt(request.getParameter("houseId"));

    // Update the status of the house to indicate approval
    PreparedStatement updateStatement = con.prepareStatement("UPDATE house SET status = 'Approved' WHERE id = ?");
    updateStatement.setInt(1, houseId);
    int rowsAffected = updateStatement.executeUpdate();

    con.close();
} catch (Exception e) {
    e.printStackTrace();
    response.setStatus(500); // Internal Server Error
}
%>
