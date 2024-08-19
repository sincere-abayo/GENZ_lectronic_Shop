<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="adminheader.jsp" />
<html>
<head>
    <title>List Users</title>
    <!-- Include Bootstrap CSS -->
    
    
</head>
<body>

<div class="container mt-5">
    <h2>List of Users</h2>

    <!-- Add User Button -->
    <a href="addUser.jsp" class="btn btn-success mb-3">Add User</a>

    <% 
    try {
        Connection con = ConnectionDatabase.getCon();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM user");

        // Check if the result set is not empty
        if (rs.next()) {
            // Display table header
            %>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Mobile Number</th>
                        <th>Security Question</th>
                        <th>Answer</th>
                        <th>Password</th>
                        <th>Address</th>
                        <th>City</th>
                        <th>State</th>
                        <th>Country</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% 
                // Iterate through the result set and display user information
                do {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("mobileNumber") %></td>
                        <td><%= rs.getString("securityQuestion") %></td>
                        <td><%= rs.getString("answer") %></td>
                        <td><%= rs.getString("password") %></td>
                        <td><%= rs.getString("address") %></td>
                        <td><%= rs.getString("city") %></td>
                        <td><%= rs.getString("state") %></td>
                        <td><%= rs.getString("country") %></td>
                        <td><%= rs.getString("status") %></td>
                        <td>
                            <!-- Update Button -->
                            <a href="updateUser.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Update</a>
                            
                            <!-- Delete Button -->
                            <a href="deleteUser.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                    <%
                } while (rs.next());
                %>
                </tbody>
            </table>
            <%
        } else {
            // Display a message if there are no users
            %>
            <p>No users found.</p>
            <%
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>

</div>
<%--<jsp:include page="adminfooter.jsp" />--%>
<!-- Include Bootstrap JS and Popper.js -->

</body>
</html>
