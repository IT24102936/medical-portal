// src/main/resources/static/js/Admin-dashboard.js
document.addEventListener('DOMContentLoaded', () => {
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = document.getElementById('themeIcon');
    const body = document.body;
    let typesChart, trendsChart;

    // Function to fetch appointment statistics by specialization
    const fetchAppointmentStats = async () => {
        try {
            const response = await fetch('/admin/dashboard/appointment-stats');
            const data = await response.json();
            
            if (data.success) {
                return {
                    labels: data.labels,
                    data: data.data
                };
            } else {
                console.error('Error fetching appointment stats:', data.error);
                // Return default data in case of error
                return {
                    labels: ['Cardiology', 'Dermatology', 'Pediatrics', 'Neurology'],
                    data: [48, 36, 24, 12]
                };
            }
        } catch (error) {
            console.error('Error fetching appointment stats:', error);
            // Return default data in case of error
            return {
                labels: ['Cardiology', 'Dermatology', 'Pediatrics', 'Neurology'],
                data: [48, 36, 24, 12]
            };
        }
    };

    // Function to fetch appointment trends data
    const fetchAppointmentTrends = async () => {
        try {
            const response = await fetch('/admin/appointments/trends');
            const data = await response.json();
            
            if (data.success) {
                return {
                    labels: data.labels,
                    data: data.data
                };
            } else {
                console.error('Error fetching appointment trends:', data.error);
                // Return default data in case of error
                return {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    data: [180, 150, 170, 210, 160, 250]
                };
            }
        } catch (error) {
            console.error('Error fetching appointment trends:', error);
            // Return default data in case of error
            return {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                data: [180, 150, 170, 210, 160, 250]
            };
        }
    };

    const renderCharts = async () => {
        if (typesChart) typesChart.destroy();
        if (trendsChart) trendsChart.destroy();

        const isDarkMode = body.classList.contains('dark-theme');
        const style = getComputedStyle(document.documentElement);
        const textColor = isDarkMode ? style.getPropertyValue('--dark-body-color').trim() : style.getPropertyValue('--bs-text-muted').trim();
        const gridColor = isDarkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.1)';

        // Fetch real appointment data
        const stats = await fetchAppointmentStats();

        // Appointments by Specialization (Donut Chart)
        const typesCtx = document.getElementById('appointmentsByTypeChart').getContext('2d');
        typesChart = new Chart(typesCtx, {
            type: 'doughnut',
            data: {
                labels: stats.labels,
                datasets: [{
                    label: 'Appointments',
                    data: stats.data,
                    backgroundColor: [
                        style.getPropertyValue('--primary-500').trim(),
                        style.getPropertyValue('--primary-400').trim(),
                        style.getPropertyValue('--primary-300').trim(),
                        style.getPropertyValue('--primary-200').trim(),
                        style.getPropertyValue('--primary-600').trim(),
                        style.getPropertyValue('--primary-700').trim()
                    ],
                    borderColor: isDarkMode ? style.getPropertyValue('--dark-card-bg').trim() : style.getPropertyValue('--bs-card-bg').trim(),
                    borderWidth: 4,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: { display: false },
                    tooltip: { enabled: true }
                }
            }
        });

        // Fetch real appointment trends data
        const trends = await fetchAppointmentTrends();

        // Appointment Trends (Area Chart)
        const trendsCtx = document.getElementById('appointmentTrendsChart').getContext('2d');
        const primary400 = style.getPropertyValue('--primary-400').trim();
        const primary200 = style.getPropertyValue('--primary-200').trim();
        const gradient = trendsCtx.createLinearGradient(0, 0, 0, 160);
        gradient.addColorStop(0, `${primary200}66`);
        gradient.addColorStop(1, `${primary200}00`);

        trendsChart = new Chart(trendsCtx, {
            type: 'line',
            data: {
                labels: trends.labels,
                datasets: [{
                    label: 'Appointments',
                    data: trends.data,
                    borderColor: primary400,
                    backgroundColor: gradient,
                    pointBackgroundColor: primary400,
                    pointBorderColor: primary400,
                    pointHoverRadius: 6,
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        border: { display: false },
                        grid: { color: gridColor },
                        ticks: { color: textColor }
                    },
                    x: {
                        border: { display: false },
                        grid: { display: false },
                        ticks: { color: textColor }
                    }
                }
            }
        });
    };

    const applyTheme = (theme) => {
        if (theme === 'dark') {
            body.classList.add('dark-theme');
            themeIcon.textContent = 'light_mode';
        } else {
            body.classList.remove('dark-theme');
            themeIcon.textContent = 'dark_mode';
        }
        renderCharts();
    };

    const savedTheme = localStorage.getItem('theme');
    applyTheme(savedTheme || 'light');

    themeToggle.addEventListener('click', () => {
        let newTheme = body.classList.contains('dark-theme') ? 'light' : 'dark';
        applyTheme(newTheme);
        localStorage.setItem('theme', newTheme);
    });
});