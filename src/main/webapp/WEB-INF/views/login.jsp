<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Medisphere Medical Portal</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --light-gray: #ecf0f1;
            --dark-gray: #7f8c8d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
            margin: 20px;
            min-height: 600px;
        }

        .login-left {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .login-left::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="white" stroke-width="0.5" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>') repeat;
            animation: moveGrid 20s linear infinite;
        }

        @keyframes moveGrid {
            0% { transform: translate(0, 0); }
            100% { transform: translate(10px, 10px); }
        }

        .login-left h1 {
            font-size: 2.5rem;
            font-weight: 900;
            margin-bottom: 1rem;
            z-index: 2;
            position: relative;
        }

        .login-left p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 2rem;
            z-index: 2;
            position: relative;
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            z-index: 2;
            position: relative;
        }

        .feature-icon .material-symbols-outlined {
            font-size: 2.5rem;
        }

        .login-right {
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h2 {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .role-badge {
            display: inline-block;
            background: var(--secondary-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 1rem;
        }

        .form-floating {
            margin-bottom: 1.5rem;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        .btn-login {
            background: linear-gradient(135deg, var(--secondary-color) 0%, var(--primary-color) 100%);
            border: none;
            padding: 1rem 2rem;
            border-radius: 10px;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            width: 100%;
            margin-bottom: 1.5rem;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            color: white;
        }

        .btn-login:disabled {
            opacity: 0.7;
            transform: none;
        }

        .register-link {
            text-align: center;
            margin-top: 1rem;
        }

        .register-link a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .register-link a:hover {
            color: var(--primary-color);
            text-decoration: underline;
        }

        .alert {
            border-radius: 10px;
            margin-bottom: 1.5rem;
            border: none;
            padding: 1rem 1.5rem;
        }

        .back-to-home {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }

        .back-to-home a {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            background: rgba(255, 255, 255, 0.2);
        }

        .back-to-home a:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
        }

        .back-to-home .material-symbols-outlined {
            font-size: 1.2rem;
            margin-right: 0.5rem;
        }

        @media (max-width: 768px) {
            .login-container {
                margin: 10px;
                flex-direction: column;
            }
            
            .login-left {
                padding: 40px 20px;
            }
            
            .login-right {
                padding: 40px 20px;
            }
            
            .login-left h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="back-to-home">
        <a href="/">
            <span class="material-symbols-outlined">arrow_back</span>
            Back to Home
        </a>
    </div>

    <div class="login-container row g-0">
        <!-- Left Side - Branding -->
        <div class="col-lg-6 login-left">
            <div>
                <div class="feature-icon">
                    <span class="material-symbols-outlined">local_hospital</span>
                </div>
                <h1>Medisphere</h1>
                <p>Advanced Medical Portal for Healthcare Professionals</p>
                <div class="mt-4">
                    <h5>🏥 Secure Access</h5>
                    <p class="small">Professional healthcare management platform</p>
                </div>
            </div>
        </div>

        <!-- Right Side - Login Form -->
        <div class="col-lg-6 login-right">
            <div class="login-header">
                <h2>Welcome Back</h2>
                <c:choose>
                    <c:when test="${param.role == 'pharmacist'}">
                        <span class="role-badge">💊 Pharmacist Login</span>
                    </c:when>
                    <c:when test="${param.role == 'lab-technician'}">
                        <span class="role-badge">🧪 Lab Technician Login</span>
                    </c:when>
                    <c:otherwise>
                        <span class="role-badge">🏥 Staff Login</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Flash Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <span class="material-symbols-outlined me-2">check_circle</span>
                    ${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    <span class="material-symbols-outlined me-2">error</span>
                    ${errorMessage}
                </div>
            </c:if>

            <form method="post" action="/auth/login" id="loginForm">
                <input type="hidden" name="role" value="${param.role != null ? param.role : 'pharmacist'}">
                
                <div class="form-floating">
                    <input type="text" class="form-control" id="usernameOrEmail" name="usernameOrEmail" 
                           placeholder="Username or Email" required>
                    <label for="usernameOrEmail">
                        <span class="material-symbols-outlined me-2">person</span>
                        Username or Email
                    </label>
                </div>

                <div class="form-floating">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Password" required>
                    <label for="password">
                        <span class="material-symbols-outlined me-2">lock</span>
                        Password
                    </label>
                </div>

                <button type="submit" class="btn btn-login" id="loginBtn">
                    <span class="material-symbols-outlined me-2">login</span>
                    Sign In
                </button>
            </form>

            <div class="register-link">
                <p>Don't have an account? 
                    <a href="/auth/register?role=${param.role != null ? param.role : 'pharmacist'}">
                        Register here
                    </a>
                </p>
            </div>

            <!-- Role Selection -->
            <div class="text-center mt-3">
                <small class="text-muted">Login as different role:</small><br>
                <c:if test="${param.role != 'pharmacist'}">
                    <a href="/auth/login?role=pharmacist" class="btn btn-outline-primary btn-sm me-2 mt-2">
                        💊 Pharmacist
                    </a>
                </c:if>
                <c:if test="${param.role != 'lab-technician'}">
                    <a href="/auth/login?role=lab-technician" class="btn btn-outline-success btn-sm mt-2">
                        🧪 Lab Technician
                    </a>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add loading state to login form
        document.getElementById('loginForm').addEventListener('submit', function() {
            const loginBtn = document.getElementById('loginBtn');
            const originalText = loginBtn.innerHTML;
            
            loginBtn.disabled = true;
            loginBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Signing In...';
            
            // Re-enable after 10 seconds as fallback
            setTimeout(() => {
                loginBtn.disabled = false;
                loginBtn.innerHTML = originalText;
            }, 10000);
        });

        // Auto-focus on first input
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('usernameOrEmail').focus();
        });

        // Basic client-side validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const usernameOrEmail = document.getElementById('usernameOrEmail').value.trim();
            const password = document.getElementById('password').value;
            
            if (!usernameOrEmail) {
                e.preventDefault();
                alert('Please enter your username or email');
                return;
            }
            
            if (!password) {
                e.preventDefault();
                alert('Please enter your password');
                return;
            }
        });
    </script>
</body>
</html>