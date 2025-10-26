<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Medisphere - Reports</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;900&family=Noto+Sans:wght@400;500;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="stylesheet" href="/css/Admin-reports.css" />
</head>
<body>

<div class="d-flex flex-column flex-grow-1">
    <nav class="navbar navbar-expand-lg bg-white border-bottom shadow-sm px-4">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="#" style="gap: 0.75rem;">
                <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" style="height: 48px;">
                <span class="h4 mb-0" style="letter-spacing: -0.02em; font-weight: 900; font-family: 'Inter', sans-serif;">Medisphere</span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNavbar">
                <ul class="navbar-nav main-nav" style="gap: 1rem;">
                    <li class="nav-item"><a class="nav-link" href="/admin/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/appointments">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/patients">Patients</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/doctors">Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admin/employees">Employees</a></li>
                    <li class="nav-item"><a class="nav-link active" href="/admin/reports">Reports</a></li>
                </ul>

                <div class="d-flex align-items-center gap-2 mt-3 mt-lg-0">
                    <button class="btn btn-icon" id="themeToggle" style="color: #6c757d; --bs-btn-hover-bg: #f8f9fa; --bs-btn-hover-color: #343a40;">
                        <span class="material-symbols-outlined" id="themeIcon"> dark_mode </span>
                    </button>

                    <div class="dropdown">
                        <a href="#" class="dropdown-toggle profile-dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="rounded-circle profile-image" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuA3boPg3H5g65efIn-gaUO97A7z7vSo3zvnJwpXLtPek270t0wZTVPKt_K_IlVndXPXT4g5uljDogjVObHId6jQVZPNgMbYz62vbNrpUltGAxVXxlNM8snOB-lewtYGwz45ZJB1TdjLGWGSAhFkCvJDswSzA4KvEVBKZPfUfaTt5D_rNs4QxLxSRzk6W2hXAx_OwMzmkSnOeG-1aRn4yMfL8WAWxeEl9NhtT1lWPTAHJ6n6cHSfnKXQjShoeQujS0oA9TP1v6AzGNLj');"></div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item d-flex align-items-center gap-2" href="/logout">
                                    <span class="material-symbols-outlined">logout</span>
                                    Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <main class="flex-grow-1 p-4 p-lg-5">
        <div class="container-lg">
            <div class="mx-auto" style="max-width: 56rem;">
                <div class="mb-5">
                    <h1 class="h2 fw-bold">Reports</h1>
                    <p class="text-muted mt-2">Generate reports to analyze your practice's performance and patient data.</p>
                </div>

                <div class="d-flex flex-column gap-4">
                    <div class="card p-4">
                        <div class="card-body">
                            <h3 class="h5 fw-bold mb-4">Report Type</h3>
                            <div class="row g-3">
<%--                                <div class="col-12 col-sm-6">--%>
<%--                                    <label class="d-flex align-items-center gap-3 p-3 rounded-3 report-option-card">--%>
<%--                                        <input class="form-check-input" type="radio" name="report-type" value="user-activity" />--%>
<%--                                        <span class="fw-medium">User Activity</span>--%>
<%--                                    </label>--%>
<%--                                </div>--%>
                                <div class="col-12 col-sm-6">
                                    <label class="d-flex align-items-center gap-3 p-3 rounded-3 report-option-card active">
                                        <input class="form-check-input" type="radio" name="report-type" value="appointments" checked />
                                        <span class="fw-medium">Appointments</span>
                                    </label>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <label class="d-flex align-items-center gap-3 p-3 rounded-3 report-option-card">
                                        <input class="form-check-input" type="radio" name="report-type" value="billing" />
                                        <span class="fw-medium">Billing</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card p-4">
                        <div class="card-body">
                            <h3 class="h5 fw-bold mb-4">Date Range</h3>
                            <div class="row g-3">
                                <div class="col-12 col-sm-6">
                                    <label class="form-label" for="start-date">Start Date</label>
                                    <input type="date" class="form-control" id="start-date" />
                                </div>
                                <div class="col-12 col-sm-6">
                                    <label class="form-label" for="end-date">End Date</label>
                                    <input type="date" class="form-control" id="end-date" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-3 pt-3">
                        <button class="btn btn-outline-primary-soft fw-bold" id="cancelBtn">Cancel</button>
                        <button class="btn btn-primary fw-bold" id="generateReportBtn">Generate Report</button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="mt-auto border-top bg-white py-4">
        <div class="container">
            <p class="text-center text-muted small mb-0">© 2025 Medisphere. All rights reserved.</p>
        </div>
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/Admin-reports.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const generateReportBtn = document.getElementById('generateReportBtn');
        const cancelBtn = document.getElementById('cancelBtn');
        const reportTypeInputs = document.querySelectorAll('input[name="report-type"]');
        const startDateInput = document.getElementById('start-date');
        const endDateInput = document.getElementById('end-date');

        // Set default date range to last 30 days
        const today = new Date();
        const lastMonth = new Date();
        lastMonth.setDate(today.getDate() - 30);
        
        startDateInput.valueAsDate = lastMonth;
        endDateInput.valueAsDate = today;

        // Handle report type selection
        reportTypeInputs.forEach(input => {
            input.addEventListener('change', function() {
                document.querySelectorAll('.report-option-card').forEach(card => {
                    card.classList.remove('active');
                });
                this.closest('.report-option-card').classList.add('active');
            });
        });

        // Handle generate report button click
        generateReportBtn.addEventListener('click', function() {
            const selectedReportType = document.querySelector('input[name="report-type"]:checked').value;
            const startDate = startDateInput.value;
            const endDate = endDateInput.value;

            if (selectedReportType === 'appointments') {
                // Generate appointments report
                let url = '/admin/reports/appointments';
                if (startDate && endDate) {
                    url += '?startDate=' + startDate + '&endDate=' + endDate;
                }
                
                // Redirect to download the Excel file
                window.location.href = url;
            } else {
                alert('Only appointments report is available at this time.');
            }
        });

        // Handle cancel button click
        cancelBtn.addEventListener('click', function() {
            // Reset form
            startDateInput.valueAsDate = lastMonth;
            endDateInput.valueAsDate = today;
            
            // Reset report type to appointments
            document.querySelectorAll('input[name="report-type"]').forEach(input => {
                input.checked = input.value === 'appointments';
            });
            
            document.querySelectorAll('.report-option-card').forEach(card => {
                card.classList.remove('active');
            });
            
            document.querySelector('input[value="appointments"]').closest('.report-option-card').classList.add('active');
        });
    });
</script>
</body>
</html>