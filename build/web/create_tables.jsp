<%@ page import="ohsms.ConnectionDatabase" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
try {
    Connection con = ConnectionDatabase.getCon();
    Statement st = con.createStatement();

    // Table for Users
    String createUserTable = "CREATE TABLE user (" +
            "id INT PRIMARY KEY AUTO_INCREMENT," +
            "name VARCHAR(100) NOT NULL," +  
            "email VARCHAR(100) UNIQUE NOT NULL," +
            "mobileNumber VARCHAR(20) NOT NULL," +
            "securityQuestion VARCHAR(255) NOT NULL," +
            "answer VARCHAR(255) NOT NULL," +
            "password VARCHAR(100) NOT NULL," +
            "address VARCHAR(255) NOT NULL," +
            "city VARCHAR(50) NOT NULL," +
            "state VARCHAR(50) NOT NULL," +
            "country VARCHAR(50) NOT NULL," +
            "status VARCHAR(20) DEFAULT 'Active'" +
            ")";
    st.execute(createUserTable);

    // Table for Houses
    String createHouseTable = "CREATE TABLE house (" +
            "id INT PRIMARY KEY AUTO_INCREMENT," +
            "upiNumber VARCHAR(100) NOT NULL," +
            "description TEXT," +
            "price DECIMAL(10,2) NOT NULL," +
            "location VARCHAR(100) NOT NULL," +
            "sellerId INT," +
            "pic BLOB, " +
            "status VARCHAR(20) DEFAULT 'Available'," +
            "FOREIGN KEY (sellerId) REFERENCES user(id)" +
            ")";
    st.execute(createHouseTable);

    // Table for Payments
    String createPaymentTable = "CREATE TABLE payment (" +
            "id INT PRIMARY KEY AUTO_INCREMENT," + // Primary key for the payment table
            "houseId INT," +  // Foreign key from the house table
            "buyerId INT," +   // Foreign key from the user table
            "amount DECIMAL(10,2) NOT NULL," +
            "status VARCHAR(20) DEFAULT 'Pending'," +
            "FOREIGN KEY (houseId) REFERENCES house(id)," +  // Reference to house table
            "FOREIGN KEY (buyerId) REFERENCES user(id)" +     // Reference to user table
            ")";
    st.execute(createPaymentTable);

    // Table for Admin
    String createAdminTable = "CREATE TABLE admin (" +
            "id INT PRIMARY KEY AUTO_INCREMENT," +
            "username VARCHAR(100) UNIQUE NOT NULL," +
            "password VARCHAR(100) NOT NULL" +
            ")";
    st.execute(createAdminTable);

    System.out.println("Tables created successfully");
    String e = "Tables created successfully";
    %><div id="messageDiv" style="display:none;" class="alert alert-success" role="alert">
    <%= e %><script>
    // Function to display the message after 2 seconds
    setTimeout(function() {
        document.getElementById("messageDiv").style.display = "block";
    }, 2000); // 2000 milliseconds = 2 seconds
</script><%
    con.close();
} catch (Exception e) {
	
    System.out.println(e);
    %><div id="messageDiv" style="display:none;" class="alert alert-denger" role="alert">
    <%= e %><script>
    // Function to display the message after 2 seconds
    setTimeout(function() {
        document.getElementById("messageDiv").style.display = "block";
    }, 2000); // 2000 milliseconds = 2 seconds
</script><%
}


%>



