document.addEventListener('DOMContentLoaded', function() {
    // Get CSRF token and context path
    const contextPath = document.querySelector('meta[name="context-path"]')?.getAttribute('content') || '';
    const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');

    // Theme toggle functionality
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = document.getElementById('themeIcon');

    if (themeToggle) {
        themeToggle.addEventListener('click', function() {
            document.body.classList.toggle('dark-theme');
            const isDark = document.body.classList.contains('dark-theme');
            themeIcon.textContent = isDark ? 'light_mode' : 'dark_mode';
        });
    }

    // Search functionality
    const searchInput = document.getElementById('patientSearchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const tableRows = document.querySelectorAll('#patientTableBody tr[data-patient-id]');

            tableRows.forEach(row => {
                const patientName = row.querySelector('td:nth-child(2)')?.textContent.toLowerCase() || '';
                const patientId = row.querySelector('td:nth-child(1)')?.textContent.toLowerCase() || '';
                const patientEmail = row.querySelector('td:nth-child(3)')?.textContent.toLowerCase() || '';

                if (patientName.includes(searchTerm) || patientId.includes(searchTerm) || patientEmail.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }

    // Helper function to send POST requests
    function sendPostRequest(url, data) {
        return fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                [csrfHeader]: csrfToken
            },
            body: new URLSearchParams(data)
        });
    }

    // Event delegation for action buttons
    document.addEventListener('click', (e) => {
        const disableBtn = e.target.closest('.btn-action-disable');
        const enableBtn = e.target.closest('.btn-action-enable');
        const deleteBtn = e.target.closest('.btn-action-delete');
        const editBtn = e.target.closest('.btn-action-edit');

        if (disableBtn) {
            handleDisablePatient(disableBtn);
        } else if (enableBtn) {
            handleEnablePatient(enableBtn);
        } else if (deleteBtn) {
            handleDeletePatient(deleteBtn);
        } else if (editBtn) {
            handleEditPatient(editBtn);
        }
    });

    function handleDisablePatient(button) {
        const patientId = button.getAttribute('data-patient-id');
        const patientRow = button.closest('tr');
        const patientName = patientRow?.querySelector('td:nth-child(2)')?.textContent || 'Unknown';

        if (confirm(`Are you sure you want to disable patient "${patientName}"?`)) {
            button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Disabling...';
            button.disabled = true;

            sendPostRequest(`${contextPath}/admin/patients/disable/${patientId}`, {})
                .then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        throw new Error('Failed to disable patient');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    button.innerHTML = '<span class="material-symbols-outlined">block</span> Disable';
                    button.disabled = false;
                    alert('Failed to disable patient. Please try again.');
                });
        }
    }

    function handleEnablePatient(button) {
        const patientId = button.getAttribute('data-patient-id');
        const patientRow = button.closest('tr');
        const patientName = patientRow?.querySelector('td:nth-child(2)')?.textContent || 'Unknown';

        if (confirm(`Are you sure you want to enable patient "${patientName}"?`)) {
            button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Enabling...';
            button.disabled = true;

            sendPostRequest(`${contextPath}/admin/patients/enable/${patientId}`, {})
                .then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        throw new Error('Failed to enable patient');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    button.innerHTML = '<span class="material-symbols-outlined">check_circle</span> Enable';
                    button.disabled = false;
                    alert('Failed to enable patient. Please try again.');
                });
        }
    }

    function handleDeletePatient(button) {
        const patientId = button.getAttribute('data-patient-id');
        const patientRow = button.closest('tr');
        const patientName = patientRow?.querySelector('td:nth-child(2)')?.textContent || 'Unknown';

        if (confirm(`Are you sure you want to delete patient "${patientName}"? This action cannot be undone.`)) {
            button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Deleting...';
            button.disabled = true;

            sendPostRequest(`${contextPath}/admin/patients/delete/${patientId}`, {})
                .then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        throw new Error('Failed to delete patient');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    button.innerHTML = '<span class="material-symbols-outlined">delete</span> Delete';
                    button.disabled = false;
                    alert('Failed to delete patient. Please try again.');
                });
        }
    }

    function handleEditPatient(button) {
        const patientId = button.getAttribute('data-patient-id');
        const editForm = document.getElementById('editPatientForm');
        editForm.action = `${contextPath}/admin/patients/edit/${patientId}`;

        fetch(`${contextPath}/admin/patients/${patientId}`)
            .then(response => response.json())
            .then(data => {
                document.getElementById('editFirstName').value = data.firstName;
                document.getElementById('editLastName').value = data.lastName;
                document.getElementById('editEmail').value = data.email;
                document.getElementById('editGender').value = data.gender;
                document.getElementById('editDob').value = data.dob;
                document.getElementById('editPhone').value = data.phone;
                document.getElementById('editNationalId').value = data.nationalId;
                document.getElementById('editUserName').value = data.userName;
            })
            .catch(error => {
                console.error('Error fetching patient details:', error);
                alert('Failed to load patient details. Please try again.');
            });
    }

    // Form validation and submission for add
    const addForm = document.getElementById('addPatientForm');
    if (addForm) {
        addForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Client-side validation
            const requiredFields = ['addFirstName', 'addLastName', 'addEmail', 'addUserName', 'addPassword', 'addConfirmPassword'];
            let isValid = true;

            requiredFields.forEach(fieldId => {
                const field = document.getElementById(fieldId);
                if (field) {
                    field.classList.remove('is-invalid');
                }
            });

            requiredFields.forEach(fieldId => {
                const field = document.getElementById(fieldId);
                if (field && !field.value.trim()) {
                    field.classList.add('is-invalid');
                    isValid = false;
                }
            });

            const password = document.getElementById('addPassword').value;
            const confirmPassword = document.getElementById('addConfirmPassword').value;
            if (password !== confirmPassword) {
                document.getElementById('addConfirmPassword').classList.add('is-invalid');
                isValid = false;
            }

            const email = document.getElementById('addEmail').value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (email && !emailRegex.test(email)) {
                document.getElementById('addEmail').classList.add('is-invalid');
                isValid = false;
            }

            if (isValid) {
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Adding Patient...';
                submitBtn.disabled = true;

                // Submit form
                this.submit();
            }
        });
    }

    // Form validation and submission for edit
    const editForm = document.getElementById('editPatientForm');
    if (editForm) {
        editForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Client-side validation
            const requiredFields = ['editFirstName', 'editLastName', 'editEmail', 'editUserName'];
            let isValid = true;

            requiredFields.forEach(fieldId => {
                const field = document.getElementById(fieldId);
                if (field) {
                    field.classList.remove('is-invalid');
                }
            });

            requiredFields.forEach(fieldId => {
                const field = document.getElementById(fieldId);
                if (field && !field.value.trim()) {
                    field.classList.add('is-invalid');
                    isValid = false;
                }
            });

            const email = document.getElementById('editEmail').value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (email && !emailRegex.test(email)) {
                document.getElementById('editEmail').classList.add('is-invalid');
                isValid = false;
            }

            if (isValid) {
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Updating Patient...';
                submitBtn.disabled = true;

                // Submit form
                this.submit();
            }
        });
    }

    // Reset forms when modals are closed
    const addModal = document.getElementById('addPatientModal');
    const editModal = document.getElementById('editPatientModal');

    if (addModal) {
        addModal.addEventListener('hidden.bs.modal', function() {
            const form = document.getElementById('addPatientForm');
            if (form) {
                form.reset();
                form.querySelectorAll('.is-invalid').forEach(field => {
                    field.classList.remove('is-invalid');
                });
                const submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.innerHTML = 'Add Patient';
                    submitBtn.disabled = false;
                }
            }
        });
    }

    if (editModal) {
        editModal.addEventListener('hidden.bs.modal', function() {
            const form = document.getElementById('editPatientForm');
            if (form) {
                form.reset();
                form.querySelectorAll('.is-invalid').forEach(field => {
                    field.classList.remove('is-invalid');
                });
                const submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.innerHTML = 'Update Patient';
                    submitBtn.disabled = false;
                }
            }
        });
    }
});