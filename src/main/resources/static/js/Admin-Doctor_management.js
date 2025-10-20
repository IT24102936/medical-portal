document.addEventListener('DOMContentLoaded', () => {
    // Theme toggle functionality
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

    // Search functionality
    const searchInput = document.getElementById('doctorSearchInput');
    const tableBody = document.getElementById('doctorTableBody');
    const tableRows = tableBody.getElementsByTagName('tr');

    searchInput.addEventListener('keyup', () => {
        const query = searchInput.value.toLowerCase();

        for (const row of tableRows) {
            const doctorName = row.cells[0].querySelector('span').textContent.toLowerCase();
            const specialization = row.cells[1].textContent.toLowerCase();

            if (doctorName.includes(query) || specialization.includes(query)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    });

    // Get context-path and CSRF token for requests
    const contextPathMeta = document.querySelector('meta[name="context-path"]');
    const contextPath = contextPathMeta ? contextPathMeta.getAttribute('content') : '';
    const csrfTokenEl = document.querySelector('meta[name="_csrf"]');
    const csrfHeaderEl = document.querySelector('meta[name="_csrf_header"]');
    const csrfToken = csrfTokenEl ? csrfTokenEl.getAttribute('content') : '';
    const csrfHeader = csrfHeaderEl ? csrfHeaderEl.getAttribute('content') : 'X-CSRF-TOKEN';

    // Helper function for AJAX POST
    const sendPostRequest = (url, data = {}, successCallback, errorCallback) => {
        const formData = new URLSearchParams();
        for (const key in data) {
            if (data[key] !== undefined && data[key] !== null) {
                formData.append(key, data[key]);
            }
        }

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                ...(csrfToken ? { [csrfHeader]: csrfToken } : {})
            },
            body: formData.toString()
        })
            .then(response => {
                if (response.ok || response.redirected) {
                    successCallback(response);
                } else {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                if (errorCallback) errorCallback(error);
                alert('Operation failed: ' + error.message);
            });
    };

    // Disable button handler
    document.querySelectorAll('.btn-action-disable').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            const eid = button.getAttribute('data-eid');
            console.log('Disable button clicked for eid:', eid);
            if (confirm('Are you sure you want to disable this doctor?')) {
                const url = `${contextPath}/admin/doctors/disable/${eid}`.replace(/\/{2,}/g, '/');
                sendPostRequest(url, {},
                    (response) => {
                        console.log('Disable successful');
                        location.reload();
                    },
                    (error) => {
                        console.error('Disable error:', error);
                        alert('Failed to disable doctor: ' + error.message);
                    }
                );
            }
        });
    });

    // Enable button handler
    document.querySelectorAll('.btn-action-enable').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            const eid = button.getAttribute('data-eid');
            console.log('Enable button clicked for eid:', eid);
            if (confirm('Are you sure you want to enable this doctor?')) {
                const url = `${contextPath}/admin/doctors/enable/${eid}`.replace(/\/{2,}/g, '/');
                sendPostRequest(url, {},
                    (response) => {
                        console.log('Enable successful');
                        location.reload();
                    },
                    (error) => {
                        console.error('Enable error:', error);
                        alert('Failed to enable doctor: ' + error.message);
                    }
                );
            }
        });
    });

    // Delete button handler
    document.querySelectorAll('.btn-action-delete').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            const eid = button.getAttribute('data-eid');
            const row = button.closest('tr');
            const doctorName = row.cells[0].querySelector('span').textContent.trim();
            
            console.log('Delete button clicked for eid:', eid);
            
            // More descriptive confirmation dialog
            const confirmMessage = `Are you sure you want to permanently delete ${doctorName}?

This action will remove all related records including:
- Patient checkups
- Prescriptions issued
- Lab orders
- Appointments
- Reports

This action cannot be undone.`;
            
            if (confirm(confirmMessage)) {
                // Disable the button to prevent double-clicks
                button.disabled = true;
                button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Deleting...';
                
                const url = `${contextPath}/admin/doctors/delete/${eid}`.replace(/\/{2,}/g, '/');
                sendPostRequest(url, {},
                    (response) => {
                        console.log('Delete successful for eid:', eid, 'Response status:', response.status);
                        // Show success message briefly before reload
                        button.innerHTML = '<span class="material-symbols-outlined text-success">check</span> Deleted';
                        setTimeout(() => {
                            location.reload();
                        }, 1000);
                    },
                    (error) => {
                        console.error('Delete error for eid:', eid, error);
                        // Re-enable button and restore original text
                        button.disabled = false;
                        button.innerHTML = '<span class="material-symbols-outlined">delete</span> Delete';
                        
                        // More detailed error message
                        let errorMessage = 'Failed to delete doctor.';
                        if (error.message.includes('constraint')) {
                            errorMessage += '\n\nThis doctor may have active appointments or other records that prevent deletion.';
                        } else {
                            errorMessage += '\n\nError: ' + error.message;
                        }
                        alert(errorMessage);
                    }
                );
            }
        });
    });

    // Edit button handler - open modal and prefill with AJAX
    const editModalEl = document.getElementById('editDoctorModal');
    const editModal = editModalEl ? new bootstrap.Modal(editModalEl) : null;
    const editForm = document.getElementById('editDoctorForm');

    const openEditModalWithRow = (button) => {
        const eid = button.getAttribute('data-eid');
        const row = button.closest('tr');
        const fullName = row.cells[0].querySelector('span').textContent.replace('Dr. ', '').trim();
        const [firstName, ...rest] = fullName.split(' ');
        const lastName = rest.join(' ');
        const specialization = row.cells[1].textContent.trim();
        const email = row.cells[2].textContent.trim();
        const gender = row.cells[0].querySelector('.profile-image').style.backgroundImage.includes('female-doc.png') ? 'Female' : 'Male';
        const status = row.cells[3].querySelector('.status-badge').textContent.trim();
        const salary = button.getAttribute('data-salary') || '';

        // Set initial avatar
        const avatarImg = document.querySelector('#doctorAvatar img');
        if (avatarImg) {
            const profileImage = row.cells[0].querySelector('.profile-image');
            const backgroundImage = profileImage.style.backgroundImage;
            if (backgroundImage && backgroundImage !== 'none') {
                const urlMatch = backgroundImage.match(/url\(['"]?([^'"]+)['"]?\)/);
                if (urlMatch) {
                    avatarImg.src = urlMatch[1];
                }
            } else {
                const contextPath = window.location.pathname.split('/')[1] || '';
                const defaultImage = gender === 'Female' ?
                    `/${contextPath}/img/female-doc.png` :
                    `/${contextPath}/img/doctor.png`;
                avatarImg.src = defaultImage;
            }
        }

        // Fetch full doctor details
        fetch(`${contextPath}/admin/doctors/${eid}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                ...(csrfToken ? { [csrfHeader]: csrfToken } : {})
            }
        })
            .then(response => {
                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                return response.json();
            })
            .then(data => {
                editForm.elements['eid'].value = eid;
                editForm.elements['firstName'].value = data.firstName || firstName || '';
                editForm.elements['lastName'].value = data.lastName || lastName || '';
                editForm.elements['email'].value = data.email || email || '';
                editForm.elements['gender'].value = data.gender || gender || 'Male';
                editForm.elements['dob'].value = data.dob || '';
                editForm.elements['salary'].value = data.salary || salary || '0';
                editForm.elements['phone'].value = data.phone || ''; // Use fetched phone number
                editForm.elements['nationalId'].value = data.nationalId || '';
                editForm.elements['userName'].value = data.userName || '';
                editForm.elements['status'].value = data.status || status || 'ACTIVE';
                editForm.elements['specialization'].value = data.specialization || specialization || '';

                if (editModal) editModal.show();
            })
            .catch(error => {
                console.error('Error fetching doctor details:', error);
                alert('Failed to load doctor details: ' + error.message);
                if (editModal) editModal.show(); // Show modal with partial data if fetch fails
            });
    };

    document.querySelectorAll('.btn-action-edit').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            openEditModalWithRow(button);
        });
    });

    // Submit edit form via POST
    if (editForm) {
        editForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const eid = editForm.elements['eid'].value;
            const password = editForm.elements['password'] ? editForm.elements['password'].value : '';
            const confirmPassword = editForm.elements['confirmPassword'] ? editForm.elements['confirmPassword'].value : '';

            if ((password && !confirmPassword) || (!password && confirmPassword)) {
                alert('Please fill both password fields or leave both empty.');
                return;
            }
            if (password && confirmPassword && password !== confirmPassword) {
                alert('Passwords do not match.');
                return;
            }

            const payload = {
                firstName: editForm.elements['firstName'].value,
                lastName: editForm.elements['lastName'].value,
                email: editForm.elements['email'].value,
                gender: editForm.elements['gender'].value,
                dob: editForm.elements['dob'].value || '2000-01-01',
                salary: editForm.elements['salary'].value || '0',
                phone: editForm.elements['phone'].value || '',
                nationalId: editForm.elements['nationalId'].value || '',
                userName: editForm.elements['userName'].value || '',
                status: editForm.elements['status'].value || 'ACTIVE',
                specialization: editForm.elements['specialization'].value
            };

            if (password) {
                payload.password = password;
            }

            // Submit form via page reload to handle server-side validation errors
            editForm.action = `${contextPath}/admin/doctors/edit/${eid}`;
            editForm.method = 'POST';
            editForm.submit();
        });
    }

    // Add Doctor Modal and Form Handling
    const addModalEl = document.getElementById('addDoctorModal');
    const addModal = addModalEl ? new bootstrap.Modal(addModalEl) : null;
    const addForm = document.getElementById('addDoctorForm');

    // Submit add form
    if (addForm) {
        addForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            // Get form values
            const password = addForm.elements['password'].value;
            const confirmPassword = addForm.elements['confirmPassword'].value;
            
            // Validate required fields
            const requiredFields = ['firstName', 'lastName', 'email', 'gender', 'userName', 'salary', 'specialization', 'password'];
            let hasErrors = false;
            
            requiredFields.forEach(fieldName => {
                const field = addForm.elements[fieldName];
                if (!field.value.trim()) {
                    field.classList.add('is-invalid');
                    hasErrors = true;
                } else {
                    field.classList.remove('is-invalid');
                }
            });
            
            if (hasErrors) {
                alert('Please fill in all required fields.');
                return;
            }
            
            // Validate password confirmation
            if (password !== confirmPassword) {
                alert('Passwords do not match.');
                addForm.elements['confirmPassword'].classList.add('is-invalid');
                return;
            } else {
                addForm.elements['confirmPassword'].classList.remove('is-invalid');
            }
            
            // Validate email format
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(addForm.elements['email'].value)) {
                alert('Please enter a valid email address.');
                addForm.elements['email'].classList.add('is-invalid');
                return;
            } else {
                addForm.elements['email'].classList.remove('is-invalid');
            }
            
            // Prepare payload
            const payload = {
                firstName: addForm.elements['firstName'].value.trim(),
                lastName: addForm.elements['lastName'].value.trim(),
                email: addForm.elements['email'].value.trim(),
                gender: addForm.elements['gender'].value,
                dob: addForm.elements['dob'].value || '',
                salary: addForm.elements['salary'].value,
                phone: addForm.elements['phone'].value.trim() || '',
                nationalId: addForm.elements['nationalId'].value.trim() || '',
                userName: addForm.elements['userName'].value.trim(),
                specialization: addForm.elements['specialization'].value.trim(),
                password: password,
                confirmPassword: confirmPassword
            };
            
            // Submit form via page reload to handle server-side validation errors
            // Remove the event listener to prevent infinite loop
            e.target.removeEventListener('submit', arguments.callee);
            // Submit the form
            e.target.submit();
        });
    }

    // Reset form when modal is closed
    if (addModalEl) {
        addModalEl.addEventListener('hidden.bs.modal', () => {
            if (addForm) {
                addForm.reset();
                addForm.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));
            }
        });
    }
});