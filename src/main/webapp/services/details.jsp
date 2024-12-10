<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${service.title} - ProServices</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="container mx-auto px-4 py-8">
        <div class="max-w-2xl mx-auto bg-white rounded-lg shadow-sm overflow-hidden">
            <div class="p-6">
                <h1 class="text-3xl font-bold mb-4">${service.title}</h1>
                
                <div class="mb-6">
                    <p class="text-gray-600">${service.description}</p>
                </div>
                
                <div class="flex justify-between items-center mb-6">
                    <div>
                        <span class="text-2xl font-bold">$${service.price}</span>
                        <span class="text-gray-600 ml-2">/ ${service.duration}</span>
                    </div>
                    <span class="px-3 py-1 bg-green-100 text-green-800 rounded-full">
                        ${service.category}
                    </span>
                </div>
                
                <div class="border-t pt-6">
                    <h2 class="text-xl font-semibold mb-4">About the Professional</h2>
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="font-medium text-lg">${service.professional.name}</p>
                            <p class="text-gray-600">${service.professional.title}</p>
                        </div>
                        <div class="flex items-center">
                            <span class="text-yellow-400 mr-1">★</span>
                            <span>${service.professional.averageRating}</span>
                        </div>
                    </div>
                </div>
                
                <div class="mt-8">
                    <form action="/bookings/create" method="POST">
                        <input type="hidden" name="serviceId" value="${service.id}">
                        <input type="hidden" name="professionalId" value="${service.professional.id}">
                        <button type="submit" 
                                class="w-full bg-blue-600 text-white px-6 py-3 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                            Book This Service
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>