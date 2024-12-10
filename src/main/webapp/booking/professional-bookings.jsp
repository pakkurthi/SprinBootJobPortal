<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-8">Manage Bookings</h1>

        <!-- Booking Status Tabs -->
        <div class="mb-8">
            <div class="border-b border-gray-200">
                <nav class="-mb-px flex space-x-8">
                    <a href="?status=PENDING" class="border-b-2 border-blue-500 py-4 px-1 text-sm font-medium text-blue-600">
                        Pending
                    </a>
                    <a href="?status=CONFIRMED" class="border-b-2 border-transparent py-4 px-1 text-sm font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300">
                        Confirmed
                    </a>
                    <a href="?status=COMPLETED" class="border-b-2 border-transparent py-4 px-1 text-sm font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300">
                        Completed
                    </a>
                    <a href="?status=CANCELLED" class="border-b-2 border-transparent py-4 px-1 text-sm font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300">
                        Cancelled
                    </a>
                </nav>
            </div>
        </div>

        <!-- Bookings List -->
        <div class="bg-white shadow overflow-hidden sm:rounded-md">
            <ul class="divide-y divide-gray-200">
                <c:forEach items="${bookings}" var="booking">
                    <li>
                        <div class="px-4 py-4 sm:px-6">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center">
                                    <div class="ml-3">
                                        <p class="text-sm font-medium text-gray-900">
                                            ${booking.user.name}
                                        </p>
                                        <p class="text-sm text-gray-500">
                                            ${booking.service.title}
                                        </p>
                                    </div>
                                </div>
                                <div class="ml-2 flex-shrink-0 flex">
                                    <p class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        ${booking.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' : ''}
                                        ${booking.status == 'CONFIRMED' ? 'bg-green-100 text-green-800' : ''}
                                        ${booking.status == 'COMPLETED' ? 'bg-blue-100 text-blue-800' : ''}
                                        ${booking.status == 'CANCELLED' ? 'bg-red-100 text-red-800' : ''}">
                                        ${booking.status}
                                    </p>
                                </div>
                            </div>
                            <div class="mt-2 sm:flex sm:justify-between">
                                <div class="sm:flex">
                                    <p class="flex items-center text-sm text-gray-500">
                                        Date: ${booking.bookingDateTime}
                                    </p>
                                    <p class="mt-2 flex items-center text-sm text-gray-500 sm:mt-0 sm:ml-6">
                                        Amount: $${booking.totalAmount}
                                    </p>
                                </div>
                                <div class="mt-2 flex items-center text-sm text-gray-500 sm:mt-0">
                                    <c:if test="${booking.status == 'PENDING'}">
                                        <form action="/bookings/${booking.id}/status" method="POST" class="inline-block">
                                            <input type="hidden" name="status" value="CONFIRMED">
                                            <button type="submit" class="bg-green-500 text-white px-3 py-1 rounded mr-2">
                                                Accept
                                            </button>
                                        </form>
                                        <form action="/bookings/${booking.id}/status" method="POST" class="inline-block">
                                            <input type="hidden" name="status" value="CANCELLED">
                                            <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded">
                                                Decline
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${booking.status == 'CONFIRMED'}">
                                        <form action="/bookings/${booking.id}/status" method="POST">
                                            <input type="hidden" name="status" value="COMPLETED">
                                            <button type="submit" class="bg-blue-500 text-white px-3 py-1 rounded">
                                                Mark Complete
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</body>
</html>