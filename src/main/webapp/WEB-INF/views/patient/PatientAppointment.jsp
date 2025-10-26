<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif}
        body{background-color:#f5f7fa;color:#333;line-height:1.6}
        .container{max-width:800px;margin:0 auto;padding:20px}
        header{background:linear-gradient(135deg,#1a73e8,#6c8ef5);color:white;padding:25px;border-radius:12px;margin-bottom:25px;box-shadow:0 4px 12px rgba(0,0,0,0.1)}
        h1{font-size:28px;margin-bottom:8px}
        .subtitle{font-size:16px;opacity:.9}
        .patient-info{background-color:white;padding:15px;border-radius:10px;margin-bottom:20px;box-shadow:0 2px 8px rgba(0,0,0,0.05)}
        .patient-info p{margin:5px 0;font-size:14px}
        .progress-steps{display:flex;justify-content:space-between;margin:30px 0;position:relative}
        .progress-steps::before{content:'';position:absolute;top:20px;left:0;right:0;height:4px;background-color:#e0e0e0;z-index:1}
        .progress-bar{position:absolute;top:20px;left:0;height:4px;background-color:#1a73e8;z-index:2;transition:width .3s ease}
        .step{display:flex;flex-direction:column;align-items:center;z-index:3}
        .step-circle{width:40px;height:40px;border-radius:50%;background-color:#e0e0e0;display:flex;align-items:center;justify-content:center;margin-bottom:8px;font-weight:bold;color:#757575;transition:all .3s ease}
        .step.active .step-circle{background-color:#1a73e8;color:white}
        .step.completed .step-circle{background-color:#4caf50;color:white}
        .step-label{font-size:14px;color:#757575;font-weight:500}
        .step.active .step-label{color:#1a73e8}
        .step-content{background-color:white;border-radius:12px;padding:25px;box-shadow:0 4px 12px rgba(0,0,0,0.08);margin-bottom:20px}
        .section-title{font-size:20px;margin-bottom:20px;color:#1a73e8;display:flex;align-items:center}
        .section-title i{margin-right:10px}
        .doctor-list{display:grid;grid-template-columns:1fr;gap:15px}
        .doctor-card{border:1px solid #e0e0e0;border-radius:10px;padding:18px;display:flex;align-items:center;cursor:pointer;transition:all .2s ease}
        .doctor-card:hover{border-color:#1a73e8;box-shadow:0 4px 8px rgba(26,115,232,0.15)}
        .doctor-card.selected{border-color:#1a73e8;background-color:#f0f7ff}
        .doctor-avatar{width:60px;height:60px;border-radius:50%;background-color:#e0e0e0;display:flex;align-items:center;justify-content:center;margin-right:15px;font-size:24px;color:#757575}
        .doctor-info{flex:1}
        .doctor-name{font-weight:600;font-size:18px;margin-bottom:5px}
        .doctor-specialty{color:#757575;margin-bottom:5px;font-size:14px}
        .date-selector-container{margin-bottom:20px}
        .date-selector-row{display:grid;grid-template-columns:repeat(3,1fr);gap:15px;margin-bottom:20px}
        .date-selector-group{display:flex;flex-direction:column}
        .date-selector-group label{font-size:14px;font-weight:600;color:#757575;margin-bottom:8px}
        .date-select{padding:12px;border:2px solid #e0e0e0;border-radius:8px;font-size:16px;background-color:white;cursor:pointer;transition:all .2s ease}
        .date-select:focus{outline:none;border-color:#1a73e8;box-shadow:0 0 0 3px rgba(26,115,232,0.1)}
        .date-select:hover{border-color:#1a73e8}
        .selected-date-display{background-color:#f0f7ff;padding:15px;border-radius:8px;text-align:center;border:2px solid #1a73e8;font-size:16px;font-weight:500;color:#1a73e8}
        .selected-date-display i{margin-right:8px}
        .time-slots{display:grid;grid-template-columns:repeat(3,1fr);gap:12px}
        .time-slot{padding:12px;border:1px solid #e0e0e0;border-radius:8px;text-align:center;cursor:pointer;transition:all .2s ease}
        .time-slot:hover{background-color:#f5f7fa}
        .time-slot.selected{background-color:#1a73e8;color:white;border-color:#1a73e8}
        .confirmation-details{background-color:#f9f9f9;padding:20px;border-radius:10px;margin-bottom:25px}
        .detail-row{display:flex;margin-bottom:12px}
        .detail-label{font-weight:600;width:120px;color:#757575}
        .detail-value{flex:1}
        .buttons{display:flex;justify-content:space-between;margin-top:25px}
        .btn{padding:12px 24px;border-radius:8px;font-weight:600;cursor:pointer;transition:all .2s ease;border:none;font-size:16px}
        .btn-prev{background-color:#f5f5f5;color:#757575}
        .btn-next{background-color:#1a73e8;color:white}
        .btn-confirm{background-color:#4caf50;color:white;width:100%}
        .hidden{display:none}
    </style>
</head>
<body>
<div class="container">
    <header>
        <h1>Book an Appointment</h1>
        <p class="subtitle">Schedule your visit with our healthcare professionals</p>
    </header>
    <div class="patient-info">
        <p><strong>Patient ID:</strong> ${patient.id}</p>
        <p><strong>Phone:</strong>
            <c:forEach items="${patient.patientPhones}" var="phone" varStatus="status">
                ${phone.phoneNumber}<c:if test="${!status.last}">, </c:if>
            </c:forEach>
        </p>
        <p><strong>Email:</strong> ${patient.email}</p>
    </div>
    <!-- Progress Steps -->
    <div class="progress-steps">
        <div class="progress-bar" id="progressBar"></div>
        <div class="step active"><div class="step-circle">1</div><div class="step-label">Select Doctor</div></div>
        <div class="step"><div class="step-circle">2</div><div class="step-label">Choose Date</div></div>
        <div class="step"><div class="step-circle">3</div><div class="step-label">Select Time</div></div>
        <div class="step"><div class="step-circle">4</div><div class="step-label">Confirm</div></div>
    </div>
    <!-- Step 1: Doctor -->
    <div class="step-content" id="step1">
        <h2 class="section-title"><i class="fas fa-user-md"></i>Select a Doctor</h2>
        <div class="doctor-list">
            <c:choose>
                <c:when test="${not empty doctors}">
                    <c:forEach items="${doctors}" var="doctor">
                        <div class="doctor-card" data-doctor-id="${doctor.eid}" data-doctor-name="Dr. ${doctor.employee.firstName} ${doctor.employee.lastName}">
                            <div class="doctor-avatar">
                                    ${doctor.employee.firstName.substring(0,1)}${doctor.employee.lastName.substring(0,1)}
                            </div>
                            <div class="doctor-info">
                                <div class="doctor-name">Dr. ${doctor.employee.firstName} ${doctor.employee.lastName}</div>
                                <div class="doctor-specialty">${doctor.specialization}</div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>No doctors available at the moment. Please try again later.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="buttons">
            <button class="btn btn-prev" disabled>Previous</button>
            <button class="btn btn-next" onclick="goToStep(2)">Next</button>
        </div>
    </div>
    <!-- Step 2: Date -->
    <div class="step-content hidden" id="step2">
        <h2 class="section-title"><i class="far fa-calendar-alt"></i>Choose Date</h2>
        <div class="date-selector-container">
            <div class="date-selector-row">
                <div class="date-selector-group">
                    <label for="yearSelect">Year</label>
                    <select id="yearSelect" class="date-select">
                        <option value="">Select Year</option>
                    </select>
                </div>
                <div class="date-selector-group">
                    <label for="monthSelect">Month</label>
                    <select id="monthSelect" class="date-select">
                        <option value="">Select Month</option>
                    </select>
                </div>
                <div class="date-selector-group">
                    <label for="daySelect">Day</label>
                    <select id="daySelect" class="date-select">
                        <option value="">Select Day</option>
                    </select>
                </div>
            </div>
            <div class="selected-date-display" id="selectedDateDisplay">
                <i class="far fa-calendar"></i> <span id="displayDateText">Please select a date</span>
            </div>
        </div>
        <div class="buttons">
            <button class="btn btn-prev" onclick="goToStep(1)">Previous</button>
            <button class="btn btn-next" onclick="goToStep(3)">Next</button>
        </div>
    </div>
    <!-- Step 3: Time -->
    <div class="step-content hidden" id="step3">
        <h2 class="section-title"><i class="far fa-clock"></i>Select Time</h2>
        <div class="time-slots" id="timeSlots"></div>
        <div class="buttons">
            <button class="btn btn-prev" onclick="goToStep(2)">Previous</button>
            <button class="btn btn-next" onclick="goToStep(4)">Next</button>
        </div>
    </div>
    <!-- Step 4: Confirm -->
    <div class="step-content hidden" id="step4">
        <h2 class="section-title"><i class="fas fa-check-circle"></i>Confirm Appointment</h2>
        <div class="confirmation-details">
            <div class="detail-row"><div class="detail-label">Doctor:</div><div class="detail-value" id="confirmDoctor">Not selected</div></div>
            <div class="detail-row"><div class="detail-label">Date:</div><div class="detail-value" id="confirmDate">Not selected</div></div>
            <div class="detail-row"><div class="detail-label">Time:</div><div class="detail-value" id="confirmTime">Not selected</div></div>
        </div>
        <div class="buttons">
            <button class="btn btn-prev" onclick="goToStep(3)">Previous</button>
            <button class="btn btn-confirm" onclick="confirmAppointment()">Confirm Appointment</button>
        </div>
    </div>
</div>
<script>
    let selectedDoctor = null;
    let selectedDoctorId = null;
    let selectedDate = null;
    let selectedTime = null;

    function goToStep(step) {
        if (step === 2 && !selectedDoctor) {
            alert("Please select a doctor first.");
            return;
        }
        if (step === 3 && !isValidDateSelected()) {
            alert("Please select a valid date with year, month, and day.");
            return;
        }
        if (step === 4 && !selectedTime) {
            alert("Please select a time.");
            return;
        }

        document.querySelectorAll('.step-content').forEach((el, i) => {
            el.classList.toggle('hidden', i + 1 !== step);
        });
        document.querySelectorAll('.step').forEach((s, i) => {
            s.classList.remove('active', 'completed');
            if (i + 1 < step) s.classList.add('completed');
            if (i + 1 === step) s.classList.add('active');
        });
        document.getElementById('progressBar').style.width = ((step - 1) / 3 * 100) + '%';
        if (step === 4) updateConfirm();
    }

    function isValidDate(d) {
        return d instanceof Date && !isNaN(d.getTime());
    }

    function isValidDateSelected() {
        const year = parseInt(yearSelect.value);
        const month = parseInt(monthSelect.value);
        const day = parseInt(daySelect.value);

        if (!year || !month || !day) {
            return false;
        }

        const dateObj = new Date(year, month - 1, day);
        return isValidDate(dateObj);
    }

    // Doctor selection
    document.querySelectorAll('.doctor-card').forEach(card => {
        card.onclick = () => {
            document.querySelectorAll('.doctor-card').forEach(c => c.classList.remove('selected'));
            card.classList.add('selected');
            selectedDoctor = card.getAttribute('data-doctor-name');
            selectedDoctorId = parseInt(card.getAttribute('data-doctor-id'));
        };
    });

    // Date setup
    const yearSelect = document.getElementById('yearSelect');
    const monthSelect = document.getElementById('monthSelect');
    const daySelect = document.getElementById('daySelect');

    const displayDateText = document.getElementById('displayDateText');
    const today = new Date();
    const monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'];

    function initializeDateSelectors() {
        const currentYear = today.getFullYear();
        for (let i = 0; i < 3; i++) {
            const opt = document.createElement('option');
            opt.value = currentYear + i;
            opt.textContent = currentYear + i;
            yearSelect.appendChild(opt);
        }
        for (let i = 0; i < 12; i++) {
            const opt = document.createElement('option');
            opt.value = i + 1;
            opt.textContent = monthNames[i];
            monthSelect.appendChild(opt);
        }
        monthSelect.value = today.getMonth() + 1;
        yearSelect.value = currentYear;
        populateDays();
    }

    function populateDays() {
        const year = parseInt(yearSelect.value);
        const month = parseInt(monthSelect.value);
        if (!month || !year) return;

        const daysInMonth = new Date(year, month, 0).getDate();
        daySelect.innerHTML = '<option value="">Select Day</option>';

        const todayOnly = new Date(today.getFullYear(), today.getMonth(), today.getDate());
        for (let day = 1; day <= daysInMonth; day++) {
            const dateOption = new Date(year, month - 1, day);
            const opt = document.createElement('option');
            opt.value = day;
            opt.textContent = day;
            if (dateOption < todayOnly) {
                opt.disabled = true;
                opt.textContent += ' (Past)';
            }
            daySelect.appendChild(opt);
        }
        updateSelectedDate();
    }

    function updateSelectedDate() {
        const year = parseInt(yearSelect.value);
        const month = parseInt(monthSelect.value);
        const day = parseInt(daySelect.value);

        if (year && month && day) {
            const newDate = new Date(year, month - 1, day);
            if (isValidDate(newDate)) {
                selectedDate = newDate;
                displayDateText.textContent = `${monthNames[month-1]} ${day}, ${year}`;
            } else {
                selectedDate = null;
                displayDateText.textContent = 'Invalid date';
            }
        } else {
            selectedDate = null;
            displayDateText.textContent = 'Please select a date';
        }
    }

    yearSelect.addEventListener('change', populateDays);
    monthSelect.addEventListener('change', populateDays);
    daySelect.addEventListener('change', updateSelectedDate);

    initializeDateSelectors();

    // Time slots
    function loadTimes() {
        const times = ['9:00 AM','9:30 AM','10:00 AM','10:30 AM','11:00 AM','11:30 AM',
            '1:00 PM','1:30 PM','2:00 PM','2:30 PM','3:00 PM','3:30 PM','4:00 PM'];
        const container = document.getElementById('timeSlots');
        container.innerHTML = '';
        times.forEach(t => {
            const div = document.createElement('div');
            div.className = 'time-slot';
            div.textContent = t;
            div.onclick = () => {
                document.querySelectorAll('.time-slot').forEach(x => x.classList.remove('selected'));
                div.classList.add('selected');
                selectedTime = t;
            };
            container.appendChild(div);
        });
    }
    loadTimes();

    function updateConfirm() {
        document.getElementById('confirmDoctor').textContent = selectedDoctor || 'Not selected';
        if (isValidDate(selectedDate)) {
            document.getElementById('confirmDate').textContent = selectedDate.toDateString();
        } else {
            document.getElementById('confirmDate').textContent = 'Not selected';
        }
        document.getElementById('confirmTime').textContent = selectedTime || 'Not selected';
    }

    function formatDateForBackend(d) {
        if (!isValidDate(d)) {
            console.error('Invalid date object passed to formatDateForBackend:', d);
            return null;
        }
        const y = d.getFullYear();
        const m = String(d.getMonth() + 1).padStart(2, '0');
        const da = String(d.getDate()).padStart(2, '0');
        const formatted = `${y}-${m}-${da}`;
        console.log('Formatted date:', formatted);
        return formatted;
    }

    function confirmAppointment() {
        // Validate doctor selection
        if (!selectedDoctorId) {
            alert("Please select a doctor.");
            goToStep(1);
            return;
        }

        // Validate date components first
        const year = parseInt(yearSelect.value);
        const month = parseInt(monthSelect.value);
        const day = parseInt(daySelect.value);

        console.log('=== APPOINTMENT BOOKING DEBUG ===');
        console.log('Raw values from selectors:');
        console.log('  yearSelect.value:', yearSelect.value);
        console.log('  monthSelect.value:', monthSelect.value);
        console.log('  daySelect.value:', daySelect.value);
        console.log('Parsed integers:');
        console.log('  year:', year, 'type:', typeof year, 'isNaN:', isNaN(year));
        console.log('  month:', month, 'type:', typeof month, 'isNaN:', isNaN(month));
        console.log('  day:', day, 'type:', typeof day, 'isNaN:', isNaN(day));

        if (!year || !month || !day || isNaN(year) || isNaN(month) || isNaN(day)) {
            alert("Please select a complete date (year, month, and day).");
            console.error('Date validation failed: missing or invalid date components');
            goToStep(2);
            return;
        }

        // Recreate selectedDate to ensure it's correct
        selectedDate = new Date(year, month - 1, day);

        if (!isValidDate(selectedDate)) {
            alert("The selected date is invalid. Please select a valid date.");
            console.error('Date object validation failed:', selectedDate);
            goToStep(2);
            return;
        }

        // Validate time selection
        if (!selectedTime) {
            alert("Please select a time.");
            goToStep(3);
            return;
        }

        // Format the date for backend - ensure yyyy-MM-dd format

        const yearStr = String(year);
        const monthStr = String(month).padStart(2, '0');
        const dayStr = String(day).padStart(2, '0');
        const dateStr = yearStr + '-' + monthStr + '-' + dayStr;
        
        console.log('Date formatting:');
        console.log('  yearStr:', yearStr, 'length:', yearStr.length);
        console.log('  monthStr:', monthStr, 'length:', monthStr.length);
        console.log('  dayStr:', dayStr, 'length:', dayStr.length);
        console.log('  dateStr:', dateStr, 'length:', dateStr.length);
        console.log('  dateStr type:', typeof dateStr);

        console.log('Booking appointment with:', {
            doctorId: selectedDoctorId,
            date: dateStr,
            time: selectedTime
        });

        // Validate the formatted date string
        const datePattern = /^\d{4}-\d{2}-\d{2}$/;
        const isValidFormat = datePattern.test(dateStr);
        console.log('Date format validation:');
        console.log('  Pattern test result:', isValidFormat);
        console.log('  Expected length (10):', dateStr.length === 10);
        
        if (!dateStr || dateStr.length !== 10 || !isValidFormat) {
            alert('Error: Date formatting failed. Please try again.');
            console.error('Invalid date format detected!');
            console.error('  dateStr:', dateStr);
            console.error('  length:', dateStr.length);
            console.error('  pattern match:', isValidFormat);
            return;
        }

        console.log('✓ Date validation passed!');

        // Create the payload
        const payload = {
            appointmentDatetime: dateStr,
            doctorId: selectedDoctorId,
            selectedTime: selectedTime
        };

        console.log('Sending payload:', JSON.stringify(payload));
        console.log('=== END DEBUG ===');

        const btn = document.querySelector('.btn-confirm');
        const originalText = btn.textContent;
        btn.disabled = true;
        btn.textContent = 'Booking...';

        fetch('/api/v1/appointment/book', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        })
            .then(async res => {
                const data = await res.json().catch(() => ({}));
                if (res.ok && data.success) {
                    alert(`Appointment booked successfully!\nID: ${data.appointmentId}`);
                    setTimeout(() => window.location.href = '/patient/dashboard', 1500);
                } else {
                    alert('Booking failed: ' + (data.message || 'Unknown error'));
                }
            })
            .catch(err => {
                alert('Network error: ' + err.message);
            })
            .finally(() => {
                btn.disabled = false;
                btn.textContent = originalText;
            });
    }
</script>


</body>
</html>