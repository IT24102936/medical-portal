<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Medisphere</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    /* ... [Your exact CSS styles here - unchanged] ... */
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f8f9fa;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    .navbar-dark {
      flex-shrink: 0;
    }

    .main-content {
      flex: 1;
      display: flex;
    }

    .branding-section {
      background-image:
              url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.08'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E"),
              linear-gradient(135deg, #0a193a 0%, #033c5a 100%);
      background-repeat: repeat, no-repeat;
      background-size: 60px 60px, cover;
      background-position: 0 0, center;
      color: #ffffff;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      padding: 40px 20px;
      position: relative;
      overflow: hidden;
      flex: 1;
    }

    .branding-content {
      position: relative;
      z-index: 2;
      animation: fadeIn 1.5s ease-in-out;
    }

    .branding-content h1 {
      font-weight: 700;
      letter-spacing: 1px;
      font-size: 3.5rem;
    }

    .branding-content p {
      font-size: 1.5rem;
      font-weight: 300;
    }

    .form-section {
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 40px 20px;
      background-color: #ffffff;
      flex: 1;
    }

    .login-wrapper {
      max-width: 400px;
      width: 100%;
      animation: slideInUp 1s ease-in-out;
    }

    .form-section h2 {
      font-weight: 600;
      text-align: center;
      color: #212529;
      margin-bottom: 10px;
    }

    .form-section .text-muted {
      text-align: center;
      font-size: 0.95rem;
      margin-bottom: 30px;
    }

    .form-control {
      border-radius: 8px;
      padding: 12px 15px;
      border: 1px solid #ced4da;
      transition: all 0.3s ease;
      font-size: 1rem;
    }

    .form-control:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.2);
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

    .btn-login {
      background-color: #0B6AF5;
      border: none;
      padding: 12px;
      font-weight: 500;
      border-radius: 8px;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
      color: white;
      font-size: 1.1rem;
      width: 100%;
    }

    .btn-login:hover {
      background-color: #267AEB;
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes slideInUp {
      from { opacity: 0; transform: translateY(50px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 991.98px) {
      .main-content {
        flex-direction: column;
      }
      .branding-content h1 {
        font-size: 2.5rem;
      }
    }

    footer {
      margin-top: 0;
      flex-shrink: 0;
    }
  </style>
</head>
<body>

<!-- MAIN CONTENT -->
<div class="main-content">
  <!-- Left Branding Section -->
  <div class="branding-section">
    <div class="branding-content">
      <h1 class="display-3">Medisphere</h1>
      <p class="lead">Your partner in trusted protection</p>
    </div>
  </div>

  <!-- Right Form Section -->
  <div class="form-section">
    <div class="login-wrapper">
      <div style="text-align: center;">
        <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo"
             class="logo mb-4" style="width: 100px; height: 100px;">
      </div>

      <h2 class="mb-3">Welcome Back Patient</h2>
      <p class="text-muted mb-4">Please enter your credentials to access your account.</p>

      <form action="${pageContext.request.contextPath}/login" method="post">
        <!-- Error Message -->
        <c:if test="${not empty error}">
          <div class="alert alert-danger alert-dismissible fade show" role="alert">
              ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
        </c:if>

        <!-- Email Field -->
        <div class="mb-3">
          <label for="username" class="form-label">Email Address</label>
          <input type="email"
                 class="form-control"
                 id="username"
                 name="username"
                 placeholder="Enter your email address"
                 required>
        </div>

        <!-- Password Field -->
        <div class="mb-3">
          <label for="password" class="form-label">Password</label>
          <div class="password-wrapper">
            <input type="password"
                   class="form-control"
                   id="password"
                   name="password"
                   placeholder="Enter your password"
                   required>
            <i class="bi bi-eye-slash-fill" id="togglePassword"></i>
          </div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4">
          <div class="form-check">
            <input class="form-check-input me-2" type="checkbox" id="rememberMe" name="rememberMe">
            <label class="form-check-label" for="rememberMe">Remember me</label>
   


        <!-- Submit Button -->
        <div class="d-grid">
          <button type="submit" class="btn btn-login">
            <i class="bi bi-box-arrow-in-right me-2"></i> Login to Your Account
          </button>
        </div>

        <div class="text-center mt-4">
          <small>Don't have an account?
            <a href="${pageContext.request.contextPath}/register" class="text-primary" style="text-decoration: none;">Register here</a>
          </small>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- END MAIN CONTENT -->

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Password Toggle Script -->
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');

    if (togglePassword && password) {
      togglePassword.addEventListener('click', function () {
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        this.classList.toggle('bi-eye-fill');
        this.classList.toggle('bi-eye-slash-fill');
      });
    }
  });
</script>

</body>
</html>