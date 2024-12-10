<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Service Details - ProServices</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container py-5">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title mb-4">${service.title}</h2>
                        
                        <div class="mb-4">
                            <h5>Professional Details</h5>
                            <p><strong>Name:</strong> ${service.professional.name}</p>
                            <p><strong>Role:</strong> ${service.professional.role}</p>
                            <p><strong>City:</strong> ${service.professional.city}</p>
                        </div>

                        <div class="mb-4">
                            <h5>Service Details</h5>
                            <p><strong>Price:</strong> $${service.price}</p>
                            <p><strong>Duration:</strong> ${service.duration}</p>
                            <p><strong>Description:</strong> ${service.description}</p>
                        </div>

                        <form action="/bookings/create" method="POST" class="mt-4">
                            <input type="hidden" name="serviceId" value="${service.id}">
                            <input type="hidden" name="professionalId" value="${service.professional.id}">
                            
                            <div class="mb-3">
                                <label for="bookingDateTime" class="form-label">Select Date and Time</label>
                                <input type="datetime-local" 
                                       class="form-control" 
                                       id="bookingDateTime" 
                                       name="bookingDateTime" 
                                       required>
                            </div>

                            <div class="mb-3">
                                <label for="notes" class="form-label">Additional Notes</label>
                                <textarea class="form-control" 
                                          id="notes" 
                                          name="notes" 
                                          rows="3"></textarea>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    Book Now for $${service.price}
                                </button>
                                <a href="/search" class="btn btn-secondary">Back to Services</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
