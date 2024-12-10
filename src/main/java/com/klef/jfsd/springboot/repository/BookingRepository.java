package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.klef.jfsd.springboot.model.Booking;
import com.klef.jfsd.springboot.model.BookingStatus;

import java.time.LocalDateTime;
import java.util.List;

public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<Booking> findByUserId(Long userId);
    List<Booking> findByProfessionalId(Long professionalId);
    List<Booking> findByStatus(BookingStatus status);
    List<Booking> findByUserIdAndStatus(Long userId, BookingStatus status);
    
    @Query("SELECT b FROM Booking b WHERE b.user.id = :userId ORDER BY b.bookingDateTime DESC")
    List<Booking> findRecentBookingsByUserId(@Param("userId") Long userId);
    
    
    @Query("SELECT b FROM Booking b WHERE b.professional.id = :professionalId " +
    	       "AND b.status != 'CANCELLED' " +
    	       "AND ((b.startTime <= :endTime AND b.endTime >= :startTime))")
    	List<Booking> findOverlappingBookings(@Param("professionalId") Long professionalId,
    	                                     @Param("startTime") LocalDateTime startTime,
    	                                     @Param("endTime") LocalDateTime endTime);
    
    
    
     
     List<Booking> findTop10ByOrderByCreatedAtDesc();
}