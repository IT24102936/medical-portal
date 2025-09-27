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
});