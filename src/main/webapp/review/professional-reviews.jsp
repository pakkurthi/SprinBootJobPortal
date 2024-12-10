<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Professional Reviews</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold mb-8">Reviews & Ratings</h1>
        
        <div class="grid gap-6">
            <c:forEach items="${reviews}" var="review">
                <div class="bg-white rounded-lg shadow p-6">
                    <div class="flex items-center justify-between mb-4">
                        <div class="flex items-center">
                            <div class="ml-3">
                                <p class="text-sm font-medium text-gray-900">${review.user.name}</p>
                                <p class="text-sm text-gray-500">${review.createdAt}</p>
                            </div>
                        </div>
                        <div class="flex items-center">
                            <c:forEach begin="1" end="5" var="star">
                                <svg class="h-5 w-5 ${star <= review.rating ? 'text-yellow-400' : 'text-gray-300'}"
                                     xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                </svg>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <p class="text-gray-700">${review.comment}</p>
                    
                    <div class="mt-4 text-sm text-gray-500">
                        Service: ${review.booking.service.title}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>