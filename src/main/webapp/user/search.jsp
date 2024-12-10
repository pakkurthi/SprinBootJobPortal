<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Services - ProServices</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-8">Available Professional Services</h1>

        <!-- Services Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach items="${services}" var="service">
                <div class="bg-white rounded-lg shadow-sm overflow-hidden">
                    <div class="p-6">
                        <div class="mb-4">
                            <h3 class="text-xl font-semibold">${service.title}</h3>
                            <p class="text-gray-600 mt-2">${service.description}</p>
                        </div>
                        
                        <div class="flex justify-between items-center mb-4">
                            <span class="text-lg font-bold">$${service.price}</span>
                            <span class="text-gray-600">${service.duration}</span>
                        </div>
                        
                        <div class="border-t pt-4">
                            <h4 class="font-semibold mb-2">Professional:</h4>
                            <div class="flex items-center justify-between">
                                <div>
                                    <p class="font-medium">${service.professional.name}</p>
                                    <p class="text-sm text-gray-600">${service.professional.title}</p>
                                </div>
                                <div class="flex items-center">
                                    <span class="text-yellow-400 mr-1">★</span>
                                    <span>${service.professional.averageRating}</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-6">
                            <form action="/bookings/create" method="POST">
                                <input type="hidden" name="serviceId" value="${service.id}">
                                <input type="hidden" name="professionalId" value="${service.professional.id}">
                                <button type="submit" 
                                        class="w-full bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
                                    Book Now
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
