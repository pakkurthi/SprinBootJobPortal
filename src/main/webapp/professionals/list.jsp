<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Professional Services - Book Now</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-8">Available Professionals</h1>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach items="${professionals}" var="professional">
                <div class="bg-white rounded-lg shadow-sm overflow-hidden">
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-xl font-semibold">${professional.name}</h3>
                            <div class="flex items-center">
                                <span class="text-yellow-400 mr-1">★</span>
                                <span>${professional.averageRating}</span>
                            </div>
                        </div>
                        <p class="text-gray-600 mb-4">${professional.title}</p>
                        <div class="space-y-4">
                            <c:forEach items="${professional.services}" var="service">
                                <div class="border rounded-lg p-4">
                                    <div class="flex justify-between items-center mb-2">
                                        <span class="font-semibold">${service.title}</span>
                                        <span class="text-lg font-bold">$${service.price}</span>
                                    </div>
                                    <p class="text-gray-600 text-sm mb-4">${service.description}</p>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm text-gray-500">${service.duration}</span>
                                        <a href="/bookings/create/${service.id}" 
                                           class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
                                            Book Now
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>