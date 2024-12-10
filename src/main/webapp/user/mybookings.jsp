<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="../shared/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-5">
    <h2 class="mb-4">My Bookings</h2>

    <div class="row">
        <div class="col-md-12">
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Professional</th>
                                    <th>Service</th>
                                    <th>Date & Time</th>
                                    <th>Status</th>
                                    <th>Total Amount</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${bookings}" var="booking">
                                    <tr>
                                        <td>
                                            <a href="/professionals/${booking.professional.id}" class="text-decoration-none">
                                                ${booking.professional.name}
                                            </a>
                                        </td>
                                        <td>${booking.service.title}</td>
                                        <td>${booking.startTime}</td>
                                        <td>
                                            <span class="badge bg-${booking.status == 'CONFIRMED' ? 'success' : 
                                                                    booking.status == 'PENDING' ? 'warning' : 
                                                                    booking.status == 'COMPLETED' ? 'info' : 'danger'}">
                                                ${booking.status}
                                            </span>
                                        </td>
                                        <td>$${booking.totalAmount}</td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <button class="btn btn-outline-primary" 
                                                        onclick="viewBookingDetails(${booking.id})">
                                                    View Details
                                                </button>
                                                <c:if test="${booking.status == 'COMPLETED'}">
                                                    <button class="btn btn-outline-success"
                                                            onclick="leaveReview(${booking.id})">
                                                        Leave Review
                                                    </button>
                                                </c:if>
                                                <c:if test="${booking.status == 'PENDING'}">
                                                    <button class="btn btn-outline-danger"
                                                            onclick="cancelBooking(${booking.id})">
                                                        Cancel
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Booking Details Modal -->
<div class="modal fade" id="bookingDetailsModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Booking Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- Booking details will be loaded here -->
            </div>
        </div>
    </div>
</div>

<!-- Leave Review Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Leave a Review</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="reviewForm" action="/reviews/create" method="post">
                    <input type="hidden" id="bookingId" name="bookingId" value="">
                    <div class="mb-3">
                        <label for="rating" class="form-label">Rating</label>
                        <select id="rating" name="rating" class="form-select" required>
                            <option value="" disabled selected>Choose a rating</option>
                            <option value="1">1 - Poor</option>
                            <option value="2">2 - Fair</option>
                            <option value="3">3 - Good</option>
                            <option value="4">4 - Very Good</option>
                            <option value="5">5 - Excellent</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="comment" class="form-label">Review Comment</label>
                        <textarea id="comment" name="comment" class="form-control" rows="3" required></textarea>
                    </div>
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">Submit Review</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for Handling Actions -->
<script>
    function viewBookingDetails(bookingId) {
        // Fetch and show booking details dynamically (e.g., using AJAX)
        console.log("Viewing details for booking ID: " + bookingId);
        // You can make an AJAX request here to fetch the details and update the modal body
        // Example: $('#bookingDetailsModal .modal-body').html(response);
        $('#bookingDetailsModal').modal('show');
    }

    function leaveReview(bookingId) {
        // Set the booking ID in the review form
        $('#bookingId').val(bookingId);
        // Open the review modal
        $('#reviewModal').modal('show');
    }

    function cancelBooking(bookingId) {
        // Implement booking cancellation logic (e.g., with an AJAX request)
        console.log("Canceling booking ID: " + bookingId);
        // Example: Send a request to cancel the booking
        // $.ajax({...});
    }
</script>

<!-- Bootstrap JS (for Modal functionality) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
