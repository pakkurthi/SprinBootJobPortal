<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Professional</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-8">Edit Profile</h1>

        <form action="/users/profile/update" method="post" class="bg-white p-6 rounded-lg shadow-md">
            
            <!-- Name Field -->
            <div class="mb-4">
                <label for="name" class="block text-sm font-semibold">Name</label>
                <input type="text" id="name" name="name" value="${user.name}" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md" required>
            </div>

            <!-- Email Field -->
            <div class="mb-4">
                <label for="email" class="block text-sm font-semibold">Email</label>
                <input type="email" id="email" name="email" value="${user.email}" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md" required>
            </div>

            <!-- Phone Number Field -->
            <div class="mb-4">
                <label for="phoneNumber" class="block text-sm font-semibold">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md">
            </div>

            <!-- Address Field -->
            <div class="mb-4">
                <label for="address" class="block text-sm font-semibold">Address</label>
                <input type="text" id="address" name="address" value="${user.address}" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md">
            </div>

            <!-- City Field -->
            <div class="mb-4">
                <label for="city" class="block text-sm font-semibold">City</label>
                <input type="text" id="city" name="city" value="${user.city}" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md">
            </div>

            <!-- State Field -->
            <div class="mb-4">
                <label for="state" class="block text-sm font-semibold">State</label>
                <input type="text" id="state" name="state" value="${user.state}" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md">
            </div>

            <!-- Country Field -->
            <div class="mb-4">
                <label for="country" class="block text-sm font-semibold">Country</label>
                <input type="text" id="country" name="country" value="${user.country}" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md">
            </div>

            <!-- Password Field -->
            <div class="mb-4">
                <label for="password" class="block text-sm font-semibold">Password</label>
                <input type="password" id="password" name="password" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md">
            </div>

            <!-- User Role (from the enum) -->
            <div class="mb-4">
                <label for="role" class="block text-sm font-semibold">Role</label>
                <select class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md" id="role" name="role" required>
                    <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>User</option>
                    <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                </select>
            </div>

            <!-- Verification Status (specific to Professional) -->
           

            <!-- Created At (Read-only) -->
            <div class="mb-4">
                <label for="createdAt" class="block text-sm font-semibold">Created At</label>
                <input type="text" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md" id="createdAt" name="createdAt" value="${user.createdAt}" readonly>
            </div>

            <!-- Last Login (Read-only) -->
            <div class="mb-4">
                <label for="lastLogin" class="block text-sm font-semibold">Last Login</label>
                <input type="text" class="form-input mt-1 block w-full border-2 border-gray-300 p-2 rounded-md" id="lastLogin" name="lastLogin" value="${user.lastLogin}" readonly>
            </div>

            <!-- Active Status -->
            

            <!-- Submit Button -->
            <div class="mb-4">
                <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Update Profile</button>
            </div>

            <!-- Cancel Button -->
            <div class="mb-4">
                <a href="/users/profile" class="bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600">Cancel</a>
            </div>
        </form>
    </div>

    <!-- Add Tailwind CSS & Bootstrap JS for possible future enhancement -->
    <script src="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"></script>
</body>
</html>
