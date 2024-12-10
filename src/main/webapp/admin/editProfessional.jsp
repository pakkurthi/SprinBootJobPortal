<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Professional</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header">
                        <h2 class="mb-0">Edit Professional</h2>
                    </div>
                    <div class="card-body">
                        <form action="/admin/professionals/edit/${professional.id}" method="post">
                            <!-- User Properties -->
                            <div class="mb-3">
                                <label for="name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="${professional.name}" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${professional.email}" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" value="${professional.password}" required>
                            </div>
                            <div class="mb-3">
                                <label for="phoneNumber" class="form-label">Phone Number</label>
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${professional.phoneNumber}" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" class="form-control" id="address" name="address" value="${professional.address}" required>
                            </div>
                            <div class="mb-3">
                                <label for="city" class="form-label">City</label>
                                <input type="text" class="form-control" id="city" name="city" value="${professional.city}" required>
                            </div>
                            <div class="mb-3">
                                <label for="state" class="form-label">State</label>
                                <input type="text" class="form-control" id="state" name="state" value="${professional.state}" required>
                            </div>
                            <div class="mb-3">
                                <label for="country" class="form-label">Country</label>
                                <input type="text" class="form-control" id="country" name="country" value="${professional.country}" required>
                            </div>

                            <!-- User Role (from the enum) -->
                            <div class="mb-3">
                                <label for="role" class="form-label">Role</label>
                                <select class="form-control" id="role" name="role" required>
                                    <option value="USER" ${professional.role == 'USER' ? 'selected' : ''}>User</option>
                                    <option value="ADMIN" ${professional.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                </select>
                            </div>

                            <!-- Verification Status (specific to Professional) -->
                            <div class="mb-3">
                                <label for="verified" class="form-label">Verification Status</label>
                                <select class="form-control" id="verified" name="verified" required>
                                    <option value="true" ${professional.verified ? 'selected' : ''}>Verified</option>
                                    <option value="false" ${!professional.verified ? 'selected' : ''}>Not Verified</option>
                                </select>
                            </div>

                            <!-- Created At (Read-only, as this is a generated field) -->
                            <div class="mb-3">
                                <label for="createdAt" class="form-label">Created At</label>
                                <input type="text" class="form-control" id="createdAt" name="createdAt" value="${professional.createdAt}" readonly>
                            </div>

                            <!-- Last Login (Read-only, as this should not be updated) -->
                            <div class="mb-3">
                                <label for="lastLogin" class="form-label">Last Login</label>
                                <input type="text" class="form-control" id="lastLogin" name="lastLogin" value="${professional.lastLogin}" readonly>
                            </div>

                            <!-- Active Status -->
                            

                            <div class="d-flex justify-content-between">
                                <button type="submit" class="btn btn-primary">Update Professional</button>
                                <a href="/admin/professionals" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
