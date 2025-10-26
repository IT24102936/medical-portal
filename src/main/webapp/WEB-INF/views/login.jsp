<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login - Medisphere</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>

        /* All CSS is now inside this <style> tag */

        

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

        /* Branding Section Styling */

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

        /* Form Section Styling */

        .form-section {

            display: flex;

            justify-content: center;

            align-items: center;

            padding: 20px;

            background-color: #ffffff;

            height: 100vh;

            overflow-y: auto;

        }

        .login-wrapper {

            max-width: 400px;

            width: 100%;

            animation: slideInUp 1s ease-in-out;

        }

        .logo {

            display: block;

            margin: 0 auto;

            width: 120px;

            height: 120px;

            object-fit: contain;

            max-width: 100%;

        }

        .form-section h2 {

            font-weight: 600;

            text-align: center;

            color: #212529;

        }

        .form-section .text-muted {

            text-align: center;

            font-size: 0.95rem;

        }

        .form-control {

            border-radius: 8px;

            padding: 12px 15px;

            border: 1px solid #ced4da;

            transition: all 0.3s ease;

        }

        .form-control:focus {

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

        .forgot-password-link, .signup-link {

            font-size: 0.9rem;

            color: #0d6efd;

            text-decoration: none;

            transition: color 0.3s ease;

        }

        .forgot-password-link:hover, .signup-link:hover {

            color: #0a58ca;

            text-decoration: underline;

        }

        .form-check-input:checked {

            background-color: #0d6efd;

            border-color: #0d6efd;

        }

        .form-check-label {

            font-size: 0.9rem;

        }

        .btn-login {

            background: linear-gradient(90deg, #0d6efd 0%, #0558d1 100%);

            border: none;

            padding: 12px;

            font-weight: 500;

            border-radius: 8px;

            transition: all 0.3s ease;

            box-shadow: 0 4px 15px rgba(13, 110, 253, 0.2);

        }

        .btn-login:hover {

            transform: translateY(-2px);

            box-shadow: 0 6px 20px rgba(13, 110, 253, 0.3);

        }

        /* Animations */

        @keyframes fadeIn {

            from { opacity: 0; transform: translateY(-20px); }

            to { opacity: 1; transform: translateY(0); }

        }

        @keyframes slideInUp {

            from { opacity: 0; transform: translateY(50px); }

            to { opacity: 1; transform: translateY(0); }

        }

        /* ===== Responsive Design & Mobile Fixes ===== */

        @media (max-width: 991.98px) {

            body {

                overflow: auto; /* Allow scrolling on smaller screens */

            }

            .branding-section {

                height: auto;

                /* --- MOBILE IMPROVEMENT: Reduced height --- */

                min-height: 200px; 

            }

            /* --- MOBILE IMPROVEMENT: Made title smaller --- */

            .branding-content h1 {

                font-size: 2.8rem;

            }

            .form-section {

                height: auto;

                /* --- MOBILE IMPROVEMENT: Adjusted padding --- */

                padding: 40px 25px; 

            }

            /* --- MOBILE IMPROVEMENT: Smaller logo on mobile --- */

            .logo {

                width: 100px;

                height: 100px;

                object-fit: contain;

            }

        }

    </style>

</head>

<body>

    <div class="container-fluid">

        <div class="row">

            <div class="col-lg-6 col-md-12 branding-section">

                <div class="branding-content">

                    <h1 class="display-3">Medisphere</h1>

                    <p class="lead">Your Gateway to Integrated Healthcare</p>

                </div>

            </div>

            <div class="col-lg-6 col-md-12 form-section">

                <div class="login-wrapper">

                    <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" class="logo mb-4">

                    <h2 class="mb-3">Welcome Back</h2>

                    <p class="text-muted mb-4">Please enter your details to sign in.</p>

                    <c:if test="${error != null}">

                        <div class="alert alert-danger" role="alert">

                            ${error}

                        </div>

                    </c:if>

                    <c:if test="${param.logout != null}">

                        <div class="alert alert-success" role="alert">

                            You have been logged out successfully.

                        </div>

                    </c:if>

                    <c:if test="${param.registered != null}">

                        <div class="alert alert-success" role="alert">

                            Registration successful! Please login with your credentials.

                        </div>

                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">

                        <div class="mb-3">

                            <label for="username" class="form-label">Email</label>

                            <input type="email" class="form-control" id="username" name="username" placeholder="Enter your email" required>

                        </div>

                        <div class="mb-3">

                            <label for="password" class="form-label">Password</label>

                            <div class="password-wrapper">

                                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>

                                <i class="bi bi-eye-slash-fill" id="togglePassword"></i>

                            </div>

                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-4">

                            <div class="form-check">

                                <input class="form-check-input" type="checkbox" value="" id="remember-me" name="remember-me">

                                <label class="form-check-label" for="remember-me">

                                    Remember me

                                </label>

                            </div>

                            <a href="#" class="forgot-password-link">Forgot Password?</a>

                        </div>

                        <div class="d-grid">

                            <button type="submit" class="btn btn-primary btn-login">Sign In</button>

                        </div>

                    </form>

                    <p class="mt-4 text-center text-muted">

                        Don't have an account? <a href="${pageContext.request.contextPath}/register" class="signup-link">Sign Up</a>

                    </p>

                </div>

            </div>

        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>

        document.addEventListener('DOMContentLoaded', function () {

            const togglePassword = document.querySelector('#togglePassword');

            const password = document.querySelector('#password');

            if (togglePassword) {

                togglePassword.addEventListener('click', function (e) {

                    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';

                    password.setAttribute('type', type);

                    this.classList.toggle('bi-eye');

                    this.classList.toggle('bi-eye-slash-fill');

                });

            }

        });

    </script>

</body>

</html>