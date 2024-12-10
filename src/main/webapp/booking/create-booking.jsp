<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Service</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body>
    <div class="container py-5">
        <h2 class="mb-4">Book Service</h2>
        
        <!-- Service and Professional Details -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">${service.title}</h5>
                <p class="card-text">${service.description}</p>
                <p><strong>Price:</strong> $${service.price}</p>
                <p><strong>Duration:</strong> ${service.duration} minutes</p>
                <hr>
                <p><strong>Professional:</strong> ${professional.name}</p>
            </div>
        </div>

        <!-- Booking Form -->
        <form action="/bookings/create" method="POST">
    <input type="hidden" name="serviceId" value="${service.id}">
    <input type="hidden" name="professionalId" value="${professional.id}">
    
    <!-- Optionally, let the user add notes -->
    <div class="form-group">
        <label for="notes">Additional Notes</label>
        <textarea id="notes" name="notes" class="form-control"></textarea>
    </div>
    
    <button type="submit" class="btn btn-primary">Confirm Booking</button>
</form>


    </div>

    <!-- Include Flatpickr if needed -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        // Optionally configure Flatpickr for enhanced datetime selection
        flatpickr("#bookingDateTime", {
            enableTime: true,
            dateFormat: "Y-m-d H:i",
            minDate: "today",
        });

        // Frontend validation for the form
        (function () {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>
