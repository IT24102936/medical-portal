<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Medisphere</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .booking-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .step-indicator {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
        }
        .step {
            text-align: center;
            flex: 1;
            position: relative;
        }
        .step:not(:last-child)::after {
            content: '';
            position: absolute;
            top: 20px;
            left: 50%;
            right: -50%;
            height: 2px;
            background-color: #dee2e6;
            z-index: 1;
        }
        .step.active .step-number {
            background-color: #0d6efd;
            color: white;
        }
        .step.completed .step-number {
            background-color: #198754;
            color: white;
        }
        .step-number {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e9ecef;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 0.5rem;
            position: relative;
            z-index: 2;
        }
        .step-label {
            font-size: 0.875rem;
            color: #6c757d;
        }
        .step.active .step-label {
            color: #0d6efd;
            font-weight: 500;
        }
        .step.completed .step-label {
            color: #198754;
            font-weight: 500;
        }
        .form-section {
            display: none;
        }
        .form-section.active {
            display: block;
        }
        .doctor-card {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .doctor-card:hover {
            border-color: #0d6efd;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .doctor-card.selected {
            border-color: #0d6efd;
            background-color: rgba(13, 110, 253, 0.05);
        }
        .summary-item {
            padding: 0.75rem;
            border-bottom: 1px solid #dee2e6;
        }
        .summary-item:last-child {
            border-bottom: none;
        }
        .summary-label {
            font-weight: 500;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #0a193a;">
        <div class="container">
            <a class="navbar-brand" href="/">
                <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" style="height: 40px;" class="me-2">
                Medisphere
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/receptionist/dashboard">
                    <i class="bi bi-speedometer2 me-1"></i>Dashboard
                </a>
                <a class="nav-link active" href="/bookAppointment">
                    <i class="bi bi-calendar-plus me-1"></i>Book Appointment
                </a>
                <a class="nav-link" href="/" style="color: #ff6b6b;">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="booking-card">
            <h2 class="text-center mb-4">Book Appointment</h2>
            
            <!-- Step Indicator -->
            <div class="step-indicator">
                <div class="step active" id="step1-indicator">
                    <div class="step-number">1</div>
                    <div class="step-label">Select Doctor</div>
                </div>
                <div class="step" id="step2-indicator">
                    <div class="step-number">2</div>
                    <div class="step-label">Patient & Receptionist</div>
                </div>
                <div class="step" id="step3-indicator">
                    <div class="step-number">3</div>
                    <div class="step-label">Confirmation</div>
                </div>
            </div>
            
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
            
            <!-- Step 1: Select Doctor -->
            <div class="form-section active" id="step1">
                <h4 class="mb-4">Select a Doctor</h4>
                <div class="row">
                    <c:forEach var="doctor" items="${doctorsList}">
                        <div class="col-md-6 col-lg-4 mb-3">
                            <div class="doctor-card" onclick="selectDoctor(<c:out value='${doctor.id}'/>)">
                                <div class="d-flex align-items-center">
                                    <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 50px; height: 50px;">
                                        <i class="bi bi-person-fill text-white"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">Dr. <c:out value="${doctor.fullName}"/></h6>
                                        <small class="text-muted"><c:out value="${doctor.specialization}"/></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="d-flex justify-content-between mt-4">
                    <div></div> <!-- Empty div for spacing -->
                    <button type="button" class="btn btn-primary" onclick="nextStep(1)">Next <i class="bi bi-arrow-right"></i></button>
                </div>
            </div>
            
            <!-- Step 2: Patient & Receptionist -->
            <div class="form-section" id="step2">
                <h4 class="mb-4">Patient & Receptionist Information</h4>
                <form id="appointmentForm">
                    <input type="hidden" id="doctorId" name="doctorId" value="">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="patientId" class="form-label">Patient ID</label>
                            <input type="number" class="form-control" id="patientId" name="patientId" required>
                        </div>
                        <div class="col-md-6">
                            <label for="receptionistId" class="form-label">Receptionist ID</label>
                            <input type="number" class="form-control" id="receptionistId" name="receptionistId" required>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <button type="button" class="btn btn-outline-secondary" onclick="prevStep(2)"><i class="bi bi-arrow-left"></i> Previous</button>
                        <button type="button" class="btn btn-primary" onclick="nextStep(2)">Next <i class="bi bi-arrow-right"></i></button>
                    </div>
                </form>
            </div>
            
            <!-- Step 3: Confirmation -->
            <div class="form-section" id="step3">
                <h4 class="mb-4">Appointment Confirmation</h4>
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Appointment Details</h5>
                        <div class="summary-item">
                            <div class="row">
                                <div class="col-sm-4"><span class="summary-label">Doctor:</span></div>
                                <div class="col-sm-8" id="summaryDoctor">-</div>
                            </div>
                        </div>
                        <div class="summary-item">
                            <div class="row">
                                <div class="col-sm-4"><span class="summary-label">Patient ID:</span></div>
                                <div class="col-sm-8" id="summaryPatientId">-</div>
                            </div>
                        </div>
                        <div class="summary-item">
                            <div class="row">
                                <div class="col-sm-4"><span class="summary-label">Receptionist ID:</span></div>
                                <div class="col-sm-8" id="summaryReceptionistId">-</div>
                            </div>
                        </div>
                        <div class="summary-item">
                            <div class="row">
                                <div class="col-sm-4"><span class="summary-label">Appointment Time:</span></div>
                                <div class="col-sm-8" id="summaryTime"><%= java.time.LocalDateTime.now() %></div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="d-flex justify-content-between mt-4">
                    <button type="button" class="btn btn-outline-secondary" onclick="prevStep(3)"><i class="bi bi-arrow-left"></i> Previous</button>
                    <button type="button" class="btn btn-success" onclick="confirmAppointment()">Confirm Appointment</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let selectedDoctorId = null;
        
        function selectDoctor(doctorId) {
            // Remove selected class from all doctor cards
            document.querySelectorAll('.doctor-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Add selected class to clicked card
            event.currentTarget.classList.add('selected');
            
            // Store selected doctor ID
            selectedDoctorId = doctorId;
            document.getElementById('doctorId').value = doctorId;
        }
        
        function nextStep(currentStep) {
            // Validate current step before proceeding
            if (currentStep === 1) {
                if (!selectedDoctorId) {
                    alert('Please select a doctor');
                    return;
                }
            } else if (currentStep === 2) {
                const patientId = document.getElementById('patientId').value;
                const receptionistId = document.getElementById('receptionistId').value;
                
                if (!patientId || !receptionistId) {
                    alert('Please fill all required fields');
                    return;
                }
                
                // Update summary
                updateSummary();
            }
            
            // Hide current step
            document.getElementById('step' + currentStep).classList.remove('active');
            document.getElementById('step' + currentStep + '-indicator').classList.remove('active');
            
            // Show next step
            const nextStepNum = currentStep + 1;
            document.getElementById('step' + nextStepNum).classList.add('active');
            document.getElementById('step' + nextStepNum + '-indicator').classList.add('active');
            document.getElementById('step' + nextStepNum + '-indicator').classList.add('completed');
        }
        
        function prevStep(currentStep) {
            // Hide current step
            document.getElementById('step' + currentStep).classList.remove('active');
            document.getElementById('step' + currentStep + '-indicator').classList.remove('active');
            
            // Show previous step
            const prevStepNum = currentStep - 1;
            document.getElementById('step' + prevStepNum).classList.add('active');
            document.getElementById('step' + prevStepNum + '-indicator').classList.add('active');
            document.getElementById('step' + currentStep + '-indicator').classList.remove('completed');
        }
        
        function updateSummary() {
            // Get form values
            const doctorId = document.getElementById('doctorId').value;
            const patientId = document.getElementById('patientId').value;
            const receptionistId = document.getElementById('receptionistId').value;
            
            // Update summary
            document.getElementById('summaryDoctor').textContent = 'Dr. ' + doctorId;
            document.getElementById('summaryPatientId').textContent = patientId;
            document.getElementById('summaryReceptionistId').textContent = receptionistId;
        }
        
        function confirmAppointment() {
            // Submit the form
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/bookAppointment';
            
            // Add form fields
            const doctorIdInput = document.createElement('input');
            doctorIdInput.type = 'hidden';
            doctorIdInput.name = 'doctorId';
            doctorIdInput.value = document.getElementById('doctorId').value;
            form.appendChild(doctorIdInput);
            
            const patientIdInput = document.createElement('input');
            patientIdInput.type = 'hidden';
            patientIdInput.name = 'patientId';
            patientIdInput.value = document.getElementById('patientId').value;
            form.appendChild(patientIdInput);
            
            const receptionistIdInput = document.createElement('input');
            receptionistIdInput.type = 'hidden';
            receptionistIdInput.name = 'receptionistId';
            receptionistIdInput.value = document.getElementById('receptionistId').value;
            form.appendChild(receptionistIdInput);
            
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>