document.addEventListener('DOMContentLoaded', () => {
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = document.getElementById('themeIcon');
    const body = document.body;

    const applyTheme = (theme) => {
        if (theme === 'dark') {
            body.classList.add('dark-theme');
            themeIcon.textContent = 'light_mode';
        } else {
            body.classList.remove('dark-theme');
            themeIcon.textContent = 'dark_mode';
        }
    };

    const savedTheme = localStorage.getItem('theme');
    applyTheme(savedTheme || 'light');

    themeToggle.addEventListener('click', () => {
        let currentTheme = body.classList.contains('dark-theme') ? 'dark' : 'light';
        let newTheme = currentTheme === 'light' ? 'dark' : 'light';
        applyTheme(newTheme);
        localStorage.setItem('theme', newTheme);
    });

    // Appointment Filter Logic
    const doctorFilter = document.getElementById('doctor-name-filter');
    const patientFilter = document.getElementById('patient-name-filter');
    const startDateFilter = document.getElementById('start-date-filter');
    const endDateFilter = document.getElementById('end-date-filter');
    const clearButton = document.getElementById('clearFilters');
    const upcomingTableBody = document.getElementById('upcomingAppointmentsBody');
    const tableRows = upcomingTableBody.getElementsByTagName('tr');

    const filterAppointments = () => {
        const doctorQuery = doctorFilter.value.toLowerCase();
        const patientQuery = patientFilter.value.toLowerCase();
        const startDate = startDateFilter.value ? new Date(startDateFilter.value) : null;
        const endDate = endDateFilter.value ? new Date(endDateFilter.value) : null;

        // Adjust for timezone offset by setting time to midnight
        if (startDate) startDate.setUTCHours(0, 0, 0, 0);
        if (endDate) endDate.setUTCHours(0, 0, 0, 0);

        for (const row of tableRows) {
            const doctorName = row.cells[0].textContent.toLowerCase();
            const patientName = row.cells[2].textContent.toLowerCase();
            const appointmentDateStr = row.cells[3].textContent;
            const appointmentDate = new Date(appointmentDateStr);
            appointmentDate.setUTCHours(0, 0, 0, 0);

            const doctorMatch = doctorName.includes(doctorQuery);
            const patientMatch = patientName.includes(patientQuery);
            const startDateMatch = !startDate || appointmentDate >= startDate;
            const endDateMatch = !endDate || appointmentDate <= endDate;

            if (doctorMatch && patientMatch && startDateMatch && endDateMatch) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    };

    doctorFilter.addEventListener('keyup', filterAppointments);
    patientFilter.addEventListener('keyup', filterAppointments);
    startDateFilter.addEventListener('change', filterAppointments);
    endDateFilter.addEventListener('change', filterAppointments);

    clearButton.addEventListener('click', () => {
        doctorFilter.value = '';
        patientFilter.value = '';
        startDateFilter.value = '';
        endDateFilter.value = '';
        filterAppointments();
    });

    // Get CSRF token and context path
    const contextPath = document.querySelector('meta[name="context-path"]')?.getAttribute('content') || '';
    const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');

    // Helper function to send POST requests
    function sendPostRequest(url, data) {
        const headers = {
            'Content-Type': 'application/x-www-form-urlencoded'
        };
        
        // Only add CSRF header if both token and header name are available
        if (csrfToken && csrfHeader) {
            headers[csrfHeader] = csrfToken;
        }
        
        return fetch(url, {
            method: 'POST',
            headers: headers,
            body: new URLSearchParams(data)
        });
    }

    // Event delegation for appointment action buttons
    document.addEventListener('click', (e) => {
        const cancelBtn = e.target.closest('.btn-cancel-appointment');
        const deleteBtn = e.target.closest('.btn-delete-appointment');

        if (cancelBtn) {
            handleCancelAppointment(cancelBtn);
        } else if (deleteBtn) {
            handleDeleteAppointment(deleteBtn);
        }
    });

    function handleCancelAppointment(button) {
        const appointmentId = button.getAttribute('data-appointment-id');
        const appointmentRow = button.closest('tr');
        const doctorName = appointmentRow?.querySelector('td:nth-child(1)')?.textContent || 'Unknown';
        const patientName = appointmentRow?.querySelector('td:nth-child(3)')?.textContent || 'Unknown';

        if (confirm(`Are you sure you want to cancel the appointment between Dr. ${doctorName} and ${patientName}?`)) {
            button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Canceling...';
            button.disabled = true;

            sendPostRequest(`${contextPath}/admin/appointments/cancel/${appointmentId}`, {})
                .then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        throw new Error('Failed to cancel appointment');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    button.innerHTML = 'Cancel';
                    button.disabled = false;
                    alert('Failed to cancel appointment. Please try again.');
                });
        }
    }

    function handleDeleteAppointment(button) {
        const appointmentId = button.getAttribute('data-appointment-id');
        const appointmentRow = button.closest('tr');
        const doctorName = appointmentRow?.querySelector('td:nth-child(1)')?.textContent || 'Unknown';
        const patientName = appointmentRow?.querySelector('td:nth-child(3)')?.textContent || 'Unknown';

        if (confirm(`Are you sure you want to permanently delete the appointment between Dr. ${doctorName} and ${patientName}? This action cannot be undone.`)) {
            button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Deleting...';
            button.disabled = true;

            sendPostRequest(`${contextPath}/admin/appointments/delete/${appointmentId}`, {})
                .then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        throw new Error('Failed to delete appointment');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    button.innerHTML = 'Delete';
                    button.disabled = false;
                    alert('Failed to delete appointment. Please try again.');
                });
        }
    }
});