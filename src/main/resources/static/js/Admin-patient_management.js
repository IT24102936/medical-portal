document.addEventListener('DOMContentLoaded', function() {
    // Get context path
    const contextPath = document.querySelector('meta[name="context-path"]')?.getAttribute('content') || '';

    // Handle disable button
    document.addEventListener('click', function(e) {
        if (e.target.closest('.btn-action-disable')) {
            const button = e.target.closest('.btn-action-disable');
            const patientId = button.getAttribute('data-patient-id');
            
            if (confirm('Are you sure you want to disable this patient?')) {
                // Create a form dynamically to submit the request
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = `${contextPath}/admin/patients/disable/${patientId}`;
                
                // Add CSRF token
                const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
                const csrfParameter = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');
                if (csrfToken && csrfParameter) {
                    const csrfInput = document.createElement('input');
                    csrfInput.type = 'hidden';
                    csrfInput.name = '_csrf';
                    csrfInput.value = csrfToken;
                    form.appendChild(csrfInput);
                }
                
                // Submit the form
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Handle enable button
        if (e.target.closest('.btn-action-enable')) {
            const button = e.target.closest('.btn-action-enable');
            const patientId = button.getAttribute('data-patient-id');
            
            if (confirm('Are you sure you want to enable this patient?')) {
                // Create a form dynamically to submit the request
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = `${contextPath}/admin/patients/enable/${patientId}`;
                
                // Add CSRF token
                const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
                const csrfParameter = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');
                if (csrfToken && csrfParameter) {
                    const csrfInput = document.createElement('input');
                    csrfInput.type = 'hidden';
                    csrfInput.name = '_csrf';
                    csrfInput.value = csrfToken;
                    form.appendChild(csrfInput);
                }
                
                // Submit the form
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Handle delete button
        if (e.target.closest('.btn-action-delete')) {
            const button = e.target.closest('.btn-action-delete');
            const patientId = button.getAttribute('data-patient-id');
            
            if (confirm('Are you sure you want to delete this patient? This action cannot be undone.')) {
                // Create a form dynamically to submit the request
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = `${contextPath}/admin/patients/delete/${patientId}`;
                
                // Add CSRF token
                const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
                const csrfParameter = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');
                if (csrfToken && csrfParameter) {
                    const csrfInput = document.createElement('input');
                    csrfInput.type = 'hidden';
                    csrfInput.name = '_csrf';
                    csrfInput.value = csrfToken;
                    form.appendChild(csrfInput);
                }
                
                // Submit the form
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Handle edit button - populate the form
        if (e.target.closest('.btn-action-edit')) {
            const button = e.target.closest('.btn-action-edit');
            const patientId = button.getAttribute('data-patient-id');
            
            // Fetch patient data
            fetch(`${contextPath}/admin/patients/${patientId}`)
                .then(response => response.json())
                .then(data => {
                    // Populate the edit form
                    document.getElementById('editFirstName').value = data.firstName || '';
                    document.getElementById('editLastName').value = data.lastName || '';
                    document.getElementById('editEmail').value = data.email || '';
                    document.getElementById('editGender').value = data.gender || 'Male';
                    document.getElementById('editDob').value = data.dob || '';
                    document.getElementById('editPhone').value = data.phone || '';
                    document.getElementById('editNationalId').value = data.nationalId || '';
                    
                    // Set form action
                    const editForm = document.getElementById('editPatientForm');
                    editForm.action = `${contextPath}/admin/patients/edit/${patientId}`;
                    
                    // Update avatar
                    const editAvatarImg = document.getElementById('editAvatarImg');
                    if (editAvatarImg) {
                        if (data.gender === 'Female') {
                            editAvatarImg.src = 'https://via.placeholder.com/120x120/f8f9fa/6c757d?text=👩';
                        } else {
                            editAvatarImg.src = 'https://via.placeholder.com/120x120/f8f9fa/6c757d?text=👨';
                        }
                    }
                })
                .catch(error => {
                    console.error('Error fetching patient data:', error);
                    alert('Error loading patient data');
                });
        }
    });
    
    // Handle gender change for avatar updates
    document.getElementById('addGender')?.addEventListener('change', function() {
        const avatarImg = document.getElementById('addAvatarImg');
        if (avatarImg) {
            if (this.value === 'Female') {
                avatarImg.src = 'https://via.placeholder.com/120x120/f8f9fa/6c757d?text=👩';
            } else {
                avatarImg.src = 'https://via.placeholder.com/120x120/f8f9fa/6c757d?text=👨';
            }
        }
    });
    
    document.getElementById('editGender')?.addEventListener('change', function() {
        const avatarImg = document.getElementById('editAvatarImg');
        if (avatarImg) {
            if (this.value === 'Female') {
                avatarImg.src = 'https://via.placeholder.com/120x120/f8f9fa/6c757d?text=👩';
            } else {
                avatarImg.src = 'https://via.placeholder.com/120x120/f8f9fa/6c757d?text=👨';
            }
        }
    });
    
    // Reset avatar when add modal is closed
    document.getElementById('addPatientModal')?.addEventListener('hidden.bs.modal', function() {
        const avatarImg = document.getElementById('addAvatarImg');
        if (avatarImg) {
            avatarImg.src = 'https://via.placeholder.com/120x120/f8f9fa/6c757d?text=👤';
        }
        document.getElementById('addPatientForm')?.reset();
    });
});