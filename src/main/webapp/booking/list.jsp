<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="My Bookings" scope="request"/>
<%@ include file="../components/header.jsp" %>

<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold">My Bookings</h1>
        <div class="flex space-x-4">
            <a href="/users/users?status=all" 
               class="px-4 py-2 rounded-md ${empty param.status || param.status == 'all' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700'}">
                All
            </a>
            <a href="/users/users?status=PENDING"
               class="px-4 py-2 rounded-md ${param.status == 'PENDING' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700'}">
                Pending
            </a>
            <a href="/users/users?status=CONFIRMED"
               class="px-4 py-2 rounded-md ${param.status == 'CONFIRMED' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700'}">
                Confirmed
            </a>
            <a href="/users/users?status=COMPLETED"
               class="px-4 py-2 rounded-md ${param.status == 'COMPLETED' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700'}">
                Completed
            </a>
        </div>
    </div>

    <c:if test="${empty bookings}">
        <div class="text-center py-8">
            <p class="text-gray-500">No bookings found.</p>
        </div>
    </c:if>

    <div class="space-y-4">
        <c:forEach items="${bookings}" var="booking">
            <%@ include file="../components/booking-card.jsp" %>
        </c:forEach>
    </div>
</div>

<%@ include file="../components/footer.jsp" %>