<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Search Results - ProServices</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-8">Search Results</h1>

        <!-- Search Filters -->
        <div class="bg-white rounded-lg shadow-sm p-6 mb-8">
            <form action="/search" method="GET" class="flex flex-wrap gap-4">
                <div class="flex-1">
                    <input type="text" name="query" value="${param.query}" class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Search services...">
                </div>
                <div class="w-48">
                    <select name="category" class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Categories</option>
                        <option value="legal" ${param.category == 'legal' ? 'selected' : ''}>Legal</option>
                        <option value="finance" ${param.category == 'finance' ? 'selected' : ''}>Finance</option>
                        <option value="it" ${param.category == 'it' ? 'selected' : ''}>IT</option>
                    </select>
                </div>
                <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">Search</button>
            </form>
        </div>

        <!-- Results -->
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
                        <div class="space-y-2">
                            <c:forEach items="${professional.services}" var="service">
                                <div class="flex justify-between items-center">
                                    <span>${service.title}</span>
                                    <span class="font-semibold">$${service.price}</span>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="mt-6">
                            <a href="/professionals/${professional.id}" class="block text-center bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">View Profile</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>