<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>

<%
// Get user registration data from the form
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

try {
    Connection con = ConnectionDatabase.getCon();
    
    // Check if the email already exists in the database
    PreparedStatement checkEmailPS = con.prepareStatement("SELECT * FROM user WHERE email = ?");
    checkEmailPS.setString(1, email);
    ResultSet checkEmailRS = checkEmailPS.executeQuery();
    
    if (checkEmailRS.next()) {
        // Email already exists, redirect with a message
        response.sendRedirect("addUser.jsp?msg=email_exists");
    } else {
        // Email doesn't exist, proceed with user registration
        PreparedStatement ps = con.prepareStatement("INSERT INTO user (name, email, mobileNumber, securityQuestion, answer, password, address, city, state, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
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

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            // User registration successful, redirect with a success message
            response.sendRedirect("listusers.jsp?msg=valid");
        } else {
            // User registration failed, redirect with an error message
            response.sendRedirect("addUser.jsp?msg=invalid");
        }
    }

    con.close();
} catch (Exception e) {
    e.printStackTrace(); // Log the exception for debugging
    response.sendRedirect("addUser.jsp?msg=invalid");
}
%>
