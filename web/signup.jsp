<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup - GENZ Electronic Shop</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .signup-container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 50px;
            margin-bottom: 50px;
        }
        .form-label {
            font-weight: 600;
        }
        .btn-signup {
            background-color: #007bff;
            border-color: #007bff;
            padding: 10px 20px;
            font-size: 18px;
            font-weight: 600;
        }
        .btn-signup:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .alert {
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 signup-container">
                <h2 class="text-center mb-4">
                    <i class="fas fa-user-plus me-2"></i>GENZ Electronic Shop - Signup
                </h2>

                <form action="signupAction.jsp" method="post">
                    <div class="row">
                        <!-- First Column -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="name" class="form-label"><i class="fas fa-user me-2"></i>Name</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label"><i class="fas fa-envelope me-2"></i>Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="mobileNumber" class="form-label"><i class="fas fa-phone me-2"></i>Mobile Number</label>
                                <input type="tel" name="mobileNumber" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="securityQuestion" class="form-label"><i class="fas fa-question-circle me-2"></i>Security Question</label>
                                <select name="securityQuestion" class="form-select">
                                    <option value="What was your first car?">What was your first car?</option>
                                    <option value="What is the name of your first pet?">What is the name of your first pet?</option>
                                    <!-- Add other options -->
                                </select>  
                            </div>
                            <div class="mb-3">
                                <label for="answer" class="form-label"><i class="fas fa-key me-2"></i>Security Answer</label>
                                <input type="text" name="answer" class="form-control" required>
                            </div>
                        </div>

                        <!-- Second Column -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="password" class="form-label"><i class="fas fa-lock me-2"></i>Password</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label"><i class="fas fa-home me-2"></i>Address</label>
                                <input type="text" name="address" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="city" class="form-label"><i class="fas fa-city me-2"></i>City</label>
                                <input type="text" name="city" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="state" class="form-label"><i class="fas fa-map-marker-alt me-2"></i>State</label>
                                <input type="text" name="state" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="country" class="form-label"><i class="fas fa-globe me-2"></i>Country</label>
                                <input type="text" name="country" class="form-control" required>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-primary btn-signup">
                            <i class="fas fa-user-plus me-2"></i>Sign Up
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <% 
        String msg = request.getParameter("msg");
        if (msg != null) {
            String alertClass = "";
            String iconClass = "";
            String title = "";
            String message = "";

            if ("valid".equals(msg)) {
                alertClass = "alert-success";
                iconClass = "fas fa-check-circle";
                title = "Successfully registered";
                message = "Thank you for joining our GENZ Electronic Shop!";
            } else if ("invalid".equals(msg)) {
                alertClass = "alert-danger";
                iconClass = "fas fa-exclamation-circle";
                title = "Registration failed!";
                message = "Something went wrong during the registration process. Please try again.";
            } else if ("email_exists".equals(msg)) {
                alertClass = "alert-warning";
                iconClass = "fas fa-exclamation-triangle";
                title = "Email already exists!";
                message = "This email address is already registered in our system. Please choose a different email.";
            }
        %>
        <div class="row justify-content-center mt-4">
            <div class="col-md-8">
                <div class="alert <%= alertClass %>" role="alert">
                    <h4 class="alert-heading"><i class="<%= iconClass %> me-2"></i><%= title %></h4>
                    <p><%= message %></p>
                </div>
            </div>
        </div>
        <% 
        }
        %>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
