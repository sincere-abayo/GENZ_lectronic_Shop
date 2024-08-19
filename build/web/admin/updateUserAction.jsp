<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>

<%
// Get user details from the form
int userId = Integer.parseInt(request.getParameter("id"));
String name = request.getParameter("name");
String email = request.getParameter("email");
String mobileNumber = request.getParameter("mobileNumber");
String securityQuestion = request.getParameter("securityQuestion");
String answer = request.getParameter("answer");
String password = request.getParameter("password");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String country = request.getParameter("country");
String status = request.getParameter("status");

try {
    Connection con = ConnectionDatabase.getCon();

    // Update user information in the database
    PreparedStatement ps = con.prepareStatement("UPDATE user SET name=?, email=?, mobileNumber=?, securityQuestion=?, answer=?, password=?, address=?, city=?, state=?, country=?, status=? WHERE id=?");
    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, mobileNumber);
    ps.setString(4, securityQuestion);
    ps.setString(5, answer);
    ps.setString(6, password);
    ps.setString(7, address);
    ps.setString(8, city);
    ps.setString(9, state);
    ps.setString(10, country);
    ps.setString(11, status);
    ps.setInt(12, userId);

    int rowsAffected = ps.executeUpdate();

    if (rowsAffected > 0) {
        // User information updated successfully
        response.sendRedirect("listusers.jsp?msg=update_success");
    } else {
        // Update failed
        response.sendRedirect("updateUser.jsp?id=" + userId + "&msg=update_failed");
    }

    con.close();
} catch (Exception e) {
    e.printStackTrace(); // Log the exception for debugging
    response.sendRedirect("updateUser.jsp?id=" + userId + "&msg=update_error");
}
%>
