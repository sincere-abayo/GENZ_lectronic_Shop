<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<jsp:include page="adminheader.jsp" />

<%
String userIdParam = request.getParameter("id");

if (userIdParam != null) {
    int userId = Integer.parseInt(userIdParam);

    try {
        Connection con = ConnectionDatabase.getCon();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE id = ?");
        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // Fetch user details
            String name = rs.getString("name");
            String email = rs.getString("email");
            String mobileNumber = rs.getString("mobileNumber");
            String securityQuestion = rs.getString("securityQuestion");
            String answer = rs.getString("answer");
            String password = rs.getString("password");
            String address = rs.getString("address");
            String city = rs.getString("city");
            String state = rs.getString("state");
            String country = rs.getString("country");
            String status = rs.getString("status"); // Assuming status is a field in your database

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update User</title>
    <!-- Include Bootstrap CSS -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h2 class="text-center">Update User</h2>
                </div>
                <div class="card-body">
                    <form action="updateUserAction.jsp" method="post">
                        <!-- Include userId as a hidden input to pass it to updateUserAction.jsp -->
                        <input type="hidden" name="id" value="<%= userId %>">
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" class="form-control" name="name" value="<%= name %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" value="<%= email %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="mobileNumber" class="form-label">Mobile Number</label>
                            <input type="number" class="form-control" name="mobileNumber" value="<%= mobileNumber %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="securityQuestion" class="form-label">Security Question</label>
                            <input type="text" class="form-control" name="securityQuestion" value="<%= securityQuestion %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="answer" class="form-label">Answer</label>
                            <input type="text" class="form-control" name="answer" value="<%= answer %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" value="<%= password %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" name="address" value="<%= address %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="city" class="form-label">City</label>
                            <input type="text" class="form-control" name="city" value="<%= city %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="state" class="form-label">State</label>
                            <input type="text" class="form-control" name="state" value="<%= state %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="country" class="form-label">Country</label>
                            <input type="text" class="form-control" name="country" value="<%= country %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <input type="text" class="form-control" name="status" value="<%= status %>" required>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="adminfooter.jsp" />

<!-- Include Bootstrap JS and Popper.js -->
<script src="../bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
        } else {
            // User not found
            response.sendRedirect("listusers.jsp?msg=user_not_found");
        }

        con.close();
    } catch (Exception e) {
        //e.printStackTrace();
        System.out.print(e);
        //response.sendRedirect("listusers.jsp?msg=error");
    }
} else {
    // userIdParam is null
    response.sendRedirect("listusers.jsp?msg=invalid_id");
}
%>
