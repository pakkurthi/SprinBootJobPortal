<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Service</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body class="bg-gray-50">
    <div class="min-h-screen py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-2xl mx-auto">
            <div class="mb-8">
                <h2 class="text-3xl font-bold text-gray-900">Book Service</h2>
                <p class="mt-2 text-sm text-gray-600">Complete your booking details below</p>
            </div>

            <c:if test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4" role="alert">
                    <p class="font-medium">Error</p>
                    <p class="text-sm">${error}</p>
                </div>
            </c:if>

            <!-- Service Card -->
            <div class="bg-white rounded-lg shadow-sm p-6 mb-8">
                <div class="flex items-start justify-between">
                    <div>
                        <h3 class="text-xl font-semibold text-gray-900">${service.title}</h3>
                        <p class="mt-2 text-gray-600">${service.description}</p>
                    </div>
                    <div class="text-right">
                        <p class="text-2xl font-bold text-gray-900">$${service.price}</p>
                        <p class="text-sm text-gray-500">${service.duration} minutes</p>
                    </div>
                </div>
                
                <div class="mt-6 border-t border-gray-200 pt-4">
                    <div class="flex items-center">
                        <img src="${professional.profileImageUrl}" 
                             alt="${professional.name}" 
                             class="h-12 w-12 rounded-full">
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-900">${professional.name}</p>
                            <p class="text-sm text-gray-500">${professional.title}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking Form -->
            <form action="/bookings/create" method="POST">
    <input type="hidden" name="serviceId" value="${service.id}">
    <input type="hidden" name="professionalId" value="${professional.id}">
    <div class="mb-6">
        <label for="bookingDateTime" class="block text-gray-700 font-medium mb-2">Preferred Date and Time</label>
        <input 
            type="datetime-local" 
            id="bookingDateTime" 
            name="bookingDateTime" 
            class="block w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            required>
    </div>
    <div class="mb-6">
        <label for="notes" class="block text-gray-700 font-medium mb-2">Additional Notes</label>
        <textarea 
            id="notes" 
            name="notes" 
            class="block w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" 
            placeholder="Provide any additional information or instructions..."></textarea>
    </div>
    <button type="submit" class="bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600">
        Confirm Booking
    </button>
</form>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        flatpickr("#bookingDateTime", {
            enableTime: true,
            dateFormat: "Y-m-d H:i",
            minDate: "today",
            minTime: "09:00",
            maxTime: "18:00",
            disable: [
                function(date) {
                    return (date.getDay() === 0 || date.getDay() === 6);
                }
            ],
            locale: {
                firstDayOfWeek: 1
            }
        });
    </script>
</body>
</html>
