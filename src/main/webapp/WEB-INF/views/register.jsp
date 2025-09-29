<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Medisphere Medical Portal</title>

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
            padding: 20px 0;
        }

        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 1000px;
            width: 100%;
            margin: 0 auto;
            min-height: 700px;
        }

        .register-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .register-header::before {
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

        .register-header h1 {
            font-size: 2.5rem;
            font-weight: 900;
            margin-bottom: 0.5rem;
            z-index: 2;
            position: relative;
        }

        .role-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 500;
            margin-top: 1rem;
            z-index: 2;
            position: relative;
        }

        .register-body {
            padding: 40px;
        }

        .form-floating {
            margin-bottom: 1.5rem;
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        .btn-register {
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

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            color: white;
        }

        .btn-register:disabled {
            opacity: 0.7;
            transform: none;
        }

        .login-link {
            text-align: center;
            margin-top: 1rem;
        }

        .login-link a {
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .login-link a:hover {
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
            position: fixed;
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

        .password-requirements {
            font-size: 0.875rem;
            color: var(--dark-gray);
            margin-top: 0.5rem;
        }

        .strength-indicator {
            height: 4px;
            background: #e9ecef;
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
        }

        .strength-bar {
            height: 100%;
            transition: width 0.3s ease;
            background: var(--accent-color);
        }

        .strength-bar.weak {
            background: var(--accent-color);
            width: 25%;
        }

        .strength-bar.medium {
            background: var(--warning-color);
            width: 50%;
        }

        .strength-bar.strong {
            background: var(--success-color);
            width: 100%;
        }

        @media (max-width: 768px) {
            .register-container {
                margin: 10px;
            }
            
            .register-header {
                padding: 30px 20px;
            }
            
            .register-body {
                padding: 30px 20px;
            }
            
            .register-header h1 {
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

    <div class="container">
        <div class="register-container">
            <!-- Header -->
            <div class="register-header">
                <h1>Join Medisphere</h1>
                <p>Create your professional healthcare account</p>
                <c:choose>
                    <c:when test="${param.role == 'pharmacist'}">
                        <span class="role-badge">💊 Pharmacist Registration</span>
                    </c:when>
                    <c:when test="${param.role == 'lab-technician'}">
                        <span class="role-badge">🧪 Lab Technician Registration</span>
                    </c:when>
                    <c:otherwise>
                        <span class="role-badge">🏥 Staff Registration</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Body -->
            <div class="register-body">
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

                <form method="post" action="/auth/register" id="registerForm">
                    <input type="hidden" name="role" value="${param.role != null ? param.role : 'pharmacist'}">
                    
                    <div class="row">
                        <!-- Personal Information -->
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="firstName" name="firstName" 
                                       placeholder="First Name" required>
                                <label for="firstName">
                                    <span class="material-symbols-outlined me-2">person</span>
                                    First Name *
                                </label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="lastName" name="lastName" 
                                       placeholder="Last Name" required>
                                <label for="lastName">
                                    <span class="material-symbols-outlined me-2">person</span>
                                    Last Name *
                                </label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="nationalId" name="nationalId" 
                                       placeholder="National ID" required>
                                <label for="nationalId">
                                    <span class="material-symbols-outlined me-2">badge</span>
                                    National ID *
                                </label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="">Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                                <label for="gender">
                                    <span class="material-symbols-outlined me-2">person</span>
                                    Gender *
                                </label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="date" class="form-control" id="dobString" name="dobString" 
                                       placeholder="Date of Birth" required>
                                <label for="dobString">
                                    <span class="material-symbols-outlined me-2">calendar_today</span>
                                    Date of Birth *
                                </label>
                            </div>
                        </div>
                        
                        <!-- Contact Information -->
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="Email Address" required>
                                <label for="email">
                                    <span class="material-symbols-outlined me-2">email</span>
                                    Email Address *
                                </label>
                            </div>
                        </div>
                        
                        <!-- Account Information -->
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="userName" name="userName" 
                                       placeholder="Username" required>
                                <label for="userName">
                                    <span class="material-symbols-outlined me-2">account_circle</span>
                                    Username *
                                </label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Password" required minlength="6">
                                <label for="password">
                                    <span class="material-symbols-outlined me-2">lock</span>
                                    Password *
                                </label>
                            </div>
                            <div class="password-requirements">
                                Password must be at least 6 characters long
                            </div>
                            <div class="strength-indicator">
                                <div class="strength-bar" id="strengthBar"></div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                       placeholder="Confirm Password" required minlength="6">
                                <label for="confirmPassword">
                                    <span class="material-symbols-outlined me-2">lock</span>
                                    Confirm Password *
                                </label>
                            </div>
                        </div>
                        
                        <!-- Salary Information -->
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="number" class="form-control" id="salaryString" name="salaryString" 
                                       placeholder="Salary" value="50000.00" step="0.01" min="0">
                                <label for="salaryString">
                                    <span class="material-symbols-outlined me-2">payments</span>
                                    Salary (LKR)
                                </label>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-register" id="registerBtn">
                        <span class="material-symbols-outlined me-2">person_add</span>
                        Create Account
                    </button>
                </form>

                <div class="login-link">
                    <p>Already have an account? 
                        <a href="/auth/login?role=${param.role != null ? param.role : 'pharmacist'}">
                            Sign in here
                        </a>
                    </p>
                </div>

                <!-- Role Selection -->
                <div class="text-center mt-3">
                    <small class="text-muted">Register as different role:</small><br>
                    <c:if test="${param.role != 'pharmacist'}">
                        <a href="/auth/register?role=pharmacist" class="btn btn-outline-primary btn-sm me-2 mt-2">
                            💊 Pharmacist
                        </a>
                    </c:if>
                    <c:if test="${param.role != 'lab-technician'}">
                        <a href="/auth/register?role=lab-technician" class="btn btn-outline-success btn-sm mt-2">
                            🧪 Lab Technician
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Password strength indicator
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('strengthBar');
            
            let strength = 0;
            
            // Length check
            if (password.length >= 6) strength++;
            if (password.length >= 8) strength++;
            
            // Character variety checks
            if (/[a-z]/.test(password)) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^A-Za-z0-9]/.test(password)) strength++;
            
            // Update strength bar
            strengthBar.className = 'strength-bar';
            if (strength < 3) {
                strengthBar.classList.add('weak');
            } else if (strength < 5) {
                strengthBar.classList.add('medium');
            } else {
                strengthBar.classList.add('strong');
            }
        });

        // Password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.setCustomValidity('Passwords do not match');
            } else {
                this.setCustomValidity('');
            }
        });

        // Form submission handling
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match');
                return;
            }
            
            // Add loading state
            const registerBtn = document.getElementById('registerBtn');
            const originalText = registerBtn.innerHTML;
            
            registerBtn.disabled = true;
            registerBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Creating Account...';
            
            // Re-enable after 15 seconds as fallback
            setTimeout(() => {
                registerBtn.disabled = false;
                registerBtn.innerHTML = originalText;
            }, 15000);
        });

        // Auto-focus on first input
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('firstName').focus();
            
            // Set max date to 18 years ago
            const today = new Date();
            const maxDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
            document.getElementById('dobString').max = maxDate.toISOString().split('T')[0];
        });

        // Real-time validation feedback
        const requiredFields = ['firstName', 'lastName', 'nationalId', 'gender', 'dobString', 'email', 'userName', 'password', 'confirmPassword'];
        
        requiredFields.forEach(fieldId => {
            const field = document.getElementById(fieldId);
            if (field) {
                field.addEventListener('blur', function() {
                    if (this.value.trim() === '') {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                        this.classList.add('is-valid');
                    }
                });
            }
        });

        // Email validation
        document.getElementById('email').addEventListener('blur', function() {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(this.value)) {
                this.setCustomValidity('Please enter a valid email address');
                this.classList.add('is-invalid');
            } else {
                this.setCustomValidity('');
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            }
        });
    </script>
</body>
</html>