<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Doctor Appointments - Medisphere</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/DoctorStyle.css">
</head>
<body>
<div class="container-fluid py-4">
  <div class="row justify-content-center">
    <div class="col-lg-10">
      <div class="medical-container">
        <!-- Header -->
        <div class="medical-header">
          <div class="row align-items-center">
            <div class="col-md-6">
              <h1 class="h3 mb-0">
                <i class="fas fa-heartbeat me-2"></i>Medisphere
              </h1>
              <p class="mb-0">Doctor Appointments</p>
            </div>
            <div class="col-md-6 text-end">
              <div class="d-flex align-items-center justify-content-end">
                <div class="me-3">
                  <span class="fw-bold">Dr. ${doctor.firstName} ${doctor.lastName}</span>
                  <br>
                  <small class="text-light">${doctor.specialization}</small>
                </div>
                <div class="dropdown">
                  <button class="btn btn-outline-light dropdown-toggle" type="button"
                          data-bs-toggle="dropdown">
                    <i class="fas fa-user-md"></i>
                  </button>
                  <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/doctor/${doctor.id}/dashboard">
                      <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                    </a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/doctor/${doctor.id}/profile">
                      <i class="fas fa-user me-2"></i>Profile
                    </a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                      <i class="fas fa-sign-out-alt me-2"></i>Logout
                    </a></li>
                    <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions">
                      <i class="fas fa-prescription me-2"></i>Prescriptions
                    </a>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="row g-0">
          <!-- Sidebar -->
          <div class="col-md-3 medical-sidebar">
            <nav class="nav flex-column">
              <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/dashboard">
                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
              </a>
              <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/profile">
                <i class="fas fa-user me-2"></i>My Profile
              </a>
              <a class="nav-link active" href="${pageContext.request.contextPath}/doctor/${doctor.id}/appointments">
                <i class="fas fa-calendar-check me-2"></i>Appointments
              </a>
              <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/edit-profile">
                <i class="fas fa-edit me-2"></i>Edit Profile
              </a>
              <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions">
                <i class="fas fa-prescription me-2"></i>Prescriptions
              </a>
            </nav>
          </div>

          <!-- Main Content -->
          <div class="col-md-9 medical-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
              <h2>
                <i class="fas fa-calendar-check me-2"></i>Appointments
              </h2>
              <div class="d-flex gap-2">
                <select class="form-select" id="viewSelector" onchange="changeView()">
                  <option value="day" ${viewType eq 'day' ? 'selected' : ''}>Daily View</option>
                  <option value="week" ${viewType eq 'week' ? 'selected' : ''}>Weekly View</option>
                </select>
                <input type="date" class="form-control" id="dateSelector" value="${selectedDate}"
                       onchange="changeDate()">
              </div>
            </div>

            <!-- Appointment Statistics -->
            <div class="row mb-4">
              <div class="col-md-3">
                <div class="card bg-primary text-white text-center">
                  <div class="card-body">
                    <h5 class="card-title">
                      ${not empty appointments ? appointments.size() : 0}
                    </h5>
                    <p class="card-text">Total Appointments</p>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <div class="card bg-success text-white text-center">
                  <div class="card-body">
                    <h5 class="card-title">
                      <c:set var="scheduledCount" value="0" />
                      <c:forEach var="appt" items="${appointments}">
                        <c:if test="${appt.status eq 'Scheduled'}">
                          <c:set var="scheduledCount" value="${scheduledCount + 1}" />
                        </c:if>
                      </c:forEach>
                      ${scheduledCount}
                    </h5>
                    <p class="card-text">Scheduled</p>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <div class="card bg-info text-white text-center">
                  <div class="card-body">
                    <h5 class="card-title">
                      <c:set var="completedCount" value="0" />
                      <c:forEach var="appt" items="${appointments}">
                        <c:if test="${appt.status eq 'Completed'}">
                          <c:set var="completedCount" value="${completedCount + 1}" />
                        </c:if>
                      </c:forEach>
                      ${completedCount}
                    </h5>
                    <p class="card-text">Completed</p>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <div class="card bg-danger text-white text-center">
                  <div class="card-body">
                    <h5 class="card-title">
                      <c:set var="cancelledCount" value="0" />
                      <c:forEach var="appt" items="${appointments}">
                        <c:if test="${appt.status eq 'Cancelled'}">
                          <c:set var="cancelledCount" value="${cancelledCount + 1}" />
                        </c:if>
                      </c:forEach>
                      ${cancelledCount}
                    </h5>
                    <p class="card-text">Cancelled</p>
                  </div>
                </div>
              </div>
            </div>

            <c:if test="${not empty appointments}">
              <div class="card">
                <div class="card-body">
                  <div class="table-responsive">
                    <table class="table medical-table">
                      <thead>
                      <tr>
                        <th>Appointment ID</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th>Receptionist</th>
                      </tr>
                      </thead>
                      <tbody>
                      <c:forEach var="appointment" items="${appointments}">
                        <tr>
                          <td>
                            <strong>${appointment.id}</strong>
                          </td>
                          <td>
                            <c:if test="${not empty appointment.appointmentTime}">
                              ${appointment.formattedDate}
                            </c:if>
                          </td>
                          <td class="schedule-time">
                            <c:if test="${not empty appointment.appointmentTime}">
                              ${appointment.formattedTime}
                            </c:if>
                          </td>
                          <td>
                            <span class="status-badge status-${appointment.status.toLowerCase()}">
                                ${appointment.status}
                            </span>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${not empty appointment.receptionist}">
                                ${appointment.receptionist.firstName} ${appointment.receptionist.lastName}
                              </c:when>
                              <c:otherwise>
                                <span class="text-muted">Not assigned</span>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </c:if>

            <c:if test="${empty appointments}">
              <div class="text-center py-5">
                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                <h4 class="text-muted">No appointments found</h4>
                <p class="text-muted">There are no appointments for the selected date range.</p>
              </div>
            </c:if>

            <!-- Upcoming Appointments - FIXED VERSION -->
            <div class="card mt-4">
              <div class="card-header bg-success text-white">
                <h5 class="mb-0">
                  <i class="fas fa-calendar-plus me-2"></i>Upcoming Appointments (Next 7 Days)
                  <span class="badge bg-light text-dark ms-2">${not empty upcomingAppointments ? upcomingAppointments.size() : 0}</span>
                </h5>
              </div>
              <div class="card-body">
                <c:choose>
                  <c:when test="${not empty upcomingAppointments}">
                    <div class="row">
                      <c:forEach var="appointment" items="${upcomingAppointments}">
                        <div class="col-md-6 col-lg-4 mb-3">
                          <div class="card appointment-card h-100">
                            <div class="card-body">
                              <div class="d-flex justify-content-between align-items-start mb-2">
                                <h6 class="card-title mb-0">Appointment ${appointment.id}</h6>
                                <span class="badge bg-primary">${appointment.status}</span>
                              </div>
                              <p class="card-text small mb-1">
                                <i class="fas fa-calendar me-1 text-muted"></i>
                                <c:if test="${not empty appointment.appointmentTime}">
                                  ${appointment.formattedDate}
                                </c:if>
                              </p>
                              <p class="card-text small mb-2">
                                <i class="fas fa-clock me-1 text-muted"></i>
                                <c:if test="${not empty appointment.appointmentTime}">
                                  ${appointment.formattedTime}
                                </c:if>
                              </p>
                              <p class="card-text small mb-2">
                                <i class="fas fa-user-tie me-1 text-muted"></i>
                                <c:choose>
                                  <c:when test="${not empty appointment.receptionist}">
                                    ${appointment.receptionist.firstName} ${appointment.receptionist.lastName}
                                  </c:when>
                                  <c:otherwise>
                                    <span class="text-muted">No receptionist</span>
                                  </c:otherwise>
                                </c:choose>
                              </p>
                            </div>

                            <div class="card-footer bg-transparent py-2">
                              <small class="text-muted">
                                <jsp:useBean id="now" class="java.util.Date" />
                                <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
                                <c:choose>
                                  <c:when test="${not empty appointment.appointmentTime && appointment.formattedDate == today}">
                                    <i class="fas fa-bell me-1 text-warning"></i>Today
                                  </c:when>
                                  <c:otherwise>
                                    <i class="fas fa-calendar-day me-1 text-secondary"></i>Upcoming
                                  </c:otherwise>
                                </c:choose>
                              </small>
                            </div>
                          </div>
                        </div>
                      </c:forEach>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="text-center py-4">
                      <i class="fas fa-calendar-check fa-3x text-muted mb-3"></i>
                      <h5 class="text-muted">No Upcoming Appointments</h5>
                      <p class="text-muted">No scheduled appointments for the next 7 days.</p>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
  function changeView() {
    const view = document.getElementById('viewSelector').value;
    const date = document.getElementById('dateSelector').value;
    window.location.href = `${pageContext.request.contextPath}/doctor/${doctor.id}/appointments?view=${view}&date=${date}`;
  }

  function changeDate() {
    const view = document.getElementById('viewSelector').value;
    const date = document.getElementById('dateSelector').value;
    window.location.href = `${pageContext.request.contextPath}/doctor/${doctor.id}/appointments?view=${view}&date=${date}`;
  }

  // Set default date to today if not set
  document.addEventListener('DOMContentLoaded', function() {
    const dateInput = document.getElementById('dateSelector');
    if (!dateInput.value) {
      const today = new Date().toISOString().split('T')[0];
      dateInput.value = today;
    }
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
