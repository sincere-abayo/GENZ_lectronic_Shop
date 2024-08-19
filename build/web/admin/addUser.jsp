<jsp:include page="adminheader.jsp" />
    <div id="container" class="container mt-5">
        <div class="signup">
            <form action="addUserAction.jsp" method="post">
                <h2>Form Of New User Signup</h2>

                <div class="row">
                    <!-- First Column -->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Enter Name</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Enter Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="mobileNumber" class="form-label">Enter Mobile Number</label>
                            <input type="number" name="mobileNumber" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="securityQuestion" class="form-label">Security Question</label>
                            <select name="securityQuestion" class="form-select">
                                <option value="What was your first car?">What was your first car?</option>
                                <option value="What is the name first pet?">What is the name first pet?</option>
                                <!-- Add other options -->
                            </select>  
                        </div>
                        <div class="mb-3">
                            <label for="answer" class="form-label">Enter Answer</label>
                            <input type="text" name="answer" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Enter Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                    </div>

                    <!-- Second Column -->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="address" class="form-label">Enter Address</label>
                            <input type="text" name="address" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="city" class="form-label">Enter City</label>
                            <input type="text" name="city" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="state" class="form-label">Enter State</label>
                            <input type="text" name="state" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="country" class="form-label">Enter Country</label>
                            <input type="text" name="country" class="form-control" required>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">Signup</button>
            </form>
        </div>

        <% 
            String msg = request.getParameter("msg");
            if (msg != null && "valid".equals(msg)) {
        %>
        <div class="whysign mt-3">
            <h1 class="text-success">Successfully registered</h1>
            <h2>Thank you for joining our Online House Selling System!</h2>
        </div>
        <% 
            } else if (msg != null && "invalid".equals(msg)) {
        %>
        <div class="whysign mt-3">
            <h1 class="text-danger">Registration failed! Please try again.</h1>
            <h2>Something went wrong during the registration process.</h2>
        </div>
        <% 
            } else if (msg != null && "email_exists".equals(msg)) {
        %>
        <div class="whysign mt-3">
            <h1 class="text-warning">Email already exists! Please choose a different email.</h1>
            <h2>This email address is already registered in our system.</h2>
        </div>
        <% 
            }
        %>
    </div>
    <jsp:include page="adminfooter.jsp" />

    <!-- Include Bootstrap JS and Popper.js if needed -->
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
