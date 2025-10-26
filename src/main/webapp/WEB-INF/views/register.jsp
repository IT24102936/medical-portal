<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            height: 100vh;
            overflow: hidden;
        }
        .container-fluid, .row {
            height: 100%;
        }
        
        /* Branding Section */
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
            font-size: 4rem;
            letter-spacing: 1px;
            margin-bottom: 1rem;
        }
        .branding-content p {
            font-size: 1.2rem;
            font-weight: 300;
        }
        
        /* Form Section */
        .form-section {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            background-color: #ffffff;
            height: 100vh;
            overflow-y: auto;
        }
        .register-wrapper {
            max-width: 600px;
            width: 100%;
            animation: slideInUp 1s ease-in-out;
            margin-top: 40px;
        }
        .logo {
            display: block;
            margin: 30px auto 20px;
            width: 120px;
            height: 120px;
            object-fit: contain;
            max-width: 100%;
            margin-top: 30px;
        }
        .form-section h2 {
            font-weight: 600;
            text-align: center;
            color: #212529;
            margin-bottom: 30px;
            font-size: 1.75rem;
        }
        .form-control, .form-select {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ced4da;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.1);
        }
        .form-label {
            font-weight: 500;
            color: #212529;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }
        .btn-create {
            background: #0d6efd;
            border: none;
            padding: 14px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-size: 1rem;
            width: 100%;
            box-shadow: 0 4px 15px rgba(13, 110, 253, 0.2);
        }
        .btn-create:hover {
            background: #0b5ed7;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(13, 110, 253, 0.3);
        }
        .signin-link, .home-link {
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .signin-link:hover, .home-link:hover {
            color: #0a58ca;
            text-decoration: underline;
        }
        .bottom-links {
            text-align: center;
            margin-top: 20px;
        }
        .bottom-links p {
            margin-bottom: 8px;
            color: #6c757d;
            font-size: 0.95rem;
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
        
        /* Password toggle */
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
        
        /* Responsive */
        @media (max-width: 991.98px) {
            body {
                overflow: auto;
            }
            .branding-section {
                height: auto;
                min-height: 200px;
            }
            .branding-content h1 {
                font-size: 2.8rem;
            }
            .form-section {
                height: auto;
                padding: 40px 25px;
            }
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
            <!-- Left Branding Section -->
            <div class="col-lg-6 col-md-12 branding-section">
                <div class="branding-content">
                    <h1>Join Medisphere</h1>
                    <p>Pioneering the Future of Digital Healthcare</p>
                </div>
            </div>
            
            <!-- Right Form Section -->
            <div class="col-lg-6 col-md-12 form-section">
                <div class="register-wrapper">
                    <!-- Medisphere Logo -->
                    <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" class="logo mb-4">
                    
                    <h2>Create Your Employee Account</h2>
                    
                    <!-- Error/Success Messages -->
                    <c:if test="${error != null}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${success != null}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <!-- Registration Form -->
                    <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
                        <div class="row">
                            <!-- First Name -->
                            <div class="col-md-6 mb-3">
                                <label for="firstName" class="form-label">First Name</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" required>
                            </div>
                            
                            <!-- Last Name -->
                            <div class="col-md-6 mb-3">
                                <label for="lastName" class="form-label">Last Name</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <!-- Username -->
                            <div class="col-md-6 mb-3">
                                <label for="userName" class="form-label">Username</label>
                                <input type="text" class="form-control" id="userName" name="userName" required>
                            </div>
                            
                            <!-- Email -->
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <!-- Phone Number -->
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone" required>
                            </div>
                            
                            <!-- National ID -->
                            <div class="col-md-6 mb-3">
                                <label for="nationalId" class="form-label">National ID</label>
                                <input type="text" class="form-control" id="nationalId" name="nationalId" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <!-- Date of Birth -->
                            <div class="col-md-6 mb-3">
                                <label for="dob" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="dob" name="dob" required>
                            </div>
                            
                            <!-- Gender -->
                            <div class="col-md-6 mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="" selected disabled>Select...</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                        </div>
                        
                        <!-- Employee Type -->
                        <div class="mb-3">
                            <label for="employeeType" class="form-label">Employee Type</label>
                            <select class="form-select" id="employeeType" name="employeeType" required>
                                <option value="" selected disabled>Select your role...</option>
                                <option value="Doctor">Doctor</option>
                                <option value="Receptionist">Receptionist</option>
                                <option value="Lab Technician">Lab Technician</option>
                                <option value="Pharmacist">Pharmacist</option>
                                <option value="Finance Admin">Finance Admin</option>
                            </select>
                        </div>
                        
                        <!-- Specialization (for doctors) -->
                        <div class="mb-3" id="specializationField" style="display: none;">
                            <label for="specialization" class="form-label">Specialization</label>
                            <input type="text" class="form-control" id="specialization" name="specialization" placeholder="e.g., Cardiology, Pediatrics">
                        </div>
                        
                        <!-- Salary -->
                        <div class="mb-3">
                            <label for="salary" class="form-label">Salary</label>
                            <input type="number" class="form-control" id="salary" name="salary" step="0.01" min="0" required>>
                        </div>
                        
                        <div class="row">
                            <!-- Password -->
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label">Password</label>
                                <div class="password-wrapper">
                                    <input type="password" class="form-control" id="password" name="password" required>
                                    <i class="bi bi-eye-slash-fill" id="togglePassword"></i>
                                </div>
                            </div>
                            
                            <!-- Confirm Password -->
                            <div class="col-md-6 mb-3">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <div class="password-wrapper">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    <i class="bi bi-eye-slash-fill" id="toggleConfirmPassword"></i>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Submit Button -->
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-primary btn-create">Create Account</button>
                        </div>
                    </form>
                    
                    <!-- Bottom Links -->
                    <div class="bottom-links">
                        <p>Already have an account? <a href="${pageContext.request.contextPath}/login" class="signin-link">Sign In</a></p>
                        <p><a href="${pageContext.request.contextPath}/" class="home-link"><i class="bi bi-arrow-left"></i> Back to Home</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Password visibility toggle
            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#password');
            const toggleConfirmPassword = document.querySelector('#toggleConfirmPassword');
            const confirmPassword = document.querySelector('#confirmPassword');
            
            if (togglePassword) {
                togglePassword.addEventListener('click', function () {
                    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                    password.setAttribute('type', type);
                    this.classList.toggle('bi-eye');
                    this.classList.toggle('bi-eye-slash-fill');
                });
            }
            
            if (toggleConfirmPassword) {
                toggleConfirmPassword.addEventListener('click', function () {
                    const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                    confirmPassword.setAttribute('type', type);
                    this.classList.toggle('bi-eye');
                    this.classList.toggle('bi-eye-slash-fill');
                });
            }
            
            // Show specialization field for doctors
            const employeeType = document.querySelector('#employeeType');
            const specializationField = document.querySelector('#specializationField');
            const specializationInput = document.querySelector('#specialization');
            
            employeeType.addEventListener('change', function () {
                if (this.value === 'Doctor') {
                    specializationField.style.display = 'block';
                    specializationInput.required = true;
                } else {
                    specializationField.style.display = 'none';
                    specializationInput.required = false;
                    specializationInput.value = '';
                }
            });
            
            // Form validation
            const form = document.querySelector('#registerForm');
            form.addEventListener('submit', function (e) {
                const pwd = password.value;
                const confirmPwd = confirmPassword.value;
                
                if (pwd !== confirmPwd) {
                    e.preventDefault();
                    alert('Passwords do not match!');
                    confirmPassword.focus();
                    return false;
                }
                
                if (pwd.length < 6) {
                    e.preventDefault();
                    alert('Password must be at least 6 characters long!');
                    password.focus();
                    return false;
                }
                
                // Salary non-negative validation
                const salaryEl = document.getElementById('salary');
                const salaryVal = parseFloat(salaryEl.value);
                if (isNaN(salaryVal) || salaryVal < 0) {
                    e.preventDefault();
                    alert('Salary must be a non-negative number.');
                    salaryEl.focus();
                    return false;
                }
            });
        });
    </script>
</body>
</html>
