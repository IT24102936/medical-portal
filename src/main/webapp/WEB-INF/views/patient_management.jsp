<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medisphere - Patient Management</title>

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
                    <li class="nav-item"><a class="nav-link" href="${contextPath}/receptionist/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link " href="${contextPath}/receptionist/appointments">Appointment</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${contextPath}/receptionist/patients">Patients</a></li>
                    <li class="nav-item"><a class="nav-link" href="${contextPath}/receptionist/doctors-availability">Doctors availability</a></li>
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
            <h1 class="display-5 fw-bold text-dark-blue mb-0">Patient Management</h1>
            <div class="d-flex gap-2">
                <a href="${contextPath}/receptionist/appointments" class="btn btn-outline-primary fw-bold px-4 py-2 d-flex align-items-center gap-2">
                    <i class="bi bi-calendar-check"></i> Appointments
                </a>
                <button class="btn btn-primary fw-bold px-4 py-2 d-flex align-items-center gap-2" data-bs-toggle="modal" data-bs-target="#patientModal" id="addPatientBtn">
                    <i class="bi bi-plus-circle"></i> Add New Patient
                </button>
            </div>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th scope="col" class="py-3">Patient ID</th>
                            <th scope="col" class="py-3">Full Name</th>
                            <th scope="col" class="py-3">Date of Birth</th>
                            <th scope="col" class="py-3">Email</th>
                            <th scope="col" class="py-3 text-end">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%-- JSP Change: Dynamically populate patient list --%>
                        <c:forEach var="patient" items="${patientsList}">
                            <tr>
                                <td class="fw-medium">P-${patient.patientId}</td>
                                <td><c:out value="${patient.firstName} ${patient.lastName}" /></td>
                                <td><c:out value="${patient.dob}" /></td>
                                <td><c:out value="${patient.email}" /></td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-outline-primary me-1 edit-btn"
                                            data-bs-toggle="modal"
                                            data-bs-target="#patientModal"
                                            data-id="${patient.patientId}"
                                            data-first-name="${patient.firstName}"
                                            data-last-name="${patient.lastName}"
                                            data-dob="${patient.dob}"
                                            data-gender="${patient.gender}"
                                            data-national-id="${patient.nationalId}"
                                            data-email="${patient.email}"
                                            data-address="${patient.address}"
                                            title="Edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger delete-btn"
                                            data-bs-toggle="modal"
                                            data-bs-target="#deleteModal"
                                            data-id="${patient.patientId}"
                                            title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty patientsList}">
                            <tr>
                                <td colspan="5" class="text-center p-4">No patients found. Click 'Add New Patient' to get started.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
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

<div class="modal fade" id="patientModal" tabindex="-1" aria-labelledby="patientModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <form id="patientForm" action="${contextPath}/managePatient" method="post">
                <div class="modal-header">
                    <h5 class="modal-title text-dark-blue" id="patientModalLabel">Add New Patient</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="patientId" name="patientId" value="0">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="firstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="lastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="dob" class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" id="dob" name="dob" required>
                        </div>
                        <div class="col-md-6">
                            <label for="gender" class="form-label">Gender</label>
                            <select id="gender" name="gender" class="form-select">
                                <option selected>Choose...</option>
                                <option>Male</option>
                                <option>Female</option>
                                <option>Other</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="nationalId" class="form-label">National ID</label>
                            <input type="text" class="form-control" id="nationalId" name="nationalId" required>
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                        <div class="col-12">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="3"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-dark-blue" id="deleteModalLabel">Confirm Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this patient record? This action cannot be undone.
            </div>
            <div class="modal-footer">
                <form id="deleteForm" action="${contextPath}/deletePatient" method="post">
                    <input type="hidden" id="deletePatientId" name="patientId">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">Delete Patient</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const patientModal = document.getElementById('patientModal');
        const deleteModal = document.getElementById('deleteModal');

        // Logic for Add/Edit Modal
        patientModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget; // Button that triggered the modal
            const modalTitle = patientModal.querySelector('.modal-title');
            const patientForm = document.getElementById('patientForm');

            // Reset form for "Add New"
            patientForm.reset();
            document.getElementById('patientId').value = '0';
            modalTitle.textContent = 'Add New Patient';

            // If button is an edit button, populate the form
            if (button.classList.contains('edit-btn')) {
                modalTitle.textContent = 'Edit Patient Details';

                // Extract info from data-* attributes
                document.getElementById('patientId').value = button.dataset.id;
                document.getElementById('firstName').value = button.dataset.firstName;
                document.getElementById('lastName').value = button.dataset.lastName;
                document.getElementById('dob').value = button.dataset.dob;
                document.getElementById('gender').value = button.dataset.gender;
                document.getElementById('nationalId').value = button.dataset.nationalId;
                document.getElementById('email').value = button.dataset.email;
                document.getElementById('address').value = button.dataset.address;
            }
        });

        // Logic for Delete Modal
        deleteModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const patientId = button.dataset.id;
            const deleteInput = document.getElementById('deletePatientId');
            deleteInput.value = patientId;
        });
    });
</script>
</body>
</html>