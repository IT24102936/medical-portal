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

    // Logic for report option card active state
    const reportOptions = document.querySelectorAll('.report-option-card');
    reportOptions.forEach(option => {
        option.addEventListener('click', () => {
            reportOptions.forEach(o => o.classList.remove('active'));
            option.classList.add('active');
        });
    });
});