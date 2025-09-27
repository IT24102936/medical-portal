<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy Services - Medisphere</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    
    <link rel="stylesheet" href="../../resources/static/css/pharmacy-home.css">
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
                        <li class="nav-item"><a class="nav-link" href="./home.html">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
                        <li class="nav-item"><a class="nav-link active" href="./pharmacy-home.html">Pharmaceutical Services</a></li>
                        <li class="nav-item"><a class="nav-link" href="laboratory-services.jsp">Laboratory Services</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Book Appointment</a></li>
                    </ul>
                    <div class="d-flex flex-column flex-lg-row mt-3 mt-lg-0">
                        <button class="btn btn-outline-primary fw-bold px-4 py-2 me-lg-2 mb-2 mb-lg-0">Log In</button>
                        <button class="btn btn-primary fw-bold px-4 py-2">Sign Up</button>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <main>
        <section class="pharmacy-hero-section d-flex align-items-center justify-content-center py-5">
            <!-- Floating Background Elements -->
            <div class="floating-elements">
                <div class="floating-pill"></div>
                <div class="floating-pill"></div>
                <div class="floating-pill"></div>
                <div class="floating-pill"></div>
            </div>
            
            <div class="container text-center px-3 hero-content">
                <div class="welcome-bounce">
                    <h1 class="display-3 fw-bold text-dark-blue mb-4">Welcome to Medisphere Pharmacy</h1>
                    <p class="lead mt-4 mx-auto fw-bold text-dark" style="max-width: 800px; font-size: 1.3rem; line-height: 1.6;">
                        Your trusted partner for seamless pharmaceutical services. Our expert pharmacists fulfill prescriptions promptly, ensuring you receive quality medication with ease and confidence.
                    </p>
                </div>
                <div class="mt-5 fade-in-up">
                    <button class="btn btn-primary fw-bold fs-5 px-5 py-3 rounded-3 me-3 btn-pulse">Get My Medicine</button>
                </div>
                
                <!-- Welcome Stats -->
                <div class="row mt-5 g-4">
                    <div class="col-md-4">
                        <div class="text-center">
                            <div class="display-4 fw-bold text-primary">500+</div>
                            <p class="text-muted">Happy Patients</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="text-center">
                            <div class="display-4 fw-bold text-primary">24/7</div>
                            <p class="text-muted">Service Available</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="text-center">
                            <div class="display-4 fw-bold text-primary">100%</div>
                            <p class="text-muted">Quality Assured</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Pharmacy Services Section -->
        <section class="pharmacy-services-section py-5">
            <div class="container my-5">
                <div class="text-center mb-5 px-3">
                    <h2 class="display-5 fw-bold text-dark-blue">Our Pharmaceutical Services</h2>
                    <p class="lead text-secondary mt-3 mx-auto" style="max-width: 700px;">Professional pharmacy services designed for your convenience and health.</p>
                </div>
                
                <!-- Image Section -->
                <div class="row g-4 align-items-center mb-5">
                    <div class="col-lg-6">
                        <div class="interactive-card">
                            <img src="./assets/pharmacist-921577312.jpg" 
                                 alt="Professional Pharmacist" 
                                 class="img-fluid pharmacy-image w-100" 
                                 style="max-height: 400px; object-fit: cover; border-radius: 15px;">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="interactive-card">
                            <h3 class="display-6 fw-bold text-dark-blue mb-4">Expert Pharmaceutical Care</h3>
                            <p class="lead text-secondary mb-4">
                                Our team of licensed pharmacists brings years of experience and dedication to ensuring you receive the highest quality pharmaceutical care. We're committed to your health and well-being.
                            </p>
                            <div class="d-flex align-items-center mb-3">
                                <div class="service-icon me-3" style="width: 50px; height: 50px;">
                                    <span class="material-symbols-outlined" style="font-size: 1.5rem;">verified</span>
                                </div>
                                <div>
                                    <h5 class="fw-bold text-dark-blue mb-1">Licensed Professionals</h5>
                                    <p class="text-secondary mb-0">All our pharmacists are fully licensed and certified</p>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="service-icon me-3" style="width: 50px; height: 50px;">
                                    <span class="material-symbols-outlined" style="font-size: 1.5rem;">schedule</span>
                                </div>
                                <div>
                                    <h5 class="fw-bold text-dark-blue mb-1">Quick Service</h5>
                                    <p class="text-secondary mb-0">Fast and efficient prescription processing</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Service Cards -->
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">medication</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">💊 Prescription Fulfillment</h3>
                                <p class="card-text text-secondary mt-3">Fast and accurate prescription processing by certified pharmacists with quality medication assurance.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">health_and_safety</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">👩‍⚕️ Medication Counseling</h3>
                                <p class="card-text text-secondary mt-3">Expert guidance on proper medication usage, side effects, and drug interactions.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">vaccines</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">💉 Immunizations</h3>
                                <p class="card-text text-secondary mt-3">Comprehensive vaccination services including flu shots, travel vaccines, and routine immunizations.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">monitor_heart</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">🩺 Health Monitoring</h3>
                                <p class="card-text text-secondary mt-3">Blood pressure checks, glucose monitoring, and medication therapy management services.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">pill</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">🔄 Medication Synchronization</h3>
                                <p class="card-text text-secondary mt-3">Coordinate all your prescriptions to be ready on the same day for your convenience.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">emergency</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">⚡ Emergency Refills</h3>
                                <p class="card-text text-secondary mt-3">Emergency prescription refills and urgent medication needs available when you need them most.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Process Section -->
        <section class="pharmacy-process-section py-5">
            <div class="container my-5">
                <div class="text-center mb-5 px-3">
                    <h2 class="display-5 fw-bold text-dark-blue">🔄 How It Works</h2>
                    <p class="lead text-secondary mt-3 mx-auto" style="max-width: 600px;">Simple, streamlined process for your pharmaceutical needs</p>
                </div>
                <div class="row g-4">
                    <div class="col-lg-3 col-md-6">
                        <div class="process-card text-center">
                            <div class="process-number">1</div>
                            <div class="process-icon">
                                <span class="material-symbols-outlined">description</span>
                            </div>
                            <h4 class="fw-bold text-dark-blue mt-3">Submit Prescription</h4>
                            <p class="text-secondary">Bring your prescription or have your doctor send it electronically</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="process-card text-center">
                            <div class="process-number">2</div>
                            <div class="process-icon">
                                <span class="material-symbols-outlined">verified</span>
                            </div>
                            <h4 class="fw-bold text-dark-blue mt-3">Verification & Processing</h4>
                            <p class="text-secondary">Our pharmacists verify and prepare your medication safely</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="process-card text-center">
                            <div class="process-number">3</div>
                            <div class="process-icon">
                                <span class="material-symbols-outlined">notifications</span>
                            </div>
                            <h4 class="fw-bold text-dark-blue mt-3">Ready Notification</h4>
                            <p class="text-secondary">Get notified when your prescription is ready for pickup</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="process-card text-center">
                            <div class="process-number">4</div>
                            <div class="process-icon">
                                <span class="material-symbols-outlined">local_pharmacy</span>
                            </div>
                            <h4 class="fw-bold text-dark-blue mt-3">Pickup & Counseling</h4>
                            <p class="text-secondary">Collect your medication with personalized counseling</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Call to Action Section -->
        <section class="py-5" style="background: linear-gradient(135deg, #f8fbff 0%, #e3f2fd 100%); position: relative; overflow: hidden;">
            <div class="container my-5 text-center px-3 position-relative" style="z-index: 2;">
                <div class="interactive-card mx-auto" style="max-width: 800px;">
                    <h2 class="display-5 fw-bold text-dark-blue">Ready to Get Your Medication?</h2>
                    <p class="lead text-secondary mt-3 mx-auto" style="max-width: 600px;">Experience hassle-free pharmaceutical services with Medisphere today. Your health is our priority!</p>
                    <div class="mt-4">
                        <button class="btn btn-primary fw-bold fs-5 px-5 py-3 rounded-3 me-3 btn-pulse">📞 Contact Pharmacist</button>
                    </div>
                    
                    <!-- Trust Indicators -->
                    <div class="row mt-5 g-3">
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="material-symbols-outlined text-primary me-2">shield</span>
                                <small class="fw-bold text-muted">Secure</small>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="material-symbols-outlined text-primary me-2">verified</span>
                                <small class="fw-bold text-muted">Licensed</small>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="material-symbols-outlined text-primary me-2">speed</span>
                                <small class="fw-bold text-muted">Fast</small>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="material-symbols-outlined text-primary me-2">favorite</span>
                                <small class="fw-bold text-muted">Trusted</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Background decoration -->
            <div style="position: absolute; top: 10%; right: -5%; width: 200px; height: 200px; background: radial-gradient(circle, rgba(19, 164, 236, 0.1), transparent); border-radius: 50%;"></div>
            <div style="position: absolute; bottom: 10%; left: -5%; width: 150px; height: 150px; background: radial-gradient(circle, rgba(19, 164, 236, 0.08), transparent); border-radius: 50%;"></div>
        </section>
        
        </main>

    <footer class="text-white py-5" style="background-color: #0d171b;">
        <div class="container">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-center text-center text-md-start">
                <div class="mb-3 mb-md-0">
                    <p class="mb-0 text-secondary">© 2025 Medisphere. All rights reserved.</p>
                </div>
                <nav class="nav justify-content-center mb-3 mb-md-0">
                    <a class="nav-link text-secondary" href="./home.html">Home</a>
                    <a class="nav-link text-secondary" href="#">About</a>
                    <a class="nav-link text-secondary" href="./pharmacy-home.html">Pharmacy</a>
                    <a class="nav-link text-secondary" href="laboratory-services.jsp">Laboratory</a>
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
    <script>
        // Add interactive animations
        document.addEventListener('DOMContentLoaded', function() {
            // Add entrance animation to cards
            const cards = document.querySelectorAll('.interactive-card');
            cards.forEach((card, index) => {
                card.style.animationDelay = (index * 0.1) + 's';
                card.classList.add('fade-in-up');
            });

            // Add scroll animations
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('animate-in');
                    }
                });
            }, observerOptions);

            // Observe process cards
            document.querySelectorAll('.process-card').forEach(card => {
                observer.observe(card);
            });
        });
    </script>
</body>
</html>