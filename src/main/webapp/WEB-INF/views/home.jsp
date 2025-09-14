<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Medisphere</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .welcome-card {
            background: linear-gradient(135deg, #0a193a 0%, #033c5a 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .feature-card {
            transition: transform 0.3s ease;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .feature-card:hover {
            transform: translateY(-5px);
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
                <a class="nav-link" href="/">Home</a>
                <a class="nav-link" href="/login">Login</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="welcome-card">
            <h1 class="display-4">Welcome to Medisphere Dashboard</h1>
            <p class="lead">Your healthcare management hub</p>
        </div>
        
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-calendar-check text-primary" style="font-size: 3rem;"></i>
                        <h5 class="card-title mt-3">Book Appointment</h5>
                        <p class="card-text">Schedule your next medical appointment</p>
                        <a href="/bookAppointment" class="btn btn-primary">Book Now</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-file-medical text-primary" style="font-size: 3rem;"></i>
                        <h5 class="card-title mt-3">View Reports</h5>
                        <p class="card-text">Access your medical reports and lab results</p>
                        <a href="#" class="btn btn-primary">View Reports</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-capsule text-primary" style="font-size: 3rem;"></i>
                        <h5 class="card-title mt-3">Order Medicine</h5>
                        <p class="card-text">Order prescription medicines online</p>
                        <a href="#" class="btn btn-primary">Order Now</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="text-center mt-4">
            <a href="/" class="btn btn-outline-primary me-2">
                <i class="bi bi-house"></i> Back to Home
            </a>
            <a href="/login" class="btn btn-primary">
                <i class="bi bi-box-arrow-in-right"></i> Login
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
