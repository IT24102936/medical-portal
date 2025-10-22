<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 9/28/2025
  Time: 10:58 PM
  To change this template use File | Settings | File Templates.
--%>
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!DOCTYPE html>
 <html lang="en">
 <head>
     <meta charset="UTF-8">
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <title>Prescriptions - Medisphere</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/DoctorStyle.css">
     <style>
         .prescription-description {
             max-width: 300px;
             overflow: hidden;
             text-overflow: ellipsis;
             white-space: nowrap;
         }
     </style>
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
                             <p class="mb-0">Prescriptions Management</p>
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
                             <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/appointments">
                                 <i class="fas fa-calendar-check me-2"></i>Appointments
                             </a>
                             <a class="nav-link active" href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions">
                                 <i class="fas fa-prescription me-2"></i>Prescriptions
                             </a>
                             <a class="nav-link" href="${pageContext.request.contextPath}/doctor/${doctor.id}/edit-profile">
                                 <i class="fas fa-edit me-2"></i>Edit Profile
                             </a>
                         </nav>
                     </div>

                     <!-- Main Content -->
                     <div class="col-md-9 medical-content">
                         <div class="d-flex justify-content-between align-items-center mb-4">
                             <h2>
                                 <i class="fas fa-prescription me-2"></i>Prescriptions
                             </h2>
                             <div class="d-flex gap-2">
                                 <a href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions/create"
                                    class="btn btn-success">
                                     <i class="fas fa-plus me-2"></i>New Prescription
                                 </a>
                             </div>
                         </div>

                         <c:if test="${not empty success}">
                             <div class="alert alert-success alert-dismissible fade show" role="alert">
                                     ${success}
                                 <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                             </div>
                         </c:if>

                         <c:if test="${not empty error}">
                             <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                     ${error}
                                 <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                             </div>
                         </c:if>

                         <c:choose>
                             <c:when test="${not empty prescriptions}">
                                 <div class="card">
                                     <div class="card-body">
                                         <div class="table-responsive">
                                             <table class="table medical-table">
                                                 <thead>
                                                 <tr>
                                                     <th>Date</th>
                                                     <th>Patient ID</th>
                                                     <th>Patient Name</th>
                                                     <th>Description</th>
                                                 </tr>
                                                 </thead>
                                                 <tbody>
                                                 <c:forEach var="prescription" items="${prescriptions}">
                                                     <tr>
                                                         <td>
                                                                 ${prescription.issueDate}
                                                         </td>
                                                         <td>
                                                             <strong>${prescription.patientId}</strong>
                                                         </td>
                                                         <td>
                                                             <strong>${prescription.patientName}</strong>
                                                         </td>
                                                         <td class="prescription-description" title="${prescription.description}">
                                                             <c:choose>
                                                                 <c:when test="${prescription.description.length() > 50}">
                                                                     ${prescription.description.substring(0, 50)}...
                                                                 </c:when>
                                                                 <c:otherwise>
                                                                     ${prescription.description}
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
                             </c:when>
                             <c:otherwise>
                                 <div class="text-center py-5">
                                     <i class="fas fa-prescription fa-3x text-muted mb-3"></i>
                                     <h4 class="text-muted">No prescriptions found</h4>
                                     <p class="text-muted">
                                         You haven't created any prescriptions yet.
                                     </p>
                                     <a href="${pageContext.request.contextPath}/doctor/${doctor.id}/prescriptions/create"
                                        class="btn btn-primary">
                                         <i class="fas fa-plus me-2"></i>Create Your First Prescription
                                     </a>
                                 </div>
                             </c:otherwise>
                         </c:choose>
                     </div>
                 </div>
             </div>
         </div>
     </div>
 </div>

 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
 </body>
 </html>