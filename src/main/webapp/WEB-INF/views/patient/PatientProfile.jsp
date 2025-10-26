<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Profile - Medisphere</title>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/homeWeb/title.png" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary: #255ea8;
      --primary-light: #e0f7f3;
      --secondary: #4030c1;
      --danger: #dc3545;
      --light-bg: #f9fbfa;
      --card-shadow: 0 4px 20px rgba(37, 168, 146, 0.12);
    }
    body {
      font-family: 'Poppins', sans-serif;
      background-color: var(--light-bg);
      color: #333;
    }
    .navbar-dark {
      box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }
    .sidebar {
      background: linear-gradient(180deg, #2c3e50, #1a252f);
      color: white;
      min-height: calc(100vh - 60px);
      padding-top: 25px;
      border-radius: 0 16px 16px 0;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }
    .brand-logo {
      text-align: center;
      padding: 20px 15px;
      margin-bottom: 30px;
      border-bottom: 1px solid rgba(255,255,255,0.1);
    }
    .brand-logo h5 {
      font-weight: 700;
      font-size: 1.4rem;
      letter-spacing: 0.5px;
    }
    .brand-logo small {
      font-size: 0.85rem;
      opacity: 0.8;
    }
    .sidebar .nav-link {
      color: rgba(255,255,255,0.85);
      padding: 14px 20px;
      margin: 6px 15px;
      border-radius: 10px;
      transition: all 0.25s ease;
      font-weight: 500;
      display: flex;
      align-items: center;
    }
    .sidebar .nav-link:hover,
    .sidebar .nav-link.active {
      background: rgba(255,255,255,0.12);
      color: var(--primary);
      transform: translateX(4px);
    }
    .sidebar .nav-link.text-danger {
      background: transparent;
      margin-top: 40px;
      color: #ff6b6b;
    }
    .sidebar .nav-link.text-danger:hover {
      background: rgba(220, 53, 69, 0.15);
      color: white;
      transform: translateX(4px) scale(1.02);
    }
    .content {
      padding: 30px;
    }
    .header-card {
      background: linear-gradient(135deg, var(--primary), var(--secondary));
      color: white;
      border-radius: 20px;
      padding: 30px;
      margin-bottom: 30px;
      box-shadow: var(--card-shadow);
      position: relative;
      overflow: hidden;
    }
    .user-stats {
      display: flex;
      gap: 25px;
      flex-wrap: wrap;
    }
    .user-stat {
      display: flex;
      align-items: center;
      gap: 12px;
      background: rgba(255,255,255,0.15);
      padding: 14px 22px;
      border-radius: 14px;
      min-width: 220px;
      backdrop-filter: blur(4px);
    }
    .user-stat i {
      font-size: 1.4rem;
      background: rgba(255,255,255,0.25);
      width: 42px;
      height: 42px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .content-card {
      background: white;
      border-radius: 20px;
      box-shadow: var(--card-shadow);
      margin-bottom: 30px;
      overflow: hidden;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .content-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 25px rgba(37, 168, 146, 0.18);
    }
    .card-header {
      background: linear-gradient(to right, var(--primary), var(--secondary));
      color: white;
      padding: 22px 30px;
      font-weight: 600;
      font-size: 1.25rem;
    }
    .card-body {
      padding: 30px;
    }
    .form-label {
      font-weight: 600;
      margin-bottom: 8px;
      color: #444;
    }
    .form-control, .form-select {
      border: 1px solid #e0e6ed;
      padding: 12px 16px;
      border-radius: 12px;
      font-size: 1rem;
      transition: all 0.25s;
    }
    .form-control:focus, .form-select:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(37, 168, 146, 0.2);
    }
    .btn-primary {
      background: linear-gradient(to right, var(--primary), var(--secondary));
      border: none;
      padding: 12px 28px;
      font-weight: 600;
      border-radius: 12px;
      font-size: 1.05rem;
      transition: all 0.3s ease;
    }
    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 18px rgba(37, 168, 146, 0.4);
    }
    .btn-outline-danger {
      border: 2px solid var(--danger);
      color: var(--danger);
      padding: 12px 28px;
      font-weight: 600;
      border-radius: 12px;
      transition: all 0.3s ease;
    }
    .btn-outline-danger:hover {
      background: var(--danger);
      color: white;
      transform: translateY(-2px);
    }
    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.85);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 9999;
      display: none;
    }
    .spinner {
      width: 48px;
      height: 48px;
      border: 4px solid #f3f3f3;
      border-top: 4px solid var(--primary);
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }
    @keyframes spin {
      to { transform: rotate(360deg); }
    }
    @media (max-width: 991.98px) {
      .sidebar {
        border-radius: 0;
        min-height: auto;
        margin-bottom: 20px;
      }
      .user-stats {
        flex-direction: column;
      }
      .content {
        padding: 20px 15px;
      }
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
    .form-control-plaintext {
      background: #f8f9fa;
      border: 1px solid #e9ecef;
      border-radius: 12px;
      padding: 12px 16px;
      font-weight: 500;
      color: #495057;
    }
  </style>
</head>
<body>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
  <div class="spinner"></div>
</div>

<div class="container-fluid">
  <!-- Error Alert -->
  <c:if test="${not empty error}">
    <div class="alert alert-warning alert-dismissible fade show mx-3" role="alert">
        ${error}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
  </c:if>

  <div class="row">
    <!-- Sidebar - Fixed with proper icons -->
    <div class="col-md-3 sidebar">
      <div class="brand-logo">
        <h5>Medisphere</h5>
        <small>Your partner in trusted protection</small>
      </div>
      <ul class="nav flex-column">
        <li class="nav-item">
          <c:set var="currentURI" value="${pageContext.request.requestURI}" />
          <a class="nav-link ${fn:contains(currentURI, 'dashboard') ? 'active' : ''}"
             href="${pageContext.request.contextPath}/patient/dashboard">
            <i class="fas fa-home me-2"></i>Dashboard
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${fn:contains(currentURI, 'profile') ? 'active' : ''}"
             href="${pageContext.request.contextPath}/patient/profile">
            <i class="fas fa-user me-2"></i> My Profile
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/patient/appointments">
            <i class="fas fa-calendar me-2"></i>Appointments
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">
            <i class="fas fa-pills me-2"></i> Medications
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">
            <i class="fas fa-file-medical me-2"></i> Medical Reports
          </a>
        </li>
        <li class="nav-item mt-3">
          <a class="nav-link text-danger d-flex align-items-center" href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt me-2"></i>
            <span>Logout</span>
          </a>
        </li>
      </ul>
    </div>

    <!-- Main Content -->
    <div class="col-md-9 content">
      <!-- Welcome Header -->
      <div class="row">
        <div class="col-12">
          <div class="header-card">
            <h2>My Profile</h2>
            <p>Manage your personal information and account settings</p>
            <div class="user-stats">
              <div class="user-stat">
                <i class="bi bi-person-badge"></i>
                <div>
                  <div><strong>Patient ID:</strong>
                    <c:out value="${patient.id}" default="123" />
                  </div>
                </div>
              </div>
              <div class="user-stat">
                <i class="bi bi-telephone"></i>
                <div>
                  <div><strong>Phone:</strong>
                    <c:choose>
                      <c:when test="${not empty patient.patientPhones && fn:length(patient.patientPhones) > 0}">
                        <c:out value="${patient.patientPhones.toArray()[0].phoneNumber}" default="+1234567890" />
                      </c:when>
                      <c:otherwise>Not provided</c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Profile Form -->
      <div class="row">
        <div class="col-12">
          <div class="content-card">
            <div class="card-header">
              <i class="bi bi-person me-2"></i> Personal Details
            </div>
            <div class="card-body">
              <form id="profileForm">
                <input type="hidden" id="patientId" value="${patient.id}">
                <div class="row">
                  <div class="col-md-6 mb-4">
                    <label for="first_name" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="first_name"
                           value="<c:out value="${patient.firstName}" />"
                           oninput="validateName(this)" required>
                    <div class="invalid-feedback" id="firstNameError">
                      First name must contain only letters and spaces
                    </div>
                  </div>
                  <div class="col-md-6 mb-4">
                    <label for="last_name" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="last_name"
                           value="<c:out value="${patient.lastName}" />"
                           oninput="validateName(this)" required>
                    <div class="invalid-feedback" id="lastNameError">
                      Last name must contain only letters and spaces
                    </div>
                  </div>
                  <div class="col-md-6 mb-4">
                    <label class="form-label">Email</label>
                    <p class="form-control-plaintext"><c:out value="${patient.email}" /></p>
                    <input type="hidden" id="email" value="<c:out value="${patient.email}" />">
                  </div>
                  <div class="col-md-6 mb-4">
                    <label for="nationalID" class="form-label">National ID</label>
                    <input type="text" class="form-control" id="nationalID"
                           value="<c:out value="${patient.nationalId}" />" required>
                  </div>
                  <div class="col-md-6 mb-4">
                    <label for="dob" class="form-label">Date of Birth</label>
                    <input type="date" class="form-control" id="dob"
                           value="<c:out value="${patient.dob}" />" required>
                  </div>
                  <div class="col-md-6 mb-4">
                    <label for="gender" class="form-label">Gender</label>
                    <select class="form-select" id="gender" required>
                      <option value="">-- Select --</option>
                      <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                      <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                      <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                  </div>
                  <div class="col-md-12 mb-4">
                    <label for="address" class="form-label optional">Address (Optional)</label>
                    <input type="text" class="form-control" id="address"
                           value="<c:out value="${patient.address != null ? patient.address : ''}" />">
                  </div>
                  <div class="col-md-6 mb-4">
                    <label for="phone1" class="form-label">Phone Number 1</label>
                    <input type="text" class="form-control" id="phone1"
                           value="<c:out value="${not empty patient.patientPhones ? patient.patientPhones.toArray()[0].phoneNumber : ''}" />"
                           maxlength="10" oninput="validatePhoneNumber(this)" required>
                    <div class="invalid-feedback" id="phone1Error">
                      Phone number must be exactly 10 digits
                    </div>
                  </div>
                  <div class="col-md-6 mb-4">
                    <label for="phone2" class="form-label optional">Phone Number 2 (Optional)</label>
                    <input type="text" class="form-control" id="phone2"
                           value="<c:out value="${not empty patient.patientPhones && fn:length(patient.patientPhones) > 1 ? patient.patientPhones.toArray()[1].phoneNumber : ''}" />"
                           maxlength="10" oninput="validatePhoneNumber(this)">
                    <div class="invalid-feedback" id="phone2Error">
                      Phone number must be exactly 10 digits
                    </div>
                  </div>
                </div>
                <div class="mb-4">
                  <label for="password" class="form-label">New Password (Leave blank to keep current)</label>
                  <input type="password" class="form-control" id="password" placeholder="••••••••">
                </div>
                <div class="d-flex gap-3 pt-3 border-top">
                  <button type="button" class="btn btn-primary" onclick="updateProfile()">
                    <i class="bi bi-save me-2"></i> Update Profile
                  </button>
                  <button type="button" class="btn btn-outline-danger" onclick="deleteProfile()">
                    <i class="bi bi-trash me-2"></i> Delete Profile
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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

  function validateAllNames() {
    const firstName = document.getElementById('first_name');
    const lastName = document.getElementById('last_name');

    const firstNameValid = validateName(firstName);
    const lastNameValid = validateName(lastName);

    return firstNameValid && lastNameValid;
  }

  function validateAllPhoneNumbers() {
    const phone1 = document.getElementById('phone1');
    const phone2 = document.getElementById('phone2');

    const phone1Valid = !phone1.value || validatePhoneNumber(phone1);
    const phone2Valid = !phone2.value || validatePhoneNumber(phone2);

    return phone1Valid && phone2Valid;
  }

  async function updateProfile() {
    // Validate names before proceeding
    if (!validateAllNames()) {
      alert('Please fix name errors before updating profile. Names must contain only letters and spaces.');
      return;
    }

    // Validate phone numbers before proceeding
    if (!validateAllPhoneNumbers()) {
      alert('Please fix phone number errors before updating profile.');
      return;
    }

    const patient = {
      id: parseInt(document.getElementById('patientId').value),
      firstName: document.getElementById('first_name').value,
      lastName: document.getElementById('last_name').value,
      dob: document.getElementById('dob').value,
      nationalId: document.getElementById('nationalID').value,
      email: document.getElementById('email').value,
      password: document.getElementById('password').value || undefined,
      gender: document.getElementById('gender').value,
      address: document.getElementById('address').value || null,
      patientPhones: []
    };

    const phone1 = document.getElementById('phone1').value.trim();
    const phone2 = document.getElementById('phone2').value.trim();

    if (phone1) patient.patientPhones.push({ phoneNumber: phone1 });
    if (phone2) patient.patientPhones.push({ phoneNumber: phone2 });

    try {
      showLoading();
      const response = await fetch('${pageContext.request.contextPath}/api/v1/patient', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(patient)
      });

      if (response.ok) {
        hideLoading();
        alert(' Profile updated successfully!');
        location.reload();
      } else {
        const errorText = await response.text();
        hideLoading();
        alert('Failed to update profile: ' + (errorText || response.statusText));
      }
    } catch (err) {
      hideLoading();
      console.error('Network error:', err);
      alert(' Network error. Please check your connection and try again.');
    }
  }

  async function deleteProfile() {
    if (!confirm(' Are you sure you want to DELETE your profile? This action cannot be undone!')) return;
    const id = document.getElementById('patientId').value;
    try {
      showLoading();
      const response = await fetch('${pageContext.request.contextPath}/api/v1/patient/' + id, {
        method: 'DELETE'
      });

      if (response.ok) {
        hideLoading();
        alert(' Profile deleted successfully. Logging out...');
        window.location.href = '${pageContext.request.contextPath}/logout';
      } else {
        const errorText = await response.text();
        hideLoading();
        alert(' Failed to delete profile: ' + (errorText || response.statusText));
      }
    } catch (err) {
      hideLoading();
      console.error('Network error:', err);
      alert('Network error. Please check your connection and try again.');
    }
  }

  function showLoading() {
    document.getElementById('loadingOverlay').style.display = 'flex';
  }

  function hideLoading() {
    document.getElementById('loadingOverlay').style.display = 'none';
  }

  // Initialize validation on page load
  document.addEventListener('DOMContentLoaded', function() {
    validateName(document.getElementById('first_name'));
    validateName(document.getElementById('last_name'));
    validatePhoneNumber(document.getElementById('phone1'));
    validatePhoneNumber(document.getElementById('phone2'));
  });
</script>
</body>
</html>