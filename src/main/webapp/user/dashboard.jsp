<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard - JobQuest</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-light-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-8">Welcome, ${user.name}</h1>

        <!-- Quick Actions -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <a href="/search" class="bg-white p-6 rounded-lg border-2 border-black shadow hover:shadow-lg transition">
                <h3 class="text-lg font-semibold mb-2">Find Services</h3>
                <p class="text-gray-600">Search for professional services</p>
            </a>
            <a href="/users/users" class="bg-white p-6 rounded-lg border-2 border-black shadow hover:shadow-lg transition">
                <h3 class="text-lg font-semibold mb-2">My Bookings</h3>
                <p class="text-gray-600">View and manage your bookings</p>
            </a>
            <a href="/users/profile" class="bg-white p-6 rounded-lg border-2 border-black shadow hover:shadow-lg transition">
                <h3 class="text-lg font-semibold mb-2">Profile Settings</h3>
                <p class="text-gray-600">Update your personal information</p>
            </a>
        </div>

        <!-- Recent Bookings -->
        <div class="bg-white rounded-lg border-2 border-black shadow mb-8">
            <div class="p-6">
                <h2 class="text-xl font-semibold mb-4">Recent Bookings</h2>
                <div class="overflow-x-auto">
                    <table class="min-w-full">
                        <thead>
                            <tr>
                                <th>Professional</th>
                                <th>Service</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${bookings}" var="booking">
                                <tr>
                                    <td>${booking.professional.name}</td>
                                    <td>${booking.service.title}</td>
                                    <td>${booking.bookingDateTime}</td>
                                    <td>
                                        <span class="badge 
                                            ${booking.status == 'PENDING' ? 'bg-warning' : 
                                              booking.status == 'CONFIRMED' ? 'bg-success' : 
                                              booking.status == 'COMPLETED' ? 'bg-info' : 
                                              'bg-danger'}">
                                            ${booking.status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="/bookings/${booking.id}" class="btn btn-sm btn-info">View Details</a>
                                        <c:if test="${booking.status == 'PENDING'}">
                                            <form action="/bookings/${booking.id}/cancel" method="post" style="display: inline;">
                                                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to cancel this booking?')">Cancel</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
