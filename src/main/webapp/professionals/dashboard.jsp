<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Professional Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-warning">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-8">Welcome, ${professional.name}</h1>
        
        <!-- Statistics -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white p-6 rounded-lg border-2 border-black shadow">
                <h3 class="text-lg font-semibold mb-2">Total Bookings</h3>
                <p class="text-3xl font-bold">${professional.bookings.size()}</p>
            </div>
            <div class="bg-white p-6 rounded-lg border-2 border-black shadow">
                <h3 class="text-lg font-semibold mb-2">Average Rating</h3>
                <p class="text-3xl font-bold">${professional.averageRating}/5.0</p>
            </div>
            <div class="bg-white p-6 rounded-lg border-2 border-black shadow">
                <h3 class="text-lg font-semibold mb-2">Total Services</h3>
                <p class="text-3xl font-bold">${professional.services.size()}</p>
            </div>
        </div>

        <!-- Recent Bookings -->
        <div class="bg-white rounded-lg border-2 border-black shadow mb-8">
            <div class="p-6">
                <h2 class="text-xl font-semibold mb-4">Recent Bookings</h2>
                <div class="overflow-x-auto">
                    <table class="min-w-full">
                        <thead>
                            <tr>
                                <th class="px-6 py-3 border-b">Client</th>
                                <th class="px-6 py-3 border-b">Service</th>
                                <th class="px-6 py-3 border-b">Date</th>
                                <th class="px-6 py-3 border-b">Status</th>
                                <th class="px-6 py-3 border-b">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${professional.bookings}" var="booking">
                                <tr>
                                    <td class="px-6 py-4">${booking.user.name}</td>
                                    <td class="px-6 py-4">${booking.service.title}</td>
                                    <td class="px-6 py-4">${booking.bookingDateTime}</td>
                                    <td class="px-6 py-4">${booking.status}</td>
                                    <td class="px-6 py-4">
                                        <a href="/bookings/${booking.id}" class="text-blue-600 hover:text-blue-800">View</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <a href="/professionals/services/add" class="bg-white p-6 rounded-lg border-2 border-black shadow hover:shadow-lg transition">
                <h3 class="text-lg font-semibold mb-2">Add New Service</h3>
                <p class="text-gray-600">Create a new service offering for your clients</p>
            </a>
            <a href="/professionals/profile" class="bg-white p-6 rounded-lg border-2 border-black shadow hover:shadow-lg transition">
                <h3 class="text-lg font-semibold mb-2">Update Profile</h3>
                <p class="text-gray-600">Keep your professional profile up to date</p>
            </a>
        </div>
    </div>
</body>
</html>
