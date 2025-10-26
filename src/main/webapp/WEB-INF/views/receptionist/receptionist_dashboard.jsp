<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receptionist Dashboard - Medisphere</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .dashboard-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border-radius: 20px;
            padding: 2.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }
        .dashboard-card {
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
            border: none;
            background: white;
        }
        .dashboard-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25);
        }
        .dashboard-card .card-header {
            border-radius: 20px 20px 0 0 !important;
            border-bottom: none;
            padding: 1.5rem;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }
        .dashboard-card .card-body {
            padding: 2rem;
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px;
            padding: 2rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .stat-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: pulse 3s ease-in-out infinite;
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }
        .stat-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
        }
        .stat-card .card-body {
            position: relative;
            z-index: 1;
        }
        .stat-value {
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            animation: countUp 1s ease-out;
        }
        @keyframes countUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .stat-label {
            font-size: 1rem;
            opacity: 0.95;
            font-weight: 500;
        }
        .icon-wrapper {
            width: 70px;
            height: 70px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            animation: bounce 2s ease-in-out infinite;
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        .bg-primary {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%) !important;
            color: white !important;
        }
        .bg-success {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%) !important;
            color: white !important;
        }
        .bg-warning {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%) !important;
            color: white !important;
        }
        .bg-info {
            background: linear-gradient(135deg, #30cfd0 0%, #330867 100%) !important;
            color: white !important;
        }
        .appointment-list {
            max-height: 400px;
            overflow-y: auto;
        }
        .appointment-list::-webkit-scrollbar {
            width: 8px;
        }
        .appointment-list::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        .appointment-list::-webkit-scrollbar-thumb {
            background: #667eea;
            border-radius: 10px;
        }
        .appointment-item {
            border-left: 4px solid #667eea;
            padding: 1.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(to right, rgba(102, 126, 234, 0.05), transparent);
            border-radius: 0 10px 10px 0;
            transition: all 0.3s ease;
        }
        .appointment-item:hover {
            border-left-width: 6px;
            background: linear-gradient(to right, rgba(102, 126, 234, 0.1), transparent);
            transform: translateX(5px);
        }
        .appointment-item:not(:last-child) {
            border-bottom: 1px solid #dee2e6;
        }
        .recent-activity {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 0.5rem;
            background: rgba(102, 126, 234, 0.05);
            transition: all 0.3s ease;
        }
        .recent-activity:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: translateX(5px);
        }
        .action-text {
            color: #667eea;
            font-weight: 600;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 15px 30px;
            font-weight: 600;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.6);
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        .badge {
            padding: 0.5rem 1rem;
            border-radius: 10px;
            font-weight: 600;
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
                <a class="nav-link active" href="/receptionist/dashboard">
                    <i class="bi bi-speedometer2 me-1"></i>Dashboard
                </a>
                <a class="nav-link" href="/bookAppointment">
                    <i class="bi bi-calendar-plus me-1"></i>Book Appointment
                </a>
                <a class="nav-link" href="/" style="color: #ff6b6b;">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="dashboard-header">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="display-4 mb-2">
                        <i class="bi bi-speedometer2 me-3"></i>Receptionist Dashboard
                    </h1>
                    <p class="lead mb-0">
                        <i class="bi bi-person-circle me-2"></i>Welcome back, ${receptionist.name}!
                    </p>
                </div>
                <div class="text-end">
                    <p class="mb-1 fs-5">
                        <i class="bi bi-calendar-event me-2"></i>
                        <%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("MMMM dd, yyyy")) %>
                    </p>
                    <p class="mb-0 fs-5">
                        <i class="bi bi-clock me-2"></i>
                        <span id="current-time"></span>
                    </p>
                </div>
            </div>
        </div>
        
        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="dashboard-card stat-card h-100">
                    <div class="card-body">
                        <div class="icon-wrapper bg-success mx-auto">
                            <i class="bi bi-calendar-check-fill fs-1"></i>
                        </div>
                        <div class="text-center">
                            <div class="stat-value">10</div>
                            <div class="stat-label">Today's Appointments</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="dashboard-card stat-card h-100">
                    <div class="card-body">
                        <div class="icon-wrapper bg-primary mx-auto">
                            <i class="bi bi-calendar2-week-fill fs-1"></i>
                        </div>
                        <div class="text-center">
                            <div class="stat-value">5</div>
                            <div class="stat-label">Upcoming</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="dashboard-card stat-card h-100">
                    <div class="card-body">
                        <div class="icon-wrapper bg-warning mx-auto">
                            <i class="bi bi-people-fill fs-1"></i>
                        </div>
                        <div class="text-center">
                            <div class="stat-value">21</div>
                            <div class="stat-label">Total Patients</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="dashboard-card stat-card h-100">
                    <div class="card-body">
                        <div class="icon-wrapper bg-info mx-auto">
                            <i class="bi bi-person-badge-fill fs-1"></i>
                        </div>
                        <div class="text-center">
                            <div class="stat-value">7</div>
                            <div class="stat-label">Available Doctors</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="row">
            <!-- Quick Actions -->
            <div class="col-lg-4 mb-4">
                <div class="dashboard-card h-100">
                    <div class="card-header bg-white">
                        <h3 class="card-title mb-0">Quick Actions</h3>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-3">
                            <a href="/bookAppointment" class="btn btn-primary btn-lg">
                                <i class="bi bi-calendar-plus me-2"></i>Book New Appointment
                            </a>
                        </div>
                        <div class="text-center mt-4">
                            <p class="text-muted mb-0">
                                <i class="bi bi-info-circle me-2"></i>
                                Click to schedule patient appointments
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Today's Appointments -->
            <div class="col-lg-8 mb-4">
                <div class="dashboard-card h-100">
                    <div class="card-header bg-white">
                        <h3 class="card-title mb-0">Today's Appointments</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty todaysAppointments}">
                            <div class="appointment-list">
                                <c:forEach var="appointment" items="${todaysAppointments}">
                                    <div class="appointment-item">
                                        <div class="d-flex justify-content-between">
                                            <h6 class="mb-1">Appointment #${appointment.id}</h6>
                                            <span class="badge bg-primary">Scheduled</span>
                                        </div>
                                        <p class="mb-2 text-muted">
                                            <i class="bi bi-calendar me-1"></i>
                                            ${appointment.appointmentTime}
                                        </p>
                                        <div class="d-flex justify-content-between">
                                            <small>
                                                <i class="bi bi-person me-1"></i>
                                                Patient: ${appointment.patients[0].firstName} ${appointment.patients[0].lastName}
                                            </small>
                                            <small>
                                                <i class="bi bi-person-fill me-1"></i>
                                                Doctor: ${appointment.doctors[0].fullName}
                                            </small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                        <c:if test="${empty todaysAppointments}">
                            <div class="text-center py-5">
                                <i class="bi bi-calendar-x fs-1 text-muted mb-3"></i>
                                <p class="text-muted">No appointments scheduled for today</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Recent Activities -->
        <div class="row">
            <div class="col-12">
                <div class="dashboard-card">
                    <div class="card-header bg-white">
                        <h3 class="card-title mb-0">Recent Activities</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty recentActivities}">
                            <c:forEach var="activity" items="${recentActivities}">
                                <div class="recent-activity">
                                    <div class="d-flex align-items-center">
                                        <div class="me-3">
                                            <i class="bi bi-check-circle-fill text-success fs-4"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <p class="mb-0 fw-semibold">${activity.description}</p>
                                            <small class="text-muted">
                                                <i class="bi bi-clock me-1"></i>${activity.time}
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty recentActivities}">
                            <div class="text-center py-3">
                                <p class="text-muted mb-0">No recent activities</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Update time every second
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
            document.getElementById('current-time').textContent = timeString;
        }
        
        // Update time immediately and then every second
        updateTime();
        setInterval(updateTime, 60000);
    </script>
</body>
</html>