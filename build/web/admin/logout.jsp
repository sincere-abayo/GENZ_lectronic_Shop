<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>
<%
    // Invalidate the session to logout the user
    HttpSession sessions = request.getSession(false);
    if(sessions != null) {
        sessions.invalidate();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
    <!-- Include Bootstrap CSS -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Logged out successfully</h2>
        <p>You have been logged out. Redirecting to <a href="index.jsp">index page</a>...</p>
    </div>

    <!-- Include Bootstrap JS and Popper.js -->
    <script src="../bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <!-- Redirect to index page after 3 seconds -->
    <script>
        setTimeout(function() {
            window.location.href = "../";
        }, 2000); // 3000 milliseconds = 3 seconds
    </script>
</body>
</html>
