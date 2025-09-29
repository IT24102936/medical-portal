<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medisphere - Responsive Version</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700;900&display=swap" rel="stylesheet">
    
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        :root {
            --primary-color: #13a4ec;
            --dark-blue-text: #0d171b;
        }

        body {
            font-family: 'Poppins', sans-serif;
        }
        
        /* Custom styles */
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
        
        .hero-section {
            min-height: 700px;
            background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url("https://images.unsplash.com/photo-1576091160550-2173dba999ef?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80");
            background-size: cover;
            background-position: center;
        }
        
        .feature-card {
            transition: transform 0.3s ease-in-out;
        }
        .feature-card:hover {
            transform: translateY(-10px);
        }
        
        /* FONT WEIGHT REVERTED HERE */
        .navbar-brand h2 {
            font-weight: 700; /* Bolder font weight for the brand name */
        }
        
        .navbar-toggler {
            border: none;
        }
        .navbar-toggler:focus {
            box-shadow: none;
        }

        /* FONT WEIGHT REVERTED HERE */
        .display-3, .display-5 {
            font-weight: 700; /* Bold for headings */
        }

        .icon-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #e0f2fe;
        }
        
        .icon-circle .material-symbols-outlined {
            font-size: 2.8rem;
        }
    </style>
</head>
<body>

    <header class="shadow-sm">
        <nav class="navbar navbar-expand-lg bg-body-tertiary py-1 px-3 px-lg-5">
            <div class="container-fluid">
                <a class="navbar-brand d-flex align-items-center" href="#">
                    <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" style="height: 50px;" class="me-2">
                    <h2 class="text-dark-blue mb-0 fs-3">Medisphere</h2>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Book Appointment</a></li>
                        <li class="nav-item"><a class="nav-link" href="pharmacy-home">Pharmaceutical Services</a></li>
                        <li class="nav-item"><a class="nav-link" href="laboratory-services">Laboratory Services</a></li>
                    </ul>
                    <div class="d-flex flex-column flex-lg-row mt-3 mt-lg-0">
                        <div class="dropdown me-lg-2 mb-2 mb-lg-0">
                            <button class="btn btn-outline-primary fw-bold px-4 py-2 dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                Log In
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="/auth/login?role=pharmacist">💊 Pharmacist Login</a></li>
                                <li><a class="dropdown-item" href="/auth/login?role=lab-technician">🧪 Lab Technician Login</a></li>
                            </ul>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-primary fw-bold px-4 py-2 dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                Sign Up
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="/auth/register?role=pharmacist">💊 Register as Pharmacist</a></li>
                                <li><a class="dropdown-item" href="/auth/register?role=lab-technician">🧪 Register as Lab Technician</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <main>
        <section class="hero-section d-flex align-items-center justify-content-center py-5">
            <div class="container text-center text-white px-3">
                <h1 class="display-3 fw-bold">Your Health, All in One Place</h1>
                <p class="lead mt-4 mx-auto" style="max-width: 800px; color: #e5e7eb;">Book appointments, order medicines, and access your lab reports with ease. Medisphere is your trusted partner for convenient healthcare management.</p>
                <div class="mt-5 d-flex justify-content-center gap-3 flex-wrap">
                    <button class="btn btn-primary fw-bold fs-5 px-5 py-3 rounded-3">Book an Appointment</button>
                    <button class="btn btn-light fw-bold fs-5 px-5 py-3 rounded-3 text-primary">View Services</button>
                </div>
            </div>
        </section>

        <section class="py-5">
            <div class="container my-5">
                <div class="text-center mb-5 px-3">
                    <h2 class="display-5 fw-bold text-dark-blue">Comprehensive Healthcare at Your Fingertips</h2>
                    <p class="lead text-secondary mt-3 mx-auto" style="max-width: 700px;">Medisphere provides a seamless experience for all your healthcare needs.</p>
                </div>
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 shadow-lg p-4" style="background-color: #f8f9fa;">
                            <div class="card-body text-center">
                                <div class="icon-circle text-primary mx-auto mb-4">
                                    <span class="material-symbols-outlined">support_agent</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">24/7 Customer Support</h3>
                                <p class="card-text text-secondary mt-3">Our dedicated support team is available around the clock to assist you with any queries or issues.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 shadow-lg p-4" style="background-color: #f8f9fa;">
                            <div class="card-body text-center">
                                <div class="icon-circle text-primary mx-auto mb-4">
                                    <span class="material-symbols-outlined">calendar_month</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">Appointment Booking</h3>
                                <p class="card-text text-secondary mt-3">Easily schedule appointments with your preferred doctors at a time that suits you.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12">
                        <div class="card feature-card h-100 border-0 shadow-lg p-4" style="background-color: #f8f9fa;">
                             <div class="card-body text-center">
                                <div class="icon-circle text-primary mx-auto mb-4">
                                    <span class="material-symbols-outlined">security</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">Secure Details</h3>
                                <p class="card-text text-secondary mt-3">Your personal and medical information is kept secure with the highest standards of data protection.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-5 bg-white">
            <div class="container my-5">
                <h2 class="text-center display-5 fw-bold text-dark-blue mb-5 px-3">Patient's Words</h2>
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="card h-100 border-0 shadow-lg p-4" style="background-color: #f8f9fa;">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-4">
                                    <img src="https://i.pravatar.cc/150?u=maria" alt="Maria Garcia" class="rounded-circle" width="56" height="56">
                                     <div class="ms-3">
                                        <p class="fw-bold text-dark-blue fs-5 mb-0">Maria Garcia</p>
                                        <p class="text-muted mb-0">Patient</p>
                                    </div>
                                </div>
                                <p class="text-secondary">"Booking appointments through Medisphere has been a game-changer. It's so simple and I can see my doctor's availability in real-time."</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card h-100 border-0 shadow-lg p-4" style="background-color: #f8f9fa;">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-4">
                                    <img src="https://i.pravatar.cc/150?u=john" alt="John Smith" class="rounded-circle" width="56" height="56">
                                    <div class="ms-3">
                                        <p class="fw-bold text-dark-blue fs-5 mb-0">John Smith</p>
                                        <p class="text-muted mb-0">Patient</p>
                                    </div>
                                </div>
                                <p class="text-secondary">"Getting my lab reports on Medisphere is incredibly fast. I used to wait days, now I get them almost instantly. Highly recommend!"</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12">
                        <div class="card h-100 border-0 shadow-lg p-4" style="background-color: #f8f9fa;">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-4">
                                    <img src="https://i.pravatar.cc/150?u=linda" alt="Linda Williams" class="rounded-circle" width="56" height="56">
                                    <div class="ms-3">
                                        <p class="fw-bold text-dark-blue fs-5 mb-0">Linda Williams</p>
                                        <p class="text-muted mb-0">Patient</p>
                                    </div>
                                </div>
                                <p class="text-secondary">"Ordering medicines has never been easier. I just upload my prescription and the medicines arrive at my door. So convenient!"</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-5" style="background-color: #f8f9fa;">
            <div class="container my-5 text-center px-3">
                <h2 class="display-5 fw-bold text-dark-blue">Ready to Simplify Your Healthcare?</h2>
                <p class="lead text-secondary mt-3 mx-auto" style="max-width: 600px;">Join Medisphere today for a seamless and efficient healthcare experience.</p>
                <div class="mt-4">
                    <button class="btn btn-primary fw-bold fs-5 px-5 py-3 rounded-3">Get Started Now</button>
                </div>
            </div>
        </section>
    </main>

    <footer class="text-white py-5" style="background-color: #0d171b;">
        <div class="container">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-center text-center text-md-start">
                <div class="mb-3 mb-md-0">
                    <p class="mb-0 text-secondary">© 2025 Medisphere. All rights reserved.</p>
                </div>
                <nav class="nav justify-content-center mb-3 mb-md-0">
                    <a class="nav-link text-secondary" href="#">Home</a>
                    <a class="nav-link text-secondary" href="#">About</a>
                    <a class="nav-link text-secondary" href="#">Services</a>
                    <a class="nav-link text-secondary" href="#">Contact</a>
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