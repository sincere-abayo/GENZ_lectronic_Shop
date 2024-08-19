<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse" %>
<html>
<head>
    <title>Example JSP Page</title>
</head>
<body>
    <%-- Accessing HttpServletRequest and HttpServletResponse objects --%>
    <%
        // Accessing HttpServletRequest object
        HttpServletRequest httpRequest = request;

        // Accessing HttpServletResponse object
        HttpServletResponse httpResponse = response;

        // Example usage
        String clientIP = httpRequest.getRemoteAddr();
        String userAgent = httpRequest.getHeader("User-Agent");
    %>

    <h1>Example JSP Page</h1>
    <p>Client IP: <%= clientIP %></p>
    <p>User Agent: <%= userAgent %></p>
</body>
</html>
