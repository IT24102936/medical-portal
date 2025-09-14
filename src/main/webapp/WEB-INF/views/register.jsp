<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Medisphere</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            height: 100vh;
            overflow: hidden;
        }

        .container-fluid, .row {
            height: 100%;
        }

        .branding-section {
            background: linear-gradient(135deg, #0a193a 0%, #033c5a 100%);
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 40px;
            height: 100vh;
            position: relative;
            overflow: hidden;
        }

        .branding-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            z-index: 1;
        }

        .branding-content {
            position: relative;
            z-index: 2;
            animation: fadeIn 1.5s ease-in-out;
        }

        .branding-content h1 {
            font-weight: 700;
            letter-spacing: 1px;
        }

        .form-section {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
            background-color: #ffffff;
            height: 100vh;
            overflow-y: auto;
        }

        .form-wrapper {
            max-width: 700px;
            width: 100%;
            animation: slideInUp 1s ease-in-out;
        }

        .logo {
            display: block;
            margin: 0 auto;
            width: 100px;
            height: 100px;
        }

        .form-section h2 {
            font-weight: 600;
            text-align: center;
            color: #212529;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ced4da;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.2);
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper i {
            position: absolute;
            top: 50%;
            right: 15px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
        }

        .btn-register {
            background: linear-gradient(90deg, #0d6efd 0%, #0558d1 100%);
            border: none;
            padding: 12px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(13, 110, 253, 0.2);
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(13, 110, 253, 0.3);
        }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes slideInUp { from { opacity: 0; transform: translateY(50px); } to { opacity: 1; transform: translateY(0); } }

        @media (max-width: 991.98px) {
            body {
                overflow: auto;
            }
            .branding-section {
                display: none;
            }
            .form-section {
                padding: 40px 25px;
            }
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-lg-5 branding-section">
            <div class="branding-content">
                <h1 class="display-4">Join Medisphere</h1>
                <p class="lead">Pioneering the Future of Digital Healthcare</p>
            </div>
        </div>

        <div class="col-lg-7 form-section">
            <div class="form-wrapper">
                <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" class="logo mb-4">
                <h2 class="mb-4">Create Your Employee Account</h2>

                <!-- Error Message Display -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <form id="registrationForm" action="/register" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="nationalId" class="form-label">National ID</label>
                            <input type="text" class="form-control" id="nationalId" name="nationalId" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="dob" class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" id="dob" name="dob" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="gender" class="form-label">Gender</label>
                            <select class="form-select" id="gender" name="gender" required>
                                <option value="" selected disabled>Select...</option>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                        <div class="col-12 mb-3">
                            <label for="employeeType" class="form-label">Employee Type</label>
                            <select class="form-select" id="employeeType" name="employeeType" required>
                                <option value="" selected disabled>Select your role...</option>
                                <option value="doctor">Doctor</option>
                                <option value="lab_assistant">Lab Assistant</option>
                                <option value="pharmacist">Pharmacist</option>
                                <option value="pharmacist">Receptionist</option>
                                <option value="finance_manager">Finance Manager</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        </div>
                    </div>

                    <div class="d-grid mt-3">
                        <button type="submit" class="btn btn-primary btn-register">Create Account</button>
                    </div>
                </form>

                <p class="mt-4 text-center text-muted">
                    Already have an account?
                    <a href="/login" class="text-decoration-none">Sign In</a>
                </p>
                <p class="mt-2 text-center">
                    <a href="/" class="text-muted text-decoration-none">
                        <i class="bi bi-arrow-left"></i> Back to Home
                    </a>
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('registrationForm').addEventListener('submit', function(event) {
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        if (password.value !== confirmPassword.value) {
            event.preventDefault();
            alert("Passwords do not match. Please try again.");
            confirmPassword.focus();
            confirmPassword.classList.add('is-invalid');
        } else {
            confirmPassword.classList.remove('is-invalid');
        }
    });
</script>
</body>
</html>
