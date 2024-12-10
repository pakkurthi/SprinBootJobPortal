<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - ProServices</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <nav class="bg-white shadow-sm">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex">
                    <a href="/" class="flex-shrink-0 flex items-center">
                        <span class="text-xl font-bold text-blue-600">ProServices</span>
                    </a>
                </div>
                <div class="flex items-center">
                    <c:choose>
                        <c:when test="${empty loggedInUser}">
                            <a href="/users/login" class="text-gray-700 hover:text-gray-900 px-3 py-2">Login</a>
                            <a href="/users/register" class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">Sign Up</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/bookings/user" class="text-gray-700 hover:text-gray-900 px-3 py-2">My Bookings</a>
                            <a href="/users/profile" class="text-gray-700 hover:text-gray-900 px-3 py-2">Profile</a>
                            <form action="/users/logout" method="POST" class="inline">
                                <button type="submit" class="text-gray-700 hover:text-gray-900 px-3 py-2">Logout</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>