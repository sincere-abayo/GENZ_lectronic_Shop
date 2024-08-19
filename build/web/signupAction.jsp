<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
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
    PreparedStatement checkEmailPs = con.prepareStatement("SELECT COUNT(*) FROM `user` WHERE `email` = ?");
    checkEmailPs.setString(1, email);
    ResultSet checkEmailResult = checkEmailPs.executeQuery();

    if (checkEmailResult.next() && checkEmailResult.getInt(1) > 0) {
        // Email already exists in the database
        response.sendRedirect("signup.jsp?msg=email_exists");
    } else {
        // Email does not exist, proceed with the registration
        PreparedStatement ps = con.prepareStatement("INSERT INTO `user` (`name`, `email`, `mobileNumber`, `securityQuestion`, `answer`, `password`, `address`, `city`, `state`, `country`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
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
            // User registration successful
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                int userId = generatedKeys.getInt(1);

                // Determine user role (e.g., you might have a separate column for user role in the database)
                String userRole = "buyer"; // Replace this with actual logic to determine user role

                // Redirect to login page
                response.sendRedirect("login.jsp");
            } else {
                // Unable to retrieve generated keys
                response.sendRedirect("signup.jsp?msg=invalid");
            }
        } else {
            // User registration failed
            response.sendRedirect("signup.jsp?msg=invalid");
        }
    }

    con.close();
} catch (Exception e) {
    e.printStackTrace(); // Log the exception for debugging
    response.sendRedirect("signup.jsp?msg=invalid");
}
%>
