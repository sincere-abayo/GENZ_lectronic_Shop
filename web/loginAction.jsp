
<%@page import="ohsms.ConnectionDatabase"%> <!-- Ensure package name matches your project structure -->
<%@page import="java.sql.*"%>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

try {
    Connection con = ConnectionDatabase.getCon();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE email = ? AND password = ?");
    ps.setString(1, email);
    ps.setString(2, password);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        // Login successful
        int userId = rs.getInt("id");
        String userName = rs.getString("name");
        String userRole = rs.getString("role");  // Assuming you have a 'role' column in the user table
        
        // Set user information in session only if not already set
        if (session.getAttribute("userId") == null) {
            session.setAttribute("userId", userId);
            session.setAttribute("userName", userName);
            session.setAttribute("userRole", userRole);
        }

        // Redirect to appropriate dashboard based on user role
        if ("seller".equals(userRole)) {
            response.sendRedirect("seller&buyer/seller_dashboard.jsp");
        } else if ("buyer".equals(userRole)) {
            response.sendRedirect("seller&buyer/buyer_dashboard.jsp");
        } else {
            // Handle other roles or redirect to a default page
            response.sendRedirect("seller&buyer/default_dashboard.jsp");
        }
    } else {
        // Login failed
        response.sendRedirect("login.jsp?msg=invalid");
    }

    con.close();
} catch (Exception e) {
    e.printStackTrace(); // Log the exception for debugging
    response.sendRedirect("login.jsp?msg=invalid");
}
%>
