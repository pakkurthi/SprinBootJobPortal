package com.klef.jfsd.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Booking;
import com.klef.jfsd.springboot.model.BookingStatus;
import com.klef.jfsd.springboot.model.RecentActivity;
import com.klef.jfsd.springboot.repository.BookingRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class BookingServiceImpl implements BookingService {
    
    @Autowired
    private BookingRepository bookingRepository;

    

    @Override
    public Booking updateBooking(Booking booking) {
        return bookingRepository.save(booking);
    }

    
    
    
    @Override
    public Booking createBooking(Booking booking) {
        return bookingRepository.save(booking);
    }

    @Override
    public Optional<Booking> getBookingById(Long id) {
        return bookingRepository.findById(id);
    }

    @Override
    public List<Booking> getBookingsByUserId(Long userId) {
        return bookingRepository.findByUserId(userId);
    }

    @Override
    public List<Booking> getBookingsByProfessionalId(Long professionalId) {
        return bookingRepository.findByProfessionalId(professionalId);
    }

    @Override
    public List<Booking> getBookingsByStatus(BookingStatus status) {
        return bookingRepository.findByStatus(status);
    }

    @Override
    public Booking updateBookingStatus(Long bookingId, BookingStatus status) {
        Optional<Booking> bookingOpt = bookingRepository.findById(bookingId);
        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            booking.setStatus(status);
            return bookingRepository.save(booking);
        }
        throw new RuntimeException("Booking not found");
    }

    @Override
    public List<Booking> getRecentBookingsByUser(Long userId) {
        return bookingRepository.findRecentBookingsByUserId(userId);
    }

    @Override
    public void deleteBooking(Long id) {
        bookingRepository.deleteById(id);
    }
    
    
    public List<Booking> getBookingsByUser(Long userId) {
        return bookingRepository.findByUserId(userId);
    }
    
    @Override
    public List<Booking> getBookingsByUserAndStatus(Long userId, BookingStatus status) {
        return bookingRepository.findByUserIdAndStatus(userId, status);
    }
    
    @Override
    public boolean isProfessionalAvailable(Long professionalId, LocalDateTime dateTime) {
        LocalDateTime endTime = dateTime.plusMinutes(60); // Assuming 1-hour slots
        List<Booking> existingBookings = bookingRepository.findOverlappingBookings(
            professionalId, dateTime, endTime);
        return existingBookings.isEmpty();
    }




	@Override
	public long getBookingCount() {
		// TODO Auto-generated method stub
		return bookingRepository.count();
	}




	
	@Override
    public List<RecentActivity> getRecentActivities() {
        List<RecentActivity> activities = new ArrayList<>();
        List<Booking> recentBookings = bookingRepository.findTop10ByOrderByCreatedAtDesc();
        
        for (Booking booking : recentBookings) {
            activities.add(new RecentActivity(
                "Booking: " + booking.getService().getTitle(),
                booking.getUser().getName(),
                booking.getCreatedAt(),
                booking.getStatus().toString()
            ));
        }
        
        return activities;
    }
}