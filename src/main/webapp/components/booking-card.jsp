<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="bg-white rounded-lg shadow-sm p-6 mb-4">
    <div class="flex justify-between items-start">
        <div>
            <h3 class="text-lg font-semibold">${booking.service.title}</h3>
            <p class="text-gray-600">with ${booking.professional.name}</p>
            <p class="text-sm text-gray-500 mt-2">
                Scheduled for: ${booking.bookingDateTime}
            </p>
        </div>
        <div class="text-right">
            <span class="px-3 py-1 rounded-full text-sm font-semibold
                ${booking.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' : ''}
                ${booking.status == 'CONFIRMED' ? 'bg-green-100 text-green-800' : ''}
                ${booking.status == 'COMPLETED' ? 'bg-blue-100 text-blue-800' : ''}
                ${booking.status == 'CANCELLED' ? 'bg-red-100 text-red-800' : ''}">
                ${booking.status}
            </span>
            <p class="mt-2 font-bold">$${booking.totalAmount}</p>
        </div>
    </div>
    <div class="mt-4 flex justify-end space-x-4">
        <a href="/bookings/${booking.id}" class="text-blue-600 hover:text-blue-800">View Details</a>
        <c:if test="${booking.status == 'COMPLETED' && empty booking.review}">
            <a href="/reviews/create/${booking.id}" class="text-green-600 hover:text-green-800">Leave Review</a>
        </c:if>
        <c:if test="${booking.status == 'PENDING'}">
            <form action="/bookings/${booking.id}/cancel" method="POST" class="inline">
                <button type="submit" class="text-red-600 hover:text-red-800"
                        onclick="return confirm('Are you sure you want to cancel this booking?')">
                    Cancel
                </button>
            </form>
        </c:if>
    </div>
</div>