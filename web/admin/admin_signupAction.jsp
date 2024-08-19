<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.SQLException" %>

<%
try {
    // Get parameters from the request
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Check if the username is already taken
    Connection con = ConnectionDatabase.getCon();
    PreparedStatement checkStatement = con.prepareStatement("SELECT * FROM admin WHERE username = ?");
    checkStatement.setString(1, username);
    ResultSet checkResult = checkStatement.executeQuery();

    if (checkResult.next()) {
        // Username is already taken
        response.sendRedirect("admin_signup.jsp?msg=username_taken");
    } else {
        // Insert the admin into the database
        PreparedStatement insertStatement = con.prepareStatement("INSERT INTO admin (username, password) VALUES (?, ?)");
        insertStatement.setString(1, username);
        insertStatement.setString(2, password);  // Without encryption
        int rowsAffected = insertStatement.executeUpdate();

        if (rowsAffected > 0) {
            // Admin successfully added
            response.sendRedirect("admin_login.jsp?msg=admin_added");
        } else {
            // Failed to add admin
            response.sendRedirect("admin_signup.jsp?msg=admin_not_added");
        }
    }

    con.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("admin_signup.jsp?msg=error");
}
%>
