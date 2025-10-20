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
    const searchInput = document.getElementById('employeeSearchInput');
    const tableBody = document.getElementById('employeeTableBody');
    const tableRows = tableBody.getElementsByTagName('tr');

    searchInput.addEventListener('keyup', () => {
        const query = searchInput.value.toLowerCase();

        for (const row of tableRows) {
            const employeeId = row.cells[0].textContent.toLowerCase();
            const employeeName = row.cells[1].textContent.toLowerCase();
            const role = row.cells[2].textContent.toLowerCase();
            const email = row.cells[3].textContent.toLowerCase();

            if (employeeId.includes(query) || employeeName.includes(query) || 
                role.includes(query) || email.includes(query)) {
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

    // Disable button handler using event delegation
    document.addEventListener('click', (e) => {
        if (e.target.closest('.btn-action-disable')) {
            e.preventDefault();
            const button = e.target.closest('.btn-action-disable');
            const eid = button.getAttribute('data-eid');
            console.log('Disable button clicked for eid:', eid);
            if (confirm('Are you sure you want to disable this employee?')) {
                const url = `${contextPath}/admin/employees/disable/${eid}`.replace(/\/{2,}/g, '/');
                sendPostRequest(url, {},
                    (response) => {
                        console.log('Disable successful');
                        location.reload();
                    },
                    (error) => {
                        console.error('Disable error:', error);
                        alert('Failed to disable employee: ' + error.message);
                    }
                );
            }
        }
    });

    // Enable button handler using event delegation
    document.addEventListener('click', (e) => {
        if (e.target.closest('.btn-action-enable')) {
            e.preventDefault();
            const button = e.target.closest('.btn-action-enable');
            const eid = button.getAttribute('data-eid');
            console.log('Enable button clicked for eid:', eid);
            if (confirm('Are you sure you want to enable this employee?')) {
                const url = `${contextPath}/admin/employees/enable/${eid}`.replace(/\/{2,}/g, '/');
                sendPostRequest(url, {},
                    (response) => {
                        console.log('Enable successful');
                        location.reload();
                    },
                    (error) => {
                        console.error('Enable error:', error);
                        alert('Failed to enable employee: ' + error.message);
                    }
                );
            }
        }
    });

    // Delete button handler using event delegation
    document.addEventListener('click', (e) => {
        if (e.target.closest('.btn-action-delete')) {
            e.preventDefault();
            const button = e.target.closest('.btn-action-delete');
            const eid = button.getAttribute('data-eid');
            const row = button.closest('tr');
            const employeeName = row.cells[1].textContent.trim();
            
            console.log('Delete button clicked for eid:', eid);
            
            // More descriptive confirmation dialog
            const confirmMessage = `Are you sure you want to permanently delete ${employeeName}?\n\nThis action will remove all related records and cannot be undone.`;
            
            if (confirm(confirmMessage)) {
                // Disable the button to prevent double-clicks
                button.disabled = true;
                button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Deleting...';
                
                const url = `${contextPath}/admin/employees/delete/${eid}`.replace(/\/{2,}/g, '/');
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
                        let errorMessage = 'Failed to delete employee.';
                        if (error.message.includes('constraint')) {
                            errorMessage += '\n\nThis employee may have active records that prevent deletion.';
                        } else {
                            errorMessage += '\n\nError: ' + error.message;
                        }
                        alert(errorMessage);
                    }
                );
            }
        }
    });

    // Edit button handler - open modal and prefill with AJAX
    const editModalEl = document.getElementById('editEmployeeModal');
    const editModal = editModalEl ? new bootstrap.Modal(editModalEl) : null;
    const editForm = document.getElementById('editEmployeeForm');

    const openEditModalWithRow = (button) => {
        const eid = button.getAttribute('data-eid');
        const row = button.closest('tr');
        const fullName = row.cells[1].textContent.trim();
        const [firstName, ...rest] = fullName.split(' ');
        const lastName = rest.join(' ');
        const role = row.cells[2].textContent.trim();
        const email = row.cells[3].textContent.trim();
        const status = row.cells[4].querySelector('.badge').textContent.trim();
        const salary = button.getAttribute('data-salary') || '';

        // Set initial avatar based on gender
        const avatarImg = document.querySelector('#employeeAvatar img');
        if (avatarImg) {
            const contextPath = window.location.pathname.split('/')[1] || '';
            const gender = row.cells[1].textContent.includes('Ms.') || row.cells[1].textContent.includes('Mrs.') ? 'Female' : 'Male';
            const defaultImage = gender === 'Female' ? 
                `/${contextPath}/img/female-employee.png` : 
                `/${contextPath}/img/employee.png`;
            avatarImg.src = defaultImage;
        }

        // Fetch full employee details
        fetch(`${contextPath}/admin/employees/${eid}`, {
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
                editForm.elements['gender'].value = data.gender || 'Male';
                editForm.elements['dob'].value = data.dob || '';
                editForm.elements['salary'].value = data.salary || salary || '0';
                editForm.elements['phone'].value = data.phone || '';
                editForm.elements['nationalId'].value = data.nationalId || '';
                editForm.elements['userName'].value = data.userName || '';
                editForm.elements['status'].value = data.status || status || 'ACTIVE';
                editForm.elements['role'].value = data.role || role || 'Receptionist';

                // Update avatar based on fetched gender data
                if (avatarImg) {
                    const contextPath = window.location.pathname.split('/')[1] || '';
                    const employeeGender = data.gender || 'Male';
                    const avatarImage = employeeGender === 'Female' ? 
                        `/${contextPath}/img/female-employee.png` : 
                        `/${contextPath}/img/employee.png`;
                    avatarImg.src = avatarImage;
                }

                if (editModal) editModal.show();
            })
            .catch(error => {
                console.error('Error fetching employee details:', error);
                alert('Failed to load employee details: ' + error.message);
                if (editModal) editModal.show(); // Show modal with partial data if fetch fails
            });
    };

    // Edit button handler using event delegation
    document.addEventListener('click', (e) => {
        if (e.target.closest('.btn-action-edit')) {
            e.preventDefault();
            const button = e.target.closest('.btn-action-edit');
            openEditModalWithRow(button);
        }
    });

    // Submit edit form via POST
    if (editForm) {
        editForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const eid = editForm.elements['eid'].value;

            const payload = {
                firstName: editForm.elements['firstName'].value,
                lastName: editForm.elements['lastName'].value,
                email: editForm.elements['email'].value,
                gender: editForm.elements['gender'].value,
                dob: editForm.elements['dob'].value || '',
                salary: editForm.elements['salary'].value || '0',
                phone: editForm.elements['phone'].value || '',
                nationalId: editForm.elements['nationalId'].value || '',
                userName: editForm.elements['userName'].value || '',
                status: editForm.elements['status'].value || 'ACTIVE',
                role: editForm.elements['role'].value,
                password: editForm.elements['password'].value || ''
            };

            // Submit form via page reload to handle server-side validation errors
            editForm.action = `${contextPath}/admin/employees/edit/${eid}`;
            editForm.method = 'POST';
            editForm.submit();
        });
    }

    // Dynamic avatar update when gender changes in edit form
    const editGenderSelect = document.getElementById('gender');
    if (editGenderSelect) {
        editGenderSelect.addEventListener('change', (e) => {
            const avatarImg = document.querySelector('#employeeAvatar img');
            if (avatarImg) {
                const contextPath = window.location.pathname.split('/')[1] || '';
                const selectedGender = e.target.value;
                const avatarImage = selectedGender === 'Female' ? 
                    `/${contextPath}/img/female-employee.png` : 
                    `/${contextPath}/img/employee.png`;
                avatarImg.src = avatarImage;
            }
        });
    }

    // Add Employee Modal and Form Handling
    const addModalEl = document.getElementById('addEmployeeModal');
    const addModal = addModalEl ? new bootstrap.Modal(addModalEl) : null;
    const addForm = document.getElementById('addEmployeeForm');

    // Dynamic avatar update when gender changes in add form
    const addGenderSelect = document.getElementById('addGender');
    if (addGenderSelect) {
        addGenderSelect.addEventListener('change', (e) => {
            const avatarImg = document.querySelector('#addEmployeeModal .employee-avatar-large img');
            if (avatarImg) {
                const contextPath = window.location.pathname.split('/')[1] || '';
                const selectedGender = e.target.value;
                const avatarImage = selectedGender === 'Female' ? 
                    `/${contextPath}/img/female-employee.png` : 
                    `/${contextPath}/img/employee.png`;
                avatarImg.src = avatarImage;
            }
        });
    }

    // Submit add form
    if (addForm) {
        addForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            // Get form values
            const password = addForm.elements['password'].value;
            const confirmPassword = addForm.elements['confirmPassword'].value;
            
            // Validate required fields
            const requiredFields = ['firstName', 'lastName', 'email', 'gender', 'userName', 'salary', 'role', 'password'];
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
                role: addForm.elements['role'].value,
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