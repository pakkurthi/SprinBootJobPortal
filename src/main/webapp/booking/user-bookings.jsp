<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container py-5">
        <h2 class="mb-4">My Bookings</h2>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty bookings}">
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Service</th>
                                        <th>Professional</th>
                                        <th>Date & Time</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${bookings}" var="booking">
                                        <tr>
                                            <td>${booking.service.title}</td>
                                            <td>${booking.professional.name}</td>
                                            <td>${booking.bookingDateTime}</td>

                                            <td>
                                                <span class="badge 
                                                    ${booking.status == 'PENDING' ? 'bg-warning' : 
                                                      booking.status == 'CONFIRMED' ? 'bg-success' : 
                                                      booking.status == 'COMPLETED' ? 'bg-info' : 
                                                      'bg-danger'}">
                                                    ${booking.status}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="/bookings/${booking.id}" 
                                                       class="btn btn-sm btn-info">View Details</a>
                                                    
                                                    <c:if test="${booking.status == 'PENDING'}">
                                                        <form action="/bookings/${booking.id}/cancel" 
                                                              method="post" 
                                                              style="display: inline;"
                                                              onsubmit="return confirm('Are you sure you want to cancel this booking?')">
                                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                                            <button type="submit" class="btn btn-sm btn-danger">Cancel</button>
                                                        </form>
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
            </c:when>
            <c:otherwise>
                <div class="alert alert-info">No bookings found.</div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
