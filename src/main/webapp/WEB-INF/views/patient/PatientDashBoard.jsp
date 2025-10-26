<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Patient Dashboard - Medisphere</title>
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
    .status-badge {
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 0.85rem;
      font-weight: 500;
    }
    .status-scheduled {
      background-color: #fff3cd;
      color: #856404;
    }
    .status-confirmed {
      background-color: #d1edff;
      color: #0c5460;
    }
    .status-completed {
      background-color: #d4edda;
      color: #155724;
    }
    .status-cancelled {
      background-color: #f8d7da;
      color: #721c24;
    }
    .appointment-card {
      border-left: 4px solid var(--primary);
      margin-bottom: 15px;
    }
    .quick-action-card {
      text-align: center;
      padding: 20px;
      border-radius: 12px;
      transition: all 0.3s ease;
      cursor: pointer;
      height: 100%;
    }
    .quick-action-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    }
    .quick-action-icon {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 15px;
      font-size: 1.5rem;
    }
    .bg-primary-light {
      background-color: #e3f2fd;
    }
    .bg-success-light {
      background-color: #e8f5e8;
    }
    .bg-warning-light {
      background-color: #fff3e0;
    }
    .bg-info-light {
      background-color: #e0f2f1;
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

  <!-- Success Alert -->
  <c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show mx-3" role="alert">
        ${success}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
  </c:if>

  <div class="row">
    <!-- Sidebar -->
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
            <i class="bi bi-person me-2"></i> My Profile
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
            <i class="bi bi-file-earmark-medical me-2"></i> Medical Reports
          </a>
        </li>
        <li class="nav-item mt-3">
          <a class="nav-link text-danger d-flex align-items-center" href="${pageContext.request.contextPath}/logout">
            <i class="bi bi-box-arrow-right me-2"></i>
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
            <h2>Welcome Back,
              <c:out value="${patient.firstName} ${patient.lastName}" default="John Doe" />!
            </h2>
            <p>Manage your medical profile and healthcare information</p>
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
              <div class="user-stat">
                <i class="bi bi-envelope"></i>
                <div>
                  <div><strong>Email:</strong>
                    <c:out value="${patient.email}" default="patient@example.com" />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Quick Actions - Fixed Layout -->
      <div class="row mt-4">
        <div class="col-12">
          <h4>Quick Actions</h4>
          <div class="row">
            <div class="col-md-3 mb-4">
              <div class="quick-action-card bg-primary-light" onclick="location.href='${pageContext.request.contextPath}/patient/appointment'">
                <div class="quick-action-icon bg-primary text-white">

                </div>
                <h5>Book Appointment</h5>
                <p class="text-muted">Schedule a new doctor visit</p>
              </div>
            </div>

            <div class="col-md-3 mb-4">
              <div class="quick-action-card bg-success-light" onclick="location.href='${pageContext.request.contextPath}/patient/profile'">
                <div class="quick-action-icon bg-success text-white">
                  <i class="bi bi-person-gear"></i>
                </div>
                <h5>Update Profile</h5>
                <p class="text-muted">Manage your personal information</p>
              </div>
            </div>

            <div class="col-md-3 mb-4">
              <div class="quick-action-card bg-warning-light">
                <div class="quick-action-icon bg-warning text-white">
                  <i class="fas fa-prescription"></i>
                </div>
                <h5>Medications</h5>
                <p class="text-muted">View your prescriptions</p>
              </div>
            </div>

            <div class="col-md-3 mb-4">
              <div class="quick-action-card bg-info-light">
                <div class="quick-action-icon bg-info text-white">
                  <i class="bi bi-file-medical"></i>
                </div>
                <h5>Medical Reports</h5>
                <p class="text-muted">Access test results</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Upcoming Appointments -->
      <div class="row mt-4">
        <div class="col-12">
          <div class="content-card">
            <div class="card-header">
              <i class="fas fa-calendar me-2"></i> Upcoming Appointments
            </div>
            <div class="card-body">
              <c:choose>
                <c:when test="${empty upcomingAppointments}">
                  <div class="text-center py-4">
                    <i class="bi bi-calendar-x text-muted" style="font-size: 3rem;"></i>
                    <h5 class="mt-3 text-muted">No Upcoming Appointments</h5>
                    <p class="text-muted">You don't have any scheduled appointments.</p>
                    <a href="${pageContext.request.contextPath}/patient/appointment" class="btn btn-primary mt-2">
                      <i class="fas fa-calendar-plus me-2"></i>Book Your First Appointment
                    </a>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="table-responsive">
                    <table class="table table-hover">
                      <thead>
                      <tr>
                        <th>DATE</th>
                        <th>TIME</th>
                        <th>DOCTOR</th>
                        <th>TYPE</th>
                        <th>STATUS</th>
                        <th>ACTIONS</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="appointment" items="${upcomingAppointments}">
                        <tr>
                          <td>
                            <c:choose>
                              <c:when test="${not empty appointment.appointmentDatetime}">
                                ${appointment.appointmentDatetime.toLocalDate()}
                              </c:when>
                              <c:otherwise>
                                Date not available
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${not empty appointment.appointmentDatetime}">
                                <c:set var="timeFormatter" value="<%= java.time.format.DateTimeFormatter.ofPattern(\"h:mm a\") %>" />
                                ${appointment.appointmentDatetime.toLocalTime().format(timeFormatter)}
                              </c:when>
                              <c:otherwise>
                                Time not available
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${not empty appointment.doctor and not empty appointment.doctor.employee}">
                                Dr. ${appointment.doctor.employee.firstName} ${appointment.doctor.employee.lastName}
                              </c:when>
                              <c:otherwise>
                                Doctor information unavailable
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${not empty appointment.doctor and not empty appointment.doctor.specialization}">
                                ${appointment.doctor.specialization}
                              </c:when>
                              <c:otherwise>
                                General Consultation
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${appointment.status == 'Scheduled'}">
                                <span class="status-badge status-scheduled">Scheduled</span>
                              </c:when>
                              <c:when test="${appointment.status == 'Confirmed'}">
                                <span class="status-badge status-confirmed">Confirmed</span>
                              </c:when>
                              <c:when test="${appointment.status == 'Completed'}">
                                <span class="status-badge status-completed">Completed</span>
                              </c:when>
                              <c:when test="${appointment.status == 'Cancelled'}">
                                <span class="status-badge status-cancelled">Cancelled</span>
                              </c:when>
                              <c:otherwise>
                                <span class="status-badge">${appointment.status}</span>
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${appointment.status != 'Cancelled' and appointment.status != 'Completed'}">
                                <button class="btn btn-outline-danger btn-sm" onclick="cancelAppointment(${appointment.id})">
                                  <i class="bi bi-x-circle"></i> Cancel
                                </button>
                              </c:when>
                              <c:otherwise>
                                <span class="text-muted">No actions available</span>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>

      <!-- Health Statistics & Recent Activity -->
      <div class="row mt-4">
        <!-- Health Statistics -->
        <div class="col-md-7">
          <div class="content-card">
            <div class="card-header">
              <i class="bi bi-heart-pulse me-2"></i> Health Statistics
            </div>
            <div class="card-body">
              <!-- Blood Pressure -->
              <div class="health-stat d-flex justify-content-between align-items-center mb-3">
                <div><span class="text-muted">Blood Pressure</span></div>
                <span class="fw-bold">120/80 mmHg</span>
              </div>
              <div class="progress" style="height: 8px;">
                <div class="progress-bar bg-success" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
              </div>

              <!-- Heart Rate -->
              <div class="health-stat d-flex justify-content-between align-items-center my-3">
                <div><span class="text-muted">Heart Rate</span></div>
                <span class="fw-bold">72 bpm</span>
              </div>
              <div class="progress" style="height: 8px;">
                <div class="progress-bar bg-info" role="progressbar" style="width: 65%;" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
              </div>

              <!-- Blood Sugar -->
              <div class="health-stat d-flex justify-content-between align-items-center my-3">
                <div><span class="text-muted">Blood Sugar</span></div>
                <span class="fw-bold">98 mg/dL</span>
              </div>
              <div class="progress" style="height: 8px;">
                <div class="progress-bar bg-primary" role="progressbar" style="width: 60%;" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
              </div>

              <!-- Cholesterol -->
              <div class="health-stat d-flex justify-content-between align-items-center my-3">
                <div><span class="text-muted">Cholesterol</span></div>
                <span class="fw-bold">180 mg/dL</span>
              </div>
              <div class="progress" style="height: 8px;">
                <div class="progress-bar bg-warning" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
              </div>

              <!-- Weight -->
              <div class="health-stat d-flex justify-content-between align-items-center my-3">
                <div><span class="text-muted">Weight</span></div>
                <span class="fw-bold">70 kg</span>
              </div>
              <div class="progress" style="height: 8px;">
                <div class="progress-bar bg-secondary" role="progressbar" style="width: 70%;" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
            </div>
          </div>
        </div>

        <!-- Recent Activity -->
        <div class="col-md-5">
          <div class="content-card">
            <div class="card-header">
              <i class="bi bi-clock-history me-2"></i> Recent Activity
            </div>
            <div class="card-body">
              <div class="activity-timeline">
                <div class="activity-item d-flex mb-3">
                  <div class="activity-icon me-3">
                    <i class="bi bi-calendar-check text-success"></i>
                  </div>
                  <div class="activity-content">
                    <h6 class="mb-1">Appointment Scheduled</h6>
                    <p class="text-muted mb-0">Cardiology consultation with Dr. Smith</p>
                    <small class="text-muted">2 hours ago</small>
                  </div>
                </div>

                <div class="activity-item d-flex mb-3">
                  <div class="activity-icon me-3">
                    <i class="bi bi-prescription text-primary"></i>
                  </div>
                  <div class="activity-content">
                    <h6 class="mb-1">Prescription Updated</h6>
                    <p class="text-muted mb-0">New medication added to your list</p>
                    <small class="text-muted">1 day ago</small>
                  </div>
                </div>

                <div class="activity-item d-flex mb-3">
                  <div class="activity-icon me-3">
                    <i class="bi bi-file-medical text-info"></i>
                  </div>
                  <div class="activity-content">
                    <h6 class="mb-1">Lab Results Ready</h6>
                    <p class="text-muted mb-0">Blood test results are now available</p>
                    <small class="text-muted">3 days ago</small>
                  </div>
                </div>

                <div class="activity-item d-flex">
                  <div class="activity-icon me-3">
                    <i class="bi bi-person-check text-warning"></i>
                  </div>
                  <div class="activity-content">
                    <h6 class="mb-1">Profile Updated</h6>
                    <p class="text-muted mb-0">Your contact information was updated</p>
                    <small class="text-muted">1 week ago</small>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function showLoading() {
    document.getElementById('loadingOverlay').style.display = 'flex';
  }

  function hideLoading() {
    document.getElementById('loadingOverlay').style.display = 'none';
  }

  function cancelAppointment(appointmentId) {
    if (confirm('Are you sure you want to cancel this appointment? This action cannot be undone.')) {
      showLoading();
      
      fetch('/api/v1/appointment/' + appointmentId + '/cancel', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      })
      .then(response => response.json())
      .then(data => {
        hideLoading();
        if (data.success) {
          alert('Appointment cancelled successfully!');
          location.reload();
        } else {
          alert('Error: ' + (data.message || 'Failed to cancel appointment'));
        }
      })
      .catch(error => {
        hideLoading();
        alert('Network error: ' + error.message);
        console.error('Error cancelling appointment:', error);
      });
    }
  }

  // Auto-hide alerts after 5 seconds
  document.addEventListener('DOMContentLoaded', function() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
      setTimeout(() => {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }, 5000);
    });
  });
</script>
</body>
</html>