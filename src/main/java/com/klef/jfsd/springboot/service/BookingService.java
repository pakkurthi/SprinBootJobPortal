package com.klef.jfsd.springboot.service;


import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import com.klef.jfsd.springboot.model.Booking;
import com.klef.jfsd.springboot.model.BookingStatus;
import com.klef.jfsd.springboot.model.RecentActivity;

public interface BookingService {
    



    Booking createBooking(Booking booking);
    Optional<Booking> getBookingById(Long id);
    List<Booking> getBookingsByUserId(Long userId);
    List<Booking> getBookingsByProfessionalId(Long professionalId);
    List<Booking> getBookingsByStatus(BookingStatus status);
    Booking updateBookingStatus(Long bookingId, BookingStatus status);
    List<Booking> getRecentBookingsByUser(Long userId);
    void deleteBooking(Long id);
    List<Booking> getBookingsByUser(Long userId);
    List<Booking> getBookingsByUserAndStatus(Long userId, BookingStatus status);
    boolean isProfessionalAvailable(Long professionalId, LocalDateTime dateTime);
    long getBookingCount();
    List<RecentActivity> getRecentActivities();
    Booking updateBooking(Booking booking);
    

    
}