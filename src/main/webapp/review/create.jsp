<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Write a Review</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
    <div class="min-h-screen py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-md mx-auto">
            <h2 class="text-3xl font-bold text-center mb-8">Write a Review</h2>
            
            <form action="/reviews/create" method="POST" class="bg-white shadow rounded-lg p-8">
                <input type="hidden" name="bookingId" value="${bookingId}">
                
                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Rating</label>
                    <div class="flex gap-4">
                        <c:forEach begin="1" end="5" var="star">
                            <label class="flex items-center">
                                <input type="radio" name="rating" value="${star}" class="mr-2" required>
                                <span>${star} Star${star > 1 ? 's' : ''}</span>
                            </label>
                        </c:forEach>
                    </div>
                </div>

                <div class="mb-6">
                    <label for="comment" class="block text-gray-700 text-sm font-bold mb-2">
                        Your Review
                    </label>
                    <textarea id="comment" name="comment" rows="4" required
                              class="shadow-sm focus:ring-blue-500 focus:border-blue-500 mt-1 block w-full sm:text-sm border border-gray-300 rounded-md"
                              placeholder="Share your experience..."></textarea>
                </div>

                <div class="flex justify-end">
                    <button type="submit"
                            class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        Submit Review
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>