<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laboratory Services - Medisphere</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    
    <link rel="stylesheet" href="../../resources/static/css/laboratory-services.css">
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
                        <li class="nav-item"><a class="nav-link" href="pharmacy-home.jsp">Pharmaceutical Services</a></li>
                        <li class="nav-item"><a class="nav-link active" href="./laboratory-services.html">Laboratory Services</a></li>
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
        <!-- Hero Section -->
        <section class="lab-hero-section d-flex align-items-center justify-content-center py-5">
            <!-- Floating Background Elements -->
            <div class="floating-elements">
                <div class="floating-molecule"></div>
                <div class="floating-molecule"></div>
                <div class="floating-molecule"></div>
                <div class="floating-molecule"></div>
            </div>
            
            <div class="container text-center px-3 hero-content">
                <div class="welcome-bounce">
                    <h1 class="display-3 fw-bold text-dark-blue mb-4">Accurate, Fast, and Connected Laboratory Services</h1>
                    <p class="lead mt-4 mx-auto fw-bold text-dark" style="max-width: 900px; font-size: 1.3rem; line-height: 1.6;">
                        Get your lab tests done with ease and confidence. Receive doctor's orders, track progress, and access accurate reports instantly; all in one secure, paper-free platform. Fast, reliable, and built for your peace of mind.
                    </p>
                </div>
                <div class="mt-5 fade-in-up">
                    <button class="btn btn-primary fw-bold fs-5 px-5 py-3 rounded-3 me-3 btn-pulse" data-bs-toggle="modal" data-bs-target="#labBookingModal">📋 Book Lab Test</button>
                    <button class="btn btn-outline-primary fw-bold fs-5 px-5 py-3 rounded-3">📊 View Reports</button>
                </div>
                
                <!-- Lab Stats -->
                <div class="row mt-5 g-4">
                    <div class="col-md-3 col-6">
                        <div class="text-center">
                            <div class="display-4 fw-bold text-primary">24hrs</div>
                            <p class="text-muted">Report Turnaround</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="text-center">
                            <div class="display-4 fw-bold text-primary">99.9%</div>
                            <p class="text-muted">Accuracy Rate</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="text-center">
                            <div class="display-4 fw-bold text-primary">500+</div>
                            <p class="text-muted">Test Types</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="text-center">
                            <div class="display-4 fw-bold text-primary">100%</div>
                            <p class="text-muted">Digital Reports</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Laboratory Services Section -->
        <section class="lab-services-section py-5">
            <div class="container my-5">
                <div class="text-center mb-5 px-3">
                    <h2 class="display-5 fw-bold text-dark-blue">Our Laboratory Services</h2>
                    <p class="lead text-secondary mt-3 mx-auto" style="max-width: 700px;">Comprehensive diagnostic testing with cutting-edge technology and expert analysis.</p>
                </div>
                
                <!-- Featured Lab Image Section -->
                <div class="row g-4 align-items-center mb-5">
                    <div class="col-lg-6">
                        <div class="interactive-card">
                            <img src="./assets/pre-medical-laboratory-science-unk.jpg" 
                                 alt="Modern Laboratory" 
                                 class="img-fluid lab-image w-100" 
                                 style="max-height: 400px; object-fit: cover; border-radius: 15px;">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="interactive-card">
                            <h3 class="display-6 fw-bold text-dark-blue mb-4">State-of-the-Art Laboratory</h3>
                            <p class="lead text-secondary mb-4">
                                Our advanced laboratory facility features cutting-edge equipment and certified laboratory technicians, ensuring the highest standards of accuracy and reliability for all your diagnostic needs.
                            </p>
                            <div class="d-flex align-items-center mb-3">
                                <div class="service-icon me-3" style="width: 50px; height: 50px;">
                                    <span class="material-symbols-outlined" style="font-size: 1.5rem;">verified</span>
                                </div>
                                <div>
                                    <h5 class="fw-bold text-dark-blue mb-1">CAP Accredited</h5>
                                    <p class="text-secondary mb-0">College of American Pathologists certified facility</p>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="service-icon me-3" style="width: 50px; height: 50px;">
                                    <span class="material-symbols-outlined" style="font-size: 1.5rem;">schedule</span>
                                </div>
                                <div>
                                    <h5 class="fw-bold text-dark-blue mb-1">Quick Results</h5>
                                    <p class="text-secondary mb-0">Most results available within 24-48 hours</p>
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
                                    <span class="material-symbols-outlined">bloodtype</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">🩸 Blood Tests</h3>
                                <p class="card-text text-secondary mt-3">Complete blood count, lipid panels, glucose testing, and comprehensive metabolic panels.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">microbiology</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">🦠 Microbiology</h3>
                                <p class="card-text text-secondary mt-3">Bacterial cultures, antibiotic sensitivity testing, and infectious disease diagnostics.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">genetics</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">🧬 Molecular Testing</h3>
                                <p class="card-text text-secondary mt-3">DNA/RNA analysis, genetic testing, and molecular diagnostics for precision medicine.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">favorite</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">❤️ Cardiac Markers</h3>
                                <p class="card-text text-secondary mt-3">Heart health assessment with troponin, CK-MB, and comprehensive cardiac panels.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">woman</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">🤰 Women's Health</h3>
                                <p class="card-text text-secondary mt-3">Hormone testing, pregnancy panels, and reproductive health diagnostics.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card feature-card h-100 border-0 p-4 interactive-card">
                            <div class="card-body text-center">
                                <div class="service-icon mx-auto">
                                    <span class="material-symbols-outlined">speed</span>
                                </div>
                                <h3 class="card-title fw-bold text-dark-blue h4">⚡ Urgent Testing</h3>
                                <p class="card-text text-secondary mt-3">STAT testing for emergency situations with results available within hours.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Process Section -->
        <section class="lab-process-section py-5">
            <div class="container my-5">
                <div class="text-center mb-5 px-3">
                    <h2 class="display-5 fw-bold text-dark-blue">🔄 How It Works</h2>
                    <p class="lead text-secondary mt-3 mx-auto" style="max-width: 600px;">Simple, streamlined process for accurate lab testing</p>
                </div>
                <div class="row g-4">
                    <div class="col-lg-3 col-md-6">
                        <div class="process-card text-center">
                            <div class="process-number">1</div>
                            <div class="process-icon">
                                <span class="material-symbols-outlined">assignment</span>
                            </div>
                            <h4 class="fw-bold text-dark-blue mt-3">Receive Order</h4>
                            <p class="text-secondary">Doctor sends lab order directly to our system or you book online</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="process-card text-center">
                            <div class="process-number">2</div>
                            <div class="process-icon">
                                <span class="material-symbols-outlined">science</span>
                            </div>
                            <h4 class="fw-bold text-dark-blue mt-3">Sample Collection</h4>
                            <p class="text-secondary">Quick and comfortable sample collection by trained professionals</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="process-card text-center">
                            <div class="process-number">3</div>
                            <div class="process-icon">
                                <span class="material-symbols-outlined">biotech</span>
                            </div>
                            <h4 class="fw-bold text-dark-blue mt-3">Advanced Analysis</h4>
                            <p class="text-secondary">State-of-the-art equipment analyzes your samples with precision</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="process-card text-center">
                            <div class="process-number">4</div>
                            <div class="process-icon">
                                <span class="material-symbols-outlined">description</span>
                            </div>
                            <h4 class="fw-bold text-dark-blue mt-3">Digital Reports</h4>
                            <p class="text-secondary">Secure, instant access to your results through our platform</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Call to Action Section -->
        <section class="py-5" style="background: linear-gradient(135deg, #f8fbff 0%, #e3f2fd 100%); position: relative; overflow: hidden;">
            <div class="container my-5 text-center px-3 position-relative" style="z-index: 2;">
                <div class="interactive-card mx-auto" style="max-width: 800px;">
                    <h2 class="display-5 fw-bold text-dark-blue">Ready for Your Lab Test?</h2>
                    <p class="lead text-secondary mt-3 mx-auto" style="max-width: 600px;">Experience accurate, fast, and reliable laboratory services with Medisphere today. Your health insights are just a click away!</p>
                    <div class="mt-4">
                        <button class="btn btn-outline-primary fw-bold fs-5 px-5 py-3 rounded-3">📞 Contact Lab</button>
                    </div>
                    
                    <!-- Trust Indicators -->
                    <div class="row mt-5 g-3">
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="material-symbols-outlined text-primary me-2">verified</span>
                                <small class="fw-bold text-muted">CAP Certified</small>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="material-symbols-outlined text-primary me-2">security</span>
                                <small class="fw-bold text-muted">HIPAA Compliant</small>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="material-symbols-outlined text-primary me-2">schedule</span>
                                <small class="fw-bold text-muted">24hr Turnaround</small>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center justify-content-center">
                                <span class="material-symbols-outlined text-primary me-2">thumb_up</span>
                                <small class="fw-bold text-muted">99.9% Accurate</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Background decoration -->
            <div style="position: absolute; top: 10%; right: -5%; width: 200px; height: 200px; background: radial-gradient(circle, rgba(19, 164, 236, 0.1), transparent); border-radius: 50%;"></div>
            <div style="position: absolute; bottom: 10%; left: -5%; width: 150px; height: 150px; background: radial-gradient(circle, rgba(19, 164, 236, 0.08), transparent); border-radius: 50%;"></div>
        </section>

        <!-- Lab Test Booking Modal -->
        <div class="modal fade" id="labBookingModal" tabindex="-1" aria-labelledby="labBookingModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-4 fw-bold text-dark-blue" id="labBookingModalLabel">
                            <span class="material-symbols-outlined me-2" style="vertical-align: middle;">science</span>
                            Book Your Lab Test
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="labBookingForm">
                            <!-- Test Selection Section -->
                            <div class="mb-4">
                                <h5 class="fw-bold text-dark-blue mb-3">
                                    <span class="material-symbols-outlined me-2" style="vertical-align: middle; font-size: 1.2rem;">checklist</span>
                                    Select Lab Tests
                                </h5>
                                <div class="row g-2">
                                    <div class="col-md-6">
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="Complete Blood Count (CBC)" id="test1" name="labTests">
                                            <label class="form-check-label" for="test1">
                                                🩸 Complete Blood Count (CBC)
                                            </label>
                                        </div>
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="Lipid Panel" id="test2" name="labTests">
                                            <label class="form-check-label" for="test2">
                                                ❤️ Lipid Panel (Cholesterol)
                                            </label>
                                        </div>
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="Blood Glucose Test" id="test3" name="labTests">
                                            <label class="form-check-label" for="test3">
                                                🍬 Blood Glucose Test
                                            </label>
                                        </div>
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="Thyroid Function Test" id="test4" name="labTests">
                                            <label class="form-check-label" for="test4">
                                                🧬 Thyroid Function Test
                                            </label>
                                        </div>
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="Liver Function Test" id="test5" name="labTests">
                                            <label class="form-check-label" for="test5">
                                                🧿 Liver Function Test
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="Kidney Function Test" id="test6" name="labTests">
                                            <label class="form-check-label" for="test6">
                                                🫧 Kidney Function Test
                                            </label>
                                        </div>
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="Vitamin D Test" id="test7" name="labTests">
                                            <label class="form-check-label" for="test7">
                                                ☀️ Vitamin D Test
                                            </label>
                                        </div>
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="Urine Analysis" id="test8" name="labTests">
                                            <label class="form-check-label" for="test8">
                                                🧪 Urine Analysis
                                            </label>
                                        </div>
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="HbA1c (Diabetes)" id="test9" name="labTests">
                                            <label class="form-check-label" for="test9">
                                                📊 HbA1c (Diabetes)
                                            </label>
                                        </div>
                                        <div class="form-check test-checkbox">
                                            <input class="form-check-input" type="checkbox" value="Inflammatory Markers (CRP/ESR)" id="test10" name="labTests">
                                            <label class="form-check-label" for="test10">
                                                🔥 Inflammatory Markers
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr class="my-4">

                            <!-- Patient Information Section -->
                            <div class="mb-4">
                                <h5 class="fw-bold text-dark-blue mb-3">
                                    <span class="material-symbols-outlined me-2" style="vertical-align: middle; font-size: 1.2rem;">person</span>
                                    Patient Information
                                </h5>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="firstName" class="form-label fw-semibold">First Name *</label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="lastName" class="form-label fw-semibold">Last Name *</label>
                                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="contactNumber" class="form-label fw-semibold">Contact Number *</label>
                                        <input type="tel" class="form-control" id="contactNumber" name="contactNumber" placeholder="(+94) 77 123 4567" required>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="age" class="form-label fw-semibold">Age *</label>
                                        <input type="number" class="form-control" id="age" name="age" min="1" max="120" required>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="gender" class="form-label fw-semibold">Gender *</label>
                                        <select class="form-select" id="gender" name="gender" required>
                                            <option value="">Select Gender</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                            <option value="Other">Other</option>
                                            <option value="Prefer not to say">Prefer not to say</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <label for="specialInstructions" class="form-label fw-semibold">Special Instructions (Optional)</label>
                                        <textarea class="form-control" id="specialInstructions" name="specialInstructions" rows="3" placeholder="Any special requirements or medical conditions we should know about..."></textarea>
                                    </div>
                                </div>
                            </div>

                            <!-- Summary Section -->
                            <div class="alert alert-info">
                                <h6 class="fw-bold mb-2">
                                    <span class="material-symbols-outlined me-2" style="vertical-align: middle; font-size: 1rem;">info</span>
                                    Important Information
                                </h6>
                                <ul class="mb-0 small">
                                    <li>Please fast for 12 hours before blood glucose and lipid panel tests</li>
                                    <li>Bring a valid ID and insurance card</li>
                                    <li>Results will be available within 24-48 hours</li>
                                    <li>You will receive an SMS confirmation with appointment details</li>
                                </ul>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" form="labBookingForm" class="btn btn-primary fw-bold">
                            <span class="material-symbols-outlined me-2" style="vertical-align: middle; font-size: 1rem;">send</span>
                            Submit to Lab Technician
                        </button>
                    </div>
                </div>
            </div>
        </div>
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
                    <a class="nav-link text-secondary" href="pharmacy-home.jsp">Pharmacy</a>
                    <a class="nav-link text-secondary" href="./laboratory-services.html">Laboratory</a>
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

            // Lab booking form submission
            const labBookingForm = document.getElementById('labBookingForm');
            const modal = document.getElementById('labBookingModal');
            const modalInstance = new bootstrap.Modal(modal);

            labBookingForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Get selected lab tests
                const selectedTests = [];
                const checkboxes = document.querySelectorAll('input[name="labTests"]:checked');
                checkboxes.forEach(checkbox => {
                    selectedTests.push(checkbox.value);
                });

                // Validate that at least one test is selected
                if (selectedTests.length === 0) {
                    alert('Please select at least one lab test.');
                    return;
                }

                // Get form data
                const formData = new FormData(labBookingForm);
                const patientData = {
                    firstName: formData.get('firstName'),
                    lastName: formData.get('lastName'),
                    contactNumber: formData.get('contactNumber'),
                    age: formData.get('age'),
                    gender: formData.get('gender'),
                    specialInstructions: formData.get('specialInstructions'),
                    selectedTests: selectedTests,
                    bookingDate: new Date().toISOString(),
                    bookingId: 'LAB-' + Date.now().toString().slice(-6)
                };

                // Simulate submission to lab technician
                console.log('Lab Test Booking Submitted:', patientData);
                
                // Show success message
                alert(`Thank you, ${patientData.firstName}! Your lab test booking has been submitted to our technicians.

Booking ID: ${patientData.bookingId}
Selected Tests: ${selectedTests.length}

You will receive an SMS confirmation shortly.`);
                
                // Reset form and close modal
                labBookingForm.reset();
                modalInstance.hide();
            });

            // Phone number formatting for Sri Lankan format (+94) 7x xxx xxxx
            const phoneInput = document.getElementById('contactNumber');
            phoneInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                
                // Remove country code if entered
                if (value.startsWith('94')) {
                    value = value.slice(2);
                }
                
                // Format: (+94) 7x xxx xxxx
                if (value.length > 0) {
                    if (value.length <= 2) {
                        value = `(+94) ${value}`;
                    } else if (value.length <= 5) {
                        value = `(+94) ${value.slice(0, 2)} ${value.slice(2)}`;
                    } else {
                        value = `(+94) ${value.slice(0, 2)} ${value.slice(2, 5)} ${value.slice(5, 9)}`;
                    }
                }
                e.target.value = value;
            });
        });
    </script>
</body>
</html>