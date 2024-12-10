<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Booking Details" scope="request"/>
<%@ include file="../components/header.jsp" %>

<div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="bg-white rounded-lg shadow-sm overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-2xl font-bold text-gray-800">Booking Details</h2>
        </div>
        
        <div class="p-6">
            <div class="mb-8">
                <h3 class="text-lg font-semibold mb-4">Service Information</h3>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <p class="text-sm text-gray-600">Service</p>
                        <p class="font-medium">${booking.service.title}</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600">Professional</p>
                        <p class="font-medium">${booking.professional.name}</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600">Price</p>
                        <p class="font-medium">$${booking.totalAmount}</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600">Duration</p>
                        <p class="font-medium">${booking.service.duration}</p>
                    </div>
                </div>
            </div>

            <div class="mb-8">
                <h3 class="text-lg font-semibold mb-4">Booking Status</h3>
                <span class="px-3 py-1 rounded-full text-sm font-semibold
                    ${booking.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' : ''}
                    ${booking.status == 'CONFIRMED' ? 'bg-green-100 text-green-800' : ''}
                    ${booking.status == 'COMPLETED' ? 'bg-blue-100 text-blue-800' : ''}
                    ${booking.status == 'CANCELLED' ? 'bg-red-100 text-red-800' : ''}">
                    ${booking.status}
                </span>
            </div>

            <div class="mb-8">
                <h3 class="text-lg font-semibold mb-4">Schedule Information</h3>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <p class="text-sm text-gray-600">Booking Date & Time</p>
                        <p class="font-medium">${booking.bookingDateTime}</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-600">Created On</p>
                        <p class="font-medium">${booking.createdAt}</p>
                    </div>
                </div>
            </div>

            <c:if test="${not empty booking.notes}">
                <div class="mb-8">
                    <h3 class="text-lg font-semibold mb-4">Additional Notes</h3>
                    <p class="text-gray-700">${booking.notes}</p>
                </div>
            </c:if>

<div class="mt-8 flex justify-end space-x-4">
    <a href="/bookings/user" 
       class="bg-gray-100 text-gray-700 px-4 py-2 rounded-lg hover:bg-gray-200">
        Back to Bookings
    </a>
    <c:if test="${booking.status == 'PENDING'}">
        <form action="/bookings/${booking.id}/cancel" 
              method="POST" 
              class="inline">
            <button type="submit" 
                    class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700"
                    onclick="return confirm('Are you sure you want to cancel this booking?')">
                Cancel Booking
            </button>
        </form>
        <form action="/bookings/${booking.id}/confirm" 
              method="POST" 
              class="inline">
            <button type="submit" 
                    class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700"
                    onclick="return confirm('Are you sure you want to confirm this booking?')">
                Confirm Booking
            </button>
        </form>
    </c:if>
</div>

        </div>
    </div>
</div>

<%@ include file="../components/footer.jsp" %>