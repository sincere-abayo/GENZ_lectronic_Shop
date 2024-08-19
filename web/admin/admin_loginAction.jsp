<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.io.IOException" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Connection con = ConnectionDatabase.getCon();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM admin WHERE username='" + username + "' AND password='" + password + "'");

        if (rs.next()) {
            // Admin login successful
            // Create session
            HttpSession sessions = request.getSession();
            sessions.setAttribute("adminId", rs.getInt("id"));
            sessions.setAttribute("adminUsername", rs.getString("username"));
            // Redirect to admin home page
            response.sendRedirect("admin_home.jsp");
        } else {
            // Admin login failed
            response.sendRedirect("admin_login.jsp?error=invalid_credentials");
        }

        con.close();
    } catch (Exception e) {
        // Handle exceptions, you might want to log them
        response.sendRedirect("admin_login.jsp?error=database_error");
    }
%>
