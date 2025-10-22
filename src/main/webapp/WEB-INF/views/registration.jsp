
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Medisphere</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; height: 100vh; overflow: hidden; }
        .container-fluid, .row { height: 100%; }
        .branding-section { background: linear-gradient(135deg, #0a193a 0%, #033c5a 100%); color: #fff; display: flex; justify-content: center; align-items: center; text-align: center; padding: 40px; height: 100vh; }
        .form-section { display: flex; justify-content: center; align-items: center; padding: 40px; background-color: #fff; height: 100vh; overflow-y: auto; }
        .form-wrapper { max-width: 700px; width: 100%; }
        .logo { display: block; margin: 0 auto; width: 100px; height: 100px;}
        .form-control, .form-select { border-radius: 8px; padding: 12px 15px; }
        .btn-register { background: linear-gradient(90deg, #0d6efd 0%, #0558d1 100%); border: none; padding: 12px; font-weight: 500; border-radius: 8px; }
        @media (max-width: 991.98px) { .branding-section { display: none; } }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Branding -->
        <div class="col-lg-5 branding-section">
            <div>
                <h1 class="display-4">Join Medisphere</h1>
                <p class="lead">Pioneering the Future of Digital Healthcare</p>
            </div>
        </div>

        <!-- Form -->
        <div class="col-lg-7 form-section">
            <div class="form-wrapper">
                <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" class="logo mb-4">
                <h2 class="mb-4">Create Your Employee Account</h2>

                <!-- Flash / Error messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <!-- Spring Form -->
                <form:form id="registrationForm" action="${pageContext.request.contextPath}/register"
                           method="post" modelAttribute="doctor">

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">First Name</label>
                            <form:input path="firstName" cssClass="form-control"/>
                            <form:errors path="firstName" cssClass="text-danger"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Last Name</label>
                            <form:input path="lastName" cssClass="form-control"/>
                            <form:errors path="lastName" cssClass="text-danger"/>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Username</label>
                            <form:input path="username" cssClass="form-control" required="true"/>
                            <form:errors path="username" cssClass="text-danger"/>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email</label>
                            <form:input path="email" cssClass="form-control"/>
                            <form:errors path="email" cssClass="text-danger"/>
                        </div>
                         <%--
                        <div class="col-md-6 mb-3">
                                <label class="form-label">Phone</label>
                                <form:input path="phoneNumbers" cssClass="form-control"/>
                        </div>
                        --%>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">National ID</label>
                            <form:input path="nationalId" cssClass="form-control"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Date of Birth</label>
                            <form:input path="dateOfBirth" type="date" cssClass="form-control"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Gender</label>
                            <form:select path="gender" cssClass="form-select">
                                <form:option value="">Select...</form:option>
                                <form:option value="Male">Male</form:option>
                                <form:option value="Female">Female</form:option>
                                <form:option value="Other">Other</form:option>
                            </form:select>
                        </div>
                        <div class="col-12 mb-3">
                            <label class="form-label">Employee Type</label>
                            <form:select path="employeeType" cssClass="form-select">
                                <form:option value="">Select role...</form:option>
                                <form:option value="Doctor">Doctor</form:option>
                                <form:option value="Lab Assistant">Lab Assistant</form:option>
                                <form:option value="Pharmacist">Pharmacist</form:option>
                                <form:option value="Finance Manager">Finance Manager</form:option>
                            </form:select>
                        </div>
                        <div class="col-12 mb-3">
                            <label class="form-label">Specialization</label>
                            <form:input path="specialization" cssClass="form-control"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Password</label>
                            <form:password path="password" cssClass="form-control"/>
                            <form:errors path="password" cssClass="text-danger"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required/>
                        </div>
                    </div>

                    <div class="d-grid mt-3">
                        <button type="submit" class="btn btn-register text-white">Create Account</button>
                    </div>
                </form:form>

                <p class="mt-4 text-center text-muted">
                    Already have an account? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Sign In</a>
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('registrationForm').addEventListener('submit', function(event) {
        const pw = document.getElementById('password');
        const cpw = document.getElementById('confirmPassword');
        if (pw && cpw && pw.value !== cpw.value) {
            event.preventDefault();
            alert("Passwords do not match!");
            cpw.focus();
            cpw.classList.add('is-invalid');
        }
    });
</script>
</body>
</html>
<%--
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Medisphere</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; height: 100vh; overflow: hidden; }
        .container-fluid, .row { height: 100%; }
        .branding-section { background: linear-gradient(135deg, #0a193a 0%, #033c5a 100%); color: #fff; display: flex; justify-content: center; align-items: center; text-align: center; padding: 40px; height: 100vh; }
        .form-section { display: flex; justify-content: center; align-items: center; padding: 40px; background-color: #fff; height: 100vh; overflow-y: auto; }
        .form-wrapper { max-width: 700px; width: 100%; }
        .logo { display: block; margin: 0 auto; width: 100px; height: 100px;}
        .form-control, .form-select { border-radius: 8px; padding: 12px 15px; }
        .btn-register { background: linear-gradient(90deg, #0d6efd 0%, #0558d1 100%); border: none; padding: 12px; font-weight: 500; border-radius: 8px; }
        @media (max-width: 991.98px) { .branding-section { display: none; } }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Branding -->
        <div class="col-lg-5 branding-section">
            <div>
                <h1 class="display-4">Join Medisphere</h1>
                <p class="lead">Pioneering the Future of Digital Healthcare</p>
            </div>
        </div>

        <!-- Form -->
        <div class="col-lg-7 form-section">
            <div class="form-wrapper">
                <img src="https://i.ibb.co/7THM3P4/trans.png" alt="Medisphere Logo" class="logo mb-4">
                <h2 class="mb-4">Create Your Employee Account</h2>

                <!-- Flash / Error messages -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <!-- Spring Form -->
                <form:form id="registrationForm" action="${pageContext.request.contextPath}/register"
                           method="post" modelAttribute="doctor">

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">First Name</label>
                            <form:input path="firstName" cssClass="form-control"/>
                            <form:errors path="firstName" cssClass="text-danger"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Last Name</label>
                            <form:input path="lastName" cssClass="form-control"/>
                            <form:errors path="lastName" cssClass="text-danger"/>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Username</label>
                            <form:input path="username" cssClass="form-control" required="true"/>
                            <form:errors path="username" cssClass="text-danger"/>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email</label>
                            <form:input path="email" cssClass="form-control"/>
                            <form:errors path="email" cssClass="text-danger"/>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" name="phoneNumber"/>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">National ID</label>
                            <form:input path="nationalId" cssClass="form-control"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Date of Birth</label>
                            <form:input path="dateOfBirth" type="date" cssClass="form-control"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Gender</label>
                            <form:select path="gender" cssClass="form-select">
                                <form:option value="">Select...</form:option>
                                <form:option value="Male">Male</form:option>
                                <form:option value="Female">Female</form:option>
                                <form:option value="Other">Other</form:option>
                            </form:select>
                        </div>
                        <div class="col-12 mb-3">
                            <label class="form-label">Employee Type</label>
                            <form:select path="employeeType" cssClass="form-select">
                                <form:option value="">Select role...</form:option>
                                <form:option value="Doctor">Doctor</form:option>
                                <form:option value="Lab Assistant">Lab Assistant</form:option>
                                <form:option value="Pharmacist">Pharmacist</form:option>
                                <form:option value="Finance Manager">Finance Manager</form:option>
                            </form:select>
                        </div>
                        <div class="col-12 mb-3">
                            <label class="form-label">Specialization</label>
                            <form:input path="specialization" cssClass="form-control"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Password</label>
                            <form:password path="password" cssClass="form-control"/>
                            <form:errors path="password" cssClass="text-danger"/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required/>
                        </div>
                    </div>

                    <div class="d-grid mt-3">
                        <button type="submit" class="btn btn-register text-white">Create Account</button>
                    </div>
                </form:form>

                <p class="mt-4 text-center text-muted">
                    Already have an account? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Sign In</a>
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('registrationForm').addEventListener('submit', function(event) {
        const pw = document.getElementById('password');
        const cpw = document.getElementById('confirmPassword');
        if (pw && cpw && pw.value !== cpw.value) {
            event.preventDefault();
            alert("Passwords do not match!");
            cpw.focus();
            cpw.classList.add('is-invalid');
        }
    });
</script>
</body>
</html>
--%>