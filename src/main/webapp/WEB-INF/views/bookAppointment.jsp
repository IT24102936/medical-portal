<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Medisphere</title>
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
        .sidebar {
            background: linear-gradient(180deg, #2c3e50, #1a252f);
            color: white;
            min-height: 100vh;
            padding-top: 25px;
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
        .btn-outline-secondary {
            border: 2px solid #6c757d;
            color: #6c757d;
            padding: 12px 28px;
            font-weight: 600;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        .btn-outline-secondary:hover {
            background: #6c757d;
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

        /* Appointment Booking Styles */
        .booking-steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            position: relative;
        }
        .booking-steps::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: #e0e6ed;
            z-index: 1;
        }
        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
            flex: 1;
        }
        .step-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e0e6ed;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
            color: #6c757d;
            font-weight: 600;
        }
        .step.active .step-icon {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
        }
        .step.completed .step-icon {
            background-color: var(--primary);
            color: white;
        }
        .step-label {
            font-size: 0.85rem;
            font-weight: 500;
            text-align: center;
        }

        .booking-section {
            display: none;
        }
        .booking-section.active {
            display: block;
        }

        .doctor-card {
            border: 1px solid #e0e6ed;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .doctor-card:hover {
            border-color: var(--primary);
            box-shadow: 0 4px 12px rgba(37, 168, 146, 0.15);
        }
        .doctor-card.selected {
            border-color: var(--primary);
            background-color: rgba(37, 168, 146, 0.05);
        }
        .doctor-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 15px;
        }
        .doctor-info h5 {
            margin-bottom: 5px;
            font-weight: 600;
        }
        .doctor-specialty {
            color: var(--primary);
            font-weight: 500;
            margin-bottom: 5px;
        }
        .doctor-rating {
            color: #ffc107;
            margin-bottom: 5px;
        }
        .doctor-experience {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .calendar-container {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .calendar-table {
            width: 100%;
            border-collapse: collapse;
        }
        .calendar-table th {
            text-align: center;
            font-weight: 600;
            color: #6c757d;
            padding: 12px 0;
            border-bottom: 1px solid #e0e6ed;
        }
        .calendar-table td {
            text-align: center;
            padding: 12px 0;
            cursor: pointer;
            transition: all 0.2s ease;
            border-radius: 8px;
        }
        .calendar-table td:hover {
            background-color: #f8f9fa;
        }
        .calendar-table td.selected {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
        }
        .calendar-table td.disabled {
            color: #dee2e6;
            cursor: not-allowed;
        }
        .calendar-table td.disabled:hover {
            background-color: transparent;
        }

        .time-slots {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 10px;
            margin-top: 20px;
        }
        .time-slot {
            padding: 12px;
            text-align: center;
            border: 1px solid #e0e6ed;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .time-slot:hover {
            border-color: var(--primary);
            background-color: #f8f9fa;
        }
        .time-slot.selected {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border-color: var(--primary);
        }
        .time-slot.booked {
            background-color: #f8d7da;
            color: #721c24;
            cursor: not-allowed;
        }

        .appointment-summary {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-top: 20px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .summary-label {
            font-weight: 500;
            color: #6c757d;
        }
        .summary-value {
            font-weight: 600;
        }

        @media (max-width: 991.98px) {
            .sidebar {
                min-height: auto;
                margin-bottom: 20px;
            }
            .user-stats {
                flex-direction: column;
            }
            .content {
                padding: 20px 15px;
            }
            .booking-steps {
                flex-wrap: wrap;
            }
            .step {
                margin-bottom: 15px;
            }
        }
    </style>
</head>
<body>
<div class="loading-overlay" id="loadingOverlay">
    <div class="spinner"></div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-3 sidebar">
            <div class="brand-logo">
                <h5>Medisphere</h5>
                <small>Your partner in trusted protection</small>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/patient/dashboard">
                        <i class="fas fa-home me-2"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/patient/profile">
                        <i class="bi bi-person me-2"></i> My Profile
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/patient/appointments">
                        <i class="fas fa-calendar me-2"></i>Appointments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/patient/payment">
                        <i class="fas fa-pills me-2"></i> Medications
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/patient/claims">
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

        <div class="col-md-9 content">
            <div class="row">
                <div class="col-12">
                    <div class="header-card">
                        <%-- JSP Change: Patient name is now dynamic --%>
                        <h2>Book an Appointment, <span id="patientName"><c:out value="${patient.name}"/></span>!</h2>
                        <p>Schedule your visit with our healthcare professionals</p>
                        <div class="user-stats">
                            <div class="user-stat">
                                <i class="bi bi-person-badge"></i>
                                <div>
                                    <%-- JSP Change: Patient ID is now dynamic --%>
                                    <div><strong>Patient ID:</strong> <span id="patientId"><c:out value="${patient.id}"/></span></div>
                                </div>
                            </div>
                            <div class="user-stat">
                                <i class="bi bi-telephone"></i>
                                <div>
                                    <%-- JSP Change: Patient phone is now dynamic --%>
                                    <div><strong>Phone:</strong> <span id="patientPhone"><c:out value="${patient.phone}"/></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="content-card">
                        <div class="card-header">
                            Book New Appointment
                        </div>
                        <div class="card-body">
                            <!-- Error Message Display -->
                            <% if (request.getAttribute("error") != null) { %>
                                <div class="alert alert-danger" role="alert">
                                    <%= request.getAttribute("error") %>
                                </div>
                            <% } %>
                            
                            <!-- Success Message Display -->
                            <% if (request.getAttribute("success") != null) { %>
                                <div class="alert alert-success" role="alert">
                                    <%= request.getAttribute("success") %>
                                </div>
                            <% } %>
                            
                            <!-- Navigation Links -->
                            <div class="mb-3">
                                <a href="/" class="btn btn-outline-secondary me-2">
                                    <i class="bi bi-house"></i> Back to Home
                                </a>
                                <a href="/home" class="btn btn-outline-primary">
                                    <i class="bi bi-dashboard"></i> Dashboard
                                </a>
                            </div>
                            <div class="booking-steps">
                                <div class="step active" id="step1">
                                    <div class="step-icon">1</div>
                                    <div class="step-label">Select Doctor</div>
                                </div>
                                <div class="step" id="step2">
                                    <div class="step-icon">2</div>
                                    <div class="step-label">Choose Date</div>
                                </div>
                                <div class="step" id="step3">
                                    <div class="step-icon">3</div>
                                    <div class="step-label">Select Time</div>
                                </div>
                                <div class="step" id="step4">
                                    <div class="step-icon">4</div>
                                    <div class="step-label">Confirm</div>
                                </div>
                            </div>

                            <div class="booking-section active" id="section1">
                                <h4 class="mb-4">Select a Doctor</h4>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="specialtyFilter" class="form-label">Filter by Specialty</label>
                                        <select class="form-select" id="specialtyFilter">
                                            <option value="all">All Specialties</option>
                                            <option value="cardiology">Cardiology</option>
                                            <option value="dermatology">Dermatology</option>
                                            <option value="neurology">Neurology</option>
                                            <option value="pediatrics">Pediatrics</option>
                                            <option value="orthopedics">Orthopedics</option>
                                        </select>
                                    </div>
                                </div>

                                <div id="doctorsList">
                                    <%--
                                        JSP Change: The doctor list is now generated dynamically.
                                        A List of doctor objects should be passed from the servlet
                                        in a request attribute named "doctorsList".
                                    --%>
                                    <c:forEach var="doctor" items="${doctorsList}">
                                        <div class="doctor-card" data-doctor-id="<c:out value='${doctor.id}'/>">
                                            <div class="d-flex">
                                                <img src="<c:url value='${doctor.avatarUrl}'/>" alt="Dr. <c:out value='${doctor.name}'/>" class="doctor-avatar">
                                                <div class="doctor-info">
                                                    <h5>Dr. <c:out value="${doctor.name}"/></h5>
                                                    <div class="doctor-specialty"><c:out value="${doctor.specialty}"/></div>
                                                    <div class="doctor-rating">
                                                        <i class="bi bi-star-fill"></i>
                                                        <i class="bi bi-star-fill"></i>
                                                        <i class="bi bi-star-fill"></i>
                                                        <i class="bi bi-star-fill"></i>
                                                        <i class="bi bi-star-half"></i>
                                                        <span class="ms-1"><c:out value="${doctor.rating}"/></span>
                                                    </div>
                                                    <div class="doctor-experience"><c:out value="${doctor.experience}"/> years experience</div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="d-flex justify-content-end mt-4">
                                    <button class="btn btn-primary" id="nextToDate">Next</button>
                                </div>
                            </div>

                            <div class="booking-section" id="section2">
                                <h4 class="mb-4">Select Appointment Date</h4>
                                <div class="calendar-container">
                                    <div class="calendar-header">
                                        <button class="btn btn-sm btn-outline-secondary" id="prevMonth">
                                            <i class="bi bi-chevron-left"></i>
                                        </button>
                                        <h5 id="currentMonth">October 2025</h5>
                                        <button class="btn btn-sm btn-outline-secondary" id="nextMonth">
                                            <i class="bi bi-chevron-right"></i>
                                        </button>
                                    </div>
                                    <table class="calendar-table">
                                        <thead>
                                        <tr>
                                            <th>Sun</th>
                                            <th>Mon</th>
                                            <th>Tue</th>
                                            <th>Wed</th>
                                            <th>Thu</th>
                                            <th>Fri</th>
                                            <th>Sat</th>
                                        </tr>
                                        </thead>
                                        <tbody id="calendarDates">
                                        </tbody>
                                    </table>
                                </div>

                                <div class="d-flex justify-content-between mt-4">
                                    <button class="btn btn-outline-secondary" id="backToDoctor">Back</button>
                                    <button class="btn btn-primary" id="nextToTime">Next</button>
                                </div>
                            </div>

                            <div class="booking-section" id="section3">
                                <h4 class="mb-4">Select Appointment Time</h4>
                                <p>Available time slots for <span id="selectedDateDisplay"></span> with <span id="selectedDoctorDisplay"></span></p>

                                <div class="time-slots" id="timeSlots">
                                </div>

                                <div class="d-flex justify-content-between mt-4">
                                    <button class="btn btn-outline-secondary" id="backToDate">Back</button>
                                    <button class="btn btn-primary" id="nextToConfirm">Next</button>
                                </div>
                            </div>

                            <div class="booking-section" id="section4">
                                <h4 class="mb-4">Confirm Your Appointment</h4>

                                <div class="appointment-summary">
                                    <div class="summary-item">
                                        <span class="summary-label">Doctor:</span>
                                        <span class="summary-value" id="confirmDoctor"></span>
                                    </div>
                                    <div class="summary-item">
                                        <span class="summary-label">Date:</span>
                                        <span class="summary-value" id="confirmDate"></span>
                                    </div>
                                    <div class="summary-item">
                                        <span class="summary-label">Time:</span>
                                        <span class="summary-value" id="confirmTime"></span>
                                    </div>
                                    <div class="summary-item">
                                        <span class="summary-label">Duration:</span>
                                        <span class="summary-value">30 minutes</span>
                                    </div>
                                    <div class="summary-item">
                                        <span class="summary-label">Consultation Fee:</span>
                                        <span class="summary-value">$150</span>
                                    </div>
                                </div>

                                <div class="form-check mt-4">
                                    <input class="form-check-input" type="checkbox" id="termsCheck">
                                    <label class="form-check-label" for="termsCheck">
                                        I agree to the <a href="#">terms and conditions</a> and understand that cancellation fees may apply if I miss my appointment.
                                    </label>
                                </div>

                                <div class="d-flex justify-content-between mt-4">
                                    <button class="btn btn-outline-secondary" id="backToTime">Back</button>
                                    <button class="btn btn-primary" id="confirmAppointment" disabled>Confirm Appointment</button>
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
    // Global variables to store booking data
    let bookingData = {
        doctorId: null,
        doctorName: null,
        date: null,
        time: null
    };

    // DOM elements
    const steps = document.querySelectorAll('.step');
    const sections = document.querySelectorAll('.booking-section');
    const doctorCards = document.querySelectorAll('.doctor-card');
    const calendarDates = document.getElementById('calendarDates');
    const timeSlots = document.getElementById('timeSlots');
    const currentMonthElement = document.getElementById('currentMonth');
    const selectedDateDisplay = document.getElementById('selectedDateDisplay');
    const selectedDoctorDisplay = document.getElementById('selectedDoctorDisplay');
    const confirmDoctor = document.getElementById('confirmDoctor');
    const confirmDate = document.getElementById('confirmDate');
    const confirmTime = document.getElementById('confirmTime');
    const termsCheck = document.getElementById('termsCheck');
    const confirmAppointmentBtn = document.getElementById('confirmAppointment');

    // Calendar variables
    let currentDate = new Date();
    let selectedDate = null;

    // Initialize the booking process
    document.addEventListener('DOMContentLoaded', function() {
        // Step navigation
        document.getElementById('nextToDate').addEventListener('click', function() {
            if (!bookingData.doctorId) {
                alert('Please select a doctor to continue.');
                return;
            }
            navigateToStep(2);
        });

        document.getElementById('backToDoctor').addEventListener('click', function() {
            navigateToStep(1);
        });

        document.getElementById('nextToTime').addEventListener('click', function() {
            if (!selectedDate) {
                alert('Please select a date to continue.');
                return;
            }
            updateSelectedDateDisplay();
            generateTimeSlots();
            navigateToStep(3);
        });

        // Corrected duplicate ID issue in original HTML
        document.querySelector('#section3 #backToDate').addEventListener('click', function() {
            navigateToStep(2);
        });

        document.getElementById('nextToConfirm').addEventListener('click', function() {
            if (!bookingData.time) {
                alert('Please select a time slot to continue.');
                return;
            }
            updateConfirmationDetails();
            navigateToStep(4);
        });

        document.getElementById('backToTime').addEventListener('click', function() {
            navigateToStep(3);
        });

        // Doctor selection
        doctorCards.forEach(card => {
            card.addEventListener('click', function() {
                // Remove selected class from all cards
                doctorCards.forEach(c => c.classList.remove('selected'));
                // Add selected class to clicked card
                this.classList.add('selected');

                // Store selected doctor data
                bookingData.doctorId = this.getAttribute('data-doctor-id');
                const doctorNameElement = this.querySelector('h5');
                bookingData.doctorName = doctorNameElement ? doctorNameElement.textContent : 'Unknown Doctor';
            });
        });

        // Calendar navigation
        document.getElementById('prevMonth').addEventListener('click', function() {
            currentDate.setMonth(currentDate.getMonth() - 1);
            generateCalendar();
        });

        document.getElementById('nextMonth').addEventListener('click', function() {
            currentDate.setMonth(currentDate.getMonth() + 1);
            generateCalendar();
        });

        // Terms and conditions checkbox
        termsCheck.addEventListener('change', function() {
            confirmAppointmentBtn.disabled = !this.checked;
        });

        // Confirm appointment
        confirmAppointmentBtn.addEventListener('click', function() {
            // Show loading overlay
            document.getElementById('loadingOverlay').style.display = 'flex';

            // Create form data
            const formData = new FormData();
            formData.append('doctorId', bookingData.doctorId);
            formData.append('appointmentDate', bookingData.date);
            formData.append('appointmentTime', bookingData.time);
            formData.append('patientNotes', ''); // Add notes if needed

            // Submit form to server
            fetch('/bookAppointment', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                // Hide loading overlay
                document.getElementById('loadingOverlay').style.display = 'none';
                
                if (response.ok) {
                    // Show success message
                    alert('Appointment booked successfully! You will receive a confirmation email shortly.');
                    
                    // Reset form and redirect to home page
                    resetBookingForm();
                    window.location.href = '/home';
                } else {
                    alert('Failed to book appointment. Please try again.');
                }
            })
            .catch(error => {
                // Hide loading overlay
                document.getElementById('loadingOverlay').style.display = 'none';
                console.error('Error:', error);
                alert('An error occurred. Please try again.');
            });
        });

        // Initialize calendar
        generateCalendar();
    });

    // Function to navigate between steps
    function navigateToStep(stepNumber) {
        // Update steps
        steps.forEach((step, index) => {
            if (index < stepNumber - 1) {
                step.classList.add('completed');
                step.classList.remove('active');
            } else if (index === stepNumber - 1) {
                step.classList.add('active');
                step.classList.remove('completed');
            } else {
                step.classList.remove('active', 'completed');
            }
        });

        // Update sections
        sections.forEach((section, index) => {
            if (index === stepNumber - 1) {
                section.classList.add('active');
            } else {
                section.classList.remove('active');
            }
        });
    }

    // Function to generate calendar
    function generateCalendar() {
        const year = currentDate.getFullYear();
        const month = currentDate.getMonth();

        // Update current month display
        const monthNames = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ];
        currentMonthElement.textContent = `${monthNames[month]} ${year}`;

        // Get first day of month and number of days
        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        // Clear previous calendar
        calendarDates.innerHTML = '';

        // Create calendar rows
        let date = 1;
        for (let i = 0; i < 6; i++) {
            const row = document.createElement('tr');

            for (let j = 0; j < 7; j++) {
                const cell = document.createElement('td');

                if (i === 0 && j < firstDay) {
                    // Empty cells before the first day of the month
                    cell.classList.add('disabled');
                    row.appendChild(cell);
                } else if (date > daysInMonth) {
                    // Empty cells after the last day of the month
                    cell.classList.add('disabled');
                    row.appendChild(cell);
                } else {
                    // Date cells
                    cell.textContent = date;

                    const cellDate = new Date(year, month, date);
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);

                    // Disable past dates
                    if (cellDate < today) {
                        cell.classList.add('disabled');
                    } else {
                        cell.addEventListener('click', function() {
                            // Remove selected class from all dates
                            document.querySelectorAll('.calendar-table td').forEach(cell => {
                                cell.classList.remove('selected');
                            });

                            // Add selected class to clicked date
                            this.classList.add('selected');

                            // Store selected date
                            selectedDate = cellDate;
                            bookingData.date = selectedDate.toISOString().split('T')[0];
                        });
                    }

                    row.appendChild(cell);
                    date++;
                }
            }

            calendarDates.appendChild(row);

            // Stop creating rows if we've displayed all days
            if (date > daysInMonth) {
                break;
            }
        }
    }

    // Function to generate time slots
    function generateTimeSlots() {
        // Clear previous time slots
        timeSlots.innerHTML = '';

        // Generate time slots (9 AM to 5 PM, every 30 minutes)
        const startHour = 9;
        const endHour = 17;
        const interval = 30; // minutes

        for (let hour = startHour; hour < endHour; hour++) {
            for (let minute = 0; minute < 60; minute += interval) {
                const timeString = `${hour.toString().padStart(2, '0')}:${minute.toString().padStart(2, '0')}`;
                const displayTime = formatTime(hour, minute);

                const timeSlot = document.createElement('div');
                timeSlot.classList.add('time-slot');
                timeSlot.textContent = displayTime;

                // Randomly mark some slots as booked for demo purposes
                if (Math.random() < 0.3) {
                    timeSlot.classList.add('booked');
                } else {
                    timeSlot.addEventListener('click', function() {
                        // Remove selected class from all time slots
                        document.querySelectorAll('.time-slot').forEach(slot => {
                            if (!slot.classList.contains('booked')) {
                                slot.classList.remove('selected');
                            }
                        });

                        // Add selected class to clicked time slot
                        this.classList.add('selected');

                        // Store selected time
                        bookingData.time = timeString;
                    });
                }

                timeSlots.appendChild(timeSlot);
            }
        }
    }

    // Function to format time for display
    function formatTime(hour, minute) {
        const period = hour >= 12 ? 'PM' : 'AM';
        const displayHour = hour % 12 || 12;
        return `${displayHour}:${minute.toString().padStart(2, '0')} ${period}`;
    }

    // Function to update selected date display
    function updateSelectedDateDisplay() {
        if (selectedDate) {
            const options = { year: 'numeric', month: 'long', day: 'numeric' };
            selectedDateDisplay.textContent = selectedDate.toLocaleDateString('en-US', options);
        }

        if (bookingData.doctorName) {
            selectedDoctorDisplay.textContent = bookingData.doctorName;
        }
    }

    // Function to update confirmation details
    function updateConfirmationDetails() {
        if (bookingData.doctorName) {
            confirmDoctor.textContent = bookingData.doctorName;
        }

        if (selectedDate) {
            const options = { year: 'numeric', month: 'long', day: 'numeric' };
            confirmDate.textContent = selectedDate.toLocaleDateString('en-US', options);
        }

        if (bookingData.time) {
            const [hour, minute] = bookingData.time.split(':');
            confirmTime.textContent = formatTime(parseInt(hour), parseInt(minute));
        }
    }

    // Function to reset booking form
    function resetBookingForm() {
        bookingData = {
            doctorId: null,
            doctorName: null,
            date: null,
            time: null
        };

        // Reset UI
        doctorCards.forEach(card => card.classList.remove('selected'));
        document.querySelectorAll('.calendar-table td').forEach(date => date.classList.remove('selected'));
        document.querySelectorAll('.time-slot').forEach(slot => slot.classList.remove('selected'));
        termsCheck.checked = false;
        confirmAppointmentBtn.disabled = true;

        // Return to first step
        navigateToStep(1);
    }
</script>
</body>
</html>