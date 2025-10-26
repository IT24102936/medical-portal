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
      font-size: 2.8rem;
    }
    .branding-content p {
      font-size: 1.3rem;
      font-weight: 300;
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
    .form-section h2 {
      font-weight: 600;
      text-align: center;
      color: #212529;
      margin-bottom: 30px;
    }
    .form-control, .form-select {
      border-radius: 8px;
      padding: 12px 15px;
      border: 1px solid #ced4da;
      transition: all 0.3s ease;
      font-size: 1rem;
    }
    .form-control:focus, .form-select:focus {
      border-color: #1E9E29;
      box-shadow: 0 0 0 0.25rem rgba(30, 158, 41, 0.25);
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
      background: linear-gradient(135deg, #0B6AF5 0%, #6330CF 100%);
      border: none;
      padding: 12px;
      font-weight: 500;
      border-radius: 8px;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(30, 158, 41, 0.2);
      color: white;
      font-size: 1.1rem;
      width: 100%;
    }
    .btn-register:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(30, 158, 41, 0.3);
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
      body {
        overflow: auto;
      }
      .branding-section {
        display: none;
      }
      .form-section {
        padding: 40px 25px;
      }
      .form-wrapper {
        max-width: 100%;
      }
    }
    .form-label::after {
      content: " *";
      color: #dc3545;
    }
    .form-label.optional::after {
      content: "";
    }
    .is-invalid {
      border-color: #dc3545;
      box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
    }
    .invalid-feedback {
      display: none;
      width: 100%;
      margin-top: 0.25rem;
      font-size: 0.875em;
      color: #dc3545;
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <div class="col-lg-5 branding-section">
      <div class="branding-content">
        <h1 class="display-4">Join Medisphere</h1>
        <p class="lead">Join with us and secure your future</p>
      </div>
    </div>
    <div class="col-lg-7 form-section">
      <div class="form-wrapper">
        <br><br><br><br><br><br><br><br>
        <div style="text-align: center;">
          <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo"
               class="logo mb-4" style="width: 90px; height: 90px;">
        </div>
        <h2 class="mb-4">Create Your Patient Account</h2>
        <form action="${pageContext.request.contextPath}/register-patient" method="post" id="registrationForm">
          <!-- Success Message -->
          <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
              <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
          </c:if>

          <!-- Error Message -->
          <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
              <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
          </c:if>

          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="first_name" class="form-label">First Name</label>
              <input type="text" class="form-control" id="first_name" name="first_name"
                     oninput="validateName(this)" required>
              <div class="invalid-feedback" id="firstNameError">
                First name must contain only letters and spaces
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="last_name" class="form-label">Last Name</label>
              <input type="text" class="form-control" id="last_name" name="last_name"
                     oninput="validateName(this)" required>
              <div class="invalid-feedback" id="lastNameError">
                Last name must contain only letters and spaces
              </div>
            </div>
            <div class="col-md-12 mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="col-md-6 mb-3">
              <label for="password" class="form-label">Password</label>
              <div class="password-wrapper">
                <input type="password" class="form-control" id="password" name="password" required>
                <i class="bi bi-eye-slash-fill" id="togglePassword1"></i>
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="confirmPassword" class="form-label">Confirm Password</label>
              <div class="password-wrapper">
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                <i class="bi bi-eye-slash-fill" id="togglePassword2"></i>
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="dob" class="form-label">Date of Birth</label>
              <input type="date" class="form-control" id="dob" name="dob" required>
            </div>
            <div class="col-md-6 mb-3">
              <label for="nationalID" class="form-label">National ID</label>
              <input type="text" class="form-control" id="nationalID" name="nationalID" required>
            </div>
            <div class="col-md-6 mb-3">
              <label for="gender" class="form-label">Gender</label>
              <select class="form-select" id="gender" name="gender" required>
                <option value="">-- Select --</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
              </select>
            </div>
            <!-- Age field REMOVED as requested -->
            <div class="col-md-6 mb-3">
              <label for="address" class="form-label optional">Address (Optional)</label>
              <input type="text" class="form-control" id="address" name="address">
            </div>
            <div class="col-md-6 mb-3">
              <label for="phone1" class="form-label">Phone Number 1</label>
              <input type="text" class="form-control" id="phone1" name="phone1"
                     maxlength="10" oninput="validatePhoneNumber(this)" required>
              <div class="invalid-feedback" id="phone1Error">
                Phone number must be exactly 10 digits
              </div>
            </div>
            <div class="col-md-6 mb-3">
              <label for="phone2" class="form-label optional">Phone Number 2</label>
              <input type="text" class="form-control" id="phone2" name="phone2"
                     maxlength="10" oninput="validatePhoneNumber(this)">
              <div class="invalid-feedback" id="phone2Error">
                Phone number must be exactly 10 digits
              </div>
            </div>
          </div>
          <div class="d-grid mt-4">
            <button type="submit" class="btn btn-register" onclick="return validateForm()">Register Now</button>
          </div>
        </form>
        <p class="mt-4 text-center text-muted">
          Already have an account?
          <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Login</a>
        </p>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function validateName(input) {
    const value = input.value;
    // Regular expression to allow only letters and spaces
    const namePattern = /^[a-zA-Z\s]*$/;
    const isValid = namePattern.test(value);

    if (value && !isValid) {
      input.classList.add('is-invalid');
      input.nextElementSibling.style.display = 'block';
    } else {
      input.classList.remove('is-invalid');
      input.nextElementSibling.style.display = 'none';
    }

    return isValid;
  }

  function validatePhoneNumber(input) {
    const value = input.value.replace(/\D/g, ''); // Remove non-digits
    const isValid = value.length === 10;

    if (input.value && !isValid) {
      input.classList.add('is-invalid');
      input.nextElementSibling.style.display = 'block';
    } else {
      input.classList.remove('is-invalid');
      input.nextElementSibling.style.display = 'none';
    }

    // Update the value with only digits and limit to 10 characters
    input.value = value.slice(0, 10);

    return isValid;
  }

  function validateForm() {
    const firstName = document.getElementById('first_name');
    const lastName = document.getElementById('last_name');
    const phone1 = document.getElementById('phone1');
    const phone2 = document.getElementById('phone2');
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');

    // Validate names
    const firstNameValid = validateName(firstName);
    const lastNameValid = validateName(lastName);

    // Validate phone numbers
    const phone1Valid = validatePhoneNumber(phone1);
    const phone2Valid = !phone2.value || validatePhoneNumber(phone2);

    // Validate password match
    const passwordMatch = password.value === confirmPassword.value;

    if (!passwordMatch) {
      alert("Passwords do not match!");
      return false;
    }

    if (!firstNameValid || !lastNameValid) {
      alert("Please fix name errors before submitting. Names must contain only letters and spaces.");
      return false;
    }

    if (!phone1Valid || !phone2Valid) {
      alert("Please fix phone number errors before submitting.");
      return false;
    }

    return true;
  }

  document.addEventListener('DOMContentLoaded', function () {
    // Password toggle for password field
    const togglePassword1 = document.querySelector('#togglePassword1');
    const password1 = document.querySelector('#password');
    if (togglePassword1 && password1) {
      togglePassword1.addEventListener('click', function () {
        const type = password1.getAttribute('type') === 'password' ? 'text' : 'password';
        password1.setAttribute('type', type);
        this.classList.toggle('bi-eye-fill');
        this.classList.toggle('bi-eye-slash-fill');
      });
    }

    // Password toggle for confirm password field
    const togglePassword2 = document.querySelector('#togglePassword2');
    const password2 = document.querySelector('#confirmPassword');
    if (togglePassword2 && password2) {
      togglePassword2.addEventListener('click', function () {
        const type = password2.getAttribute('type') === 'password' ? 'text' : 'password';
        password2.setAttribute('type', type);
        this.classList.toggle('bi-eye-fill');
        this.classList.toggle('bi-eye-slash-fill');
      });
    }

    // Initialize validation
    validateName(document.getElementById('first_name'));
    validateName(document.getElementById('last_name'));
    validatePhoneNumber(document.getElementById('phone1'));
    validatePhoneNumber(document.getElementById('phone2'));
  });
</script>
</body>
</html>