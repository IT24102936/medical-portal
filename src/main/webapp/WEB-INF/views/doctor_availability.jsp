<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medisphere - Doctor Availability</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        :root {
            --primary-color: #13a4ec;
            --dark-blue-text: #0d171b;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa; /* A light background for the main content area */
        }

        /* Custom styles from reference */
        .btn-primary, .bg-primary {
            background-color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }
        .btn-primary:hover {
            background-color: #0b8acb !important;
            border-color: #0b8acb !important;
        }

        .btn-outline-primary {
            color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }
        .btn-outline-primary:hover {
            color: #ffffff !important;
            background-color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }

        .text-primary {
            color: var(--primary-color) !important;
        }

        .text-dark-blue {
            color: var(--dark-blue-text) !important;
        }

        .navbar-brand h2 {
            font-weight: 700;
        }

        .navbar-toggler {
            border: none;
        }
        .navbar-toggler:focus {
            box-shadow: none;
        }

        .display-5 {
            font-weight: 700;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(19, 164, 236, 0.25);
        }

        .time-slots-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(110px, 1fr));
            gap: 0.75rem;
        }
    </style>
</head>
<body>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<header class="shadow-sm bg-body-tertiary">
    <nav class="navbar navbar-expand-lg py-1 px-3 px-lg-5">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${contextPath}/">
                <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" style="height: 50px;" class="me-2">
                <h2 class="text-dark-blue mb-0 fs-3">Medisphere</h2>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link" href="${contextPath}/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="${contextPath}/appointments">Appointment</a></li>
                    <li class="nav-item"><a class="nav-link" href="${contextPath}/patients">Patients</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${contextPath}/availability">Doctors availability</a></li>
                </ul>
                <div class="d-flex flex-column flex-lg-row mt-3 mt-lg-0">
                    <a href="${contextPath}/login">
                        <button class="btn btn-outline-primary fw-bold px-4 py-2 me-lg-2 mb-2 mb-lg-0">Log In</button>
                    </a>
                    <a href="${contextPath}/register">
                        <button class="btn btn-primary fw-bold px-4 py-2">Sign Up</button>
                    </a>
                </div>
            </div>
        </div>
    </nav>
</header>

<main class="flex-grow-1 py-5">
    <div class="container">
        <!-- Success/Error Message Display -->
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= request.getAttribute("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= request.getAttribute("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <div>
                <h1 class="display-5 fw-bold text-dark-blue mb-0">Doctor Availability & Schedules</h1>
                <p class="lead text-secondary mt-2 mb-0">Check, view, and manage doctor schedules seamlessly.</p>
            </div>
            <div class="d-flex gap-2">
                <a href="${contextPath}/receptionist/appointments" class="btn btn-outline-primary fw-bold px-4 py-2 d-flex align-items-center gap-2">
                    <i class="bi bi-calendar-check"></i> Appointments
                </a>
                <a href="${contextPath}/receptionist/patients" class="btn btn-outline-secondary fw-bold px-4 py-2 d-flex align-items-center gap-2">
                    <i class="bi bi-people"></i> Patients
                </a>
            </div>
        </div>

        <div class="card shadow-sm border-0 mb-5">
            <div class="card-header bg-light py-3">
                <h5 class="mb-0 text-dark-blue"><i class="bi bi-search me-2"></i>Check Doctor Availability</h5>
            </div>
            <div class="card-body p-4">
                <form action="${contextPath}/checkAvailability" method="POST">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-5">
                            <label for="doctorSelectCheck" class="form-label fw-medium">Select Doctor</label>
                            <select id="doctorSelectCheck" name="doctorId" class="form-select" required>
                                <option value="" selected disabled>Choose a doctor...</option>
                                <%-- JSP Change: Dynamically populate doctors --%>
                                <c:forEach var="doctor" items="${doctorsList}">
                                    <option value="${doctor.eid}">Dr. <c:out value="${doctor.eid}" /></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <label for="dateCheck" class="form-label fw-medium">Select Date</label>
                            <input type="date" id="dateCheck" name="checkDate" class="form-control" required>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">Check</button>
                        </div>
                    </div>
                </form>
                <hr class="my-4">

                <%-- JSP Change: This section should be dynamically rendered based on the form submission result --%>
                <c:if test="${not empty availabilityResult}">
                    <div>
                        <h6 class="text-dark-blue mb-3">Available Slots for <span class="text-primary">${availabilityResult.doctorName}</span> on <span class="text-primary">${availabilityResult.date}</span></h6>
                        <div class="time-slots-grid">
                            <c:forEach var="slot" items="${availabilityResult.slots}">
                                <c:choose>
                                    <c:when test="${slot.status == 'available'}">
                                        <button class="btn btn-success" disabled>${slot.time}</button>
                                    </c:when>
                                    <c:when test="${slot.status == 'booked'}">
                                        <button class="btn btn-danger" disabled>${slot.time} (Booked)</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-secondary" disabled>${slot.time} (Break)</button>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="card shadow-sm border-0 mb-5">
            <div class="card-header bg-light py-3">
                <h5 class="mb-0 text-dark-blue"><i class="bi bi-calendar-week me-2"></i>View Weekly Schedules</h5>
            </div>
            <div class="card-body p-4">
                <div class="row g-4">
                    <%-- JSP Change: Dynamically generate schedule cards --%>
                    <c:forEach var="doctor" items="${doctorsList}">
                        <div class="col-lg-4 col-md-6">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title text-dark-blue">Dr. <c:out value="${doctor.eid}"/></h5>
                                    <h6 class="card-subtitle mb-2 text-muted"><c:out value="${doctor.specialization}"/></h6>
                                    <p class="card-text">
                                            <%-- Assuming schedule details are part of the doctor object --%>
                                        <strong>Mon-Fri:</strong> 9:00 AM - 5:00 PM<br>
                                        <strong>Sat:</strong> 9:00 AM - 1:00 PM<br>
                                        <strong>Sun:</strong> Closed
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0 mb-5">
            <div class="card-header bg-light py-3">
                <h5 class="mb-0 text-dark-blue"><i class="bi bi-person-plus me-2"></i>Add New Doctor</h5>
            </div>
            <div class="card-body p-4">
                <form action="${contextPath}/addDoctor" method="POST">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-3">
                            <label for="newDoctorEid" class="form-label fw-medium">Doctor ID</label>
                            <input type="number" id="newDoctorEid" name="eid" class="form-control" placeholder="e.g., 1007" required>
                        </div>
                        <div class="col-md-4">
                            <label for="newDoctorSpecialization" class="form-label fw-medium">Specialization</label>
                            <input type="text" id="newDoctorSpecialization" name="specialization" class="form-control" placeholder="e.g., Cardiology" required>
                        </div>
                        <div class="col-md-3">
                            <label for="newDoctorAvailable" class="form-label fw-medium">Available</label>
                            <select id="newDoctorAvailable" name="available" class="form-select">
                                <option value="true" selected>Yes</option>
                                <option value="false">No</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">Add Doctor</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-header bg-light py-3">
                <h5 class="mb-0 text-dark-blue"><i class="bi bi-pencil-square me-2"></i>Manage & Update Schedules</h5>
            </div>
            <div class="card-body p-4">
                <form action="${contextPath}/manageSchedule" method="POST">
                    <div class="mb-3">
                        <label for="doctorSelectUpdate" class="form-label fw-medium">Select Doctor to Update</label>
                        <select id="doctorSelectUpdate" name="doctorId" class="form-select" required>
                            <option value="" selected disabled>Choose a doctor...</option>
                            <c:forEach var="doctor" items="${doctorsList}">
                                <option value="${doctor.eid}">Dr. <c:out value="${doctor.eid}" /></option>
                            </c:forEach>
                        </select>
                    </div>
                    <hr>
                    <h6 class="text-dark-blue mt-4 mb-3">Set Standard Weekly Hours</h6>
                    <div class="row g-3 align-items-center mb-3">
                        <div class="col-2"><label class="form-label">Monday</label></div>
                        <div class="col-4"><input type="time" name="monday_start" class="form-control" value="09:00"></div>
                        <div class="col-1 text-center">to</div>
                        <div class="col-4"><input type="time" name="monday_end" class="form-control" value="17:00"></div>
                        <div class="col-1"><input class="form-check-input" name="monday_off" type="checkbox" title="Day Off"></div>
                    </div>
                    <div class="row g-3 align-items-center mb-3">
                        <div class="col-2"><label class="form-label">Tuesday</label></div>
                        <div class="col-4"><input type="time" name="tuesday_start" class="form-control" value="09:00"></div>
                        <div class="col-1 text-center">to</div>
                        <div class="col-4"><input type="time" name="tuesday_end" class="form-control" value="17:00"></div>
                        <div class="col-1"><input class="form-check-input" name="tuesday_off" type="checkbox" title="Day Off"></div>
                    </div>
                    <%-- Add other days (Wednesday to Sunday) in a similar fashion --%>
                    <hr>
                    <h6 class="text-dark-blue mt-4 mb-3">Add Unavailability / Leave</h6>
                    <div class="row g-3 align-items-end">
                        <div class="col-md-5">
                            <label for="leaveDate" class="form-label">Date</label>
                            <input type="date" id="leaveDate" name="leaveDate" class="form-control">
                        </div>
                        <div class="col-md-5">
                            <label for="leaveReason" class="form-label">Reason</label>
                            <input type="text" id="leaveReason" name="leaveReason" class="form-control" placeholder="e.g., Vacation, Conference">
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-outline-danger w-100">Add Leave</button>
                        </div>
                    </div>
                    <div class="mt-4 pt-3 border-top text-end">
                        <button type="submit" class="btn btn-primary fw-bold px-4 py-2">Save Schedule Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<footer class="text-white py-5" style="background-color: #0d171b;">
    <div class="container">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center text-center text-md-start">
            <div class="mb-3 mb-md-0">
                <p class="mb-0 text-secondary">&copy; 2025 Medisphere. All rights reserved.</p>
            </div>
            <nav class="nav justify-content-center mb-3 mb-md-0">
                <a class="nav-link text-secondary" href="${contextPath}/">Home</a>
                <a class="nav-link text-secondary" href="${contextPath}/about">About</a>
                <a class="nav-link text-secondary" href="${contextPath}/services">Services</a>
                <a class="nav-link text-secondary" href="${contextPath}/contact">Contact</a>
            </nav>
            <div class="d-flex justify-content-center">
                <a href="#" class="text-secondary me-3"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-twitter" viewBox="0 0 16 16"><path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.142-.003-.282-.008-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z"/></svg></a>
                <a href="#" class="text-secondary me-3"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-facebook" viewBox="0 0 16 16"><path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z"/></svg></a>
                <a href="#" class="text-secondary"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-linkedin" viewBox="0 0 16 16"><path d="M0 1.146C0 .513.526 0 1.175 0h13.65C15.474 0 16 .513 16 1.146v13.708c0 .633-.526 1.146-1.175 1.146H1.175C.526 16 0 15.487 0 14.854V1.146zm4.943 12.248V6.169H2.542v7.225h2.401zm-1.2-8.212c.837 0 1.358-.554 1.358-1.248-.015-.709-.52-1.248-1.342-1.248-.822 0-1.359.54-1.359 1.248 0 .694.521 1.248 1.327 1.248h.016zm4.908 8.212V9.359c0-.216.016-.432.08-.586.173-.431.568-.878 1.232-.878.869 0 1.216.662 1.216 1.634v3.865h2.401V9.25c0-2.22-1.184-3.252-2.764-3.252-1.305 0-1.854.935-2.169 1.59h-.03v-1.34H6.649v7.225h2.402z"/></svg></a>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>