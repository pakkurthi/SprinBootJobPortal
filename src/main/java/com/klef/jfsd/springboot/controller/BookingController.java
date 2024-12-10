package com.klef.jfsd.springboot.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.klef.jfsd.springboot.model.Service;
import com.klef.jfsd.springboot.model.Booking;
import com.klef.jfsd.springboot.model.BookingStatus;
import com.klef.jfsd.springboot.model.DateTimeUtil;
import com.klef.jfsd.springboot.model.Professional;
import com.klef.jfsd.springboot.model.User;
import com.klef.jfsd.springboot.service.BookingService;
import com.klef.jfsd.springboot.service.ProfessionalService;
import com.klef.jfsd.springboot.service.ServiceService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/bookings")
public class BookingController {
    
    @Autowired
    private BookingService bookingService;
    
    @Autowired
    private ProfessionalService professionalService;
    
    @Autowired
    private ServiceService serviceservice;

    // View service details before booking
    @GetMapping("/view/{serviceId}")
    public String viewServiceDetails(@PathVariable Long serviceId, Model model, HttpSession session) {
        professionalService.getServiceById(serviceId).ifPresent(service -> {
            model.addAttribute("service", service);
        });
        return "booking/booking-details";
    }

    // Show booking form
    @GetMapping("/create/{serviceId}")
    public String showBookingForm(@PathVariable Long serviceId, Model model, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/users/login";
        }

        try {
            Service service = serviceservice.getServiceById(serviceId)
                .orElseThrow(() -> new RuntimeException("Service not found"));
            Professional professional = service.getProfessional();

            model.addAttribute("service", service);
            model.addAttribute("professional", professional);
            model.addAttribute("minDateTime", DateTimeUtil.formatForDisplay(LocalDateTime.now()));
            return "bookings/create";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/professionals/list";
        }
    }

    

//     View user's bookings with optional status filter
//    @GetMapping("/users")
//    public String getUserBookings(@RequestParam(required = false) String status,
//                                Model model, 
//                                HttpSession session) {
//        User user = (User) session.getAttribute("loggedInUser");
//        if (user == null) {
//            return "redirect:/users/login";
//        }
//
//        List<Booking> bookings;
//        if (status != null && !status.equals("all")) {
//            BookingStatus bookingStatus = BookingStatus.valueOf(status.toUpperCase());
//            bookings = bookingService.getBookingsByUserAndStatus(user.getId(), bookingStatus);
//        } else {
//            bookings = bookingService.getBookingsByUserId(user.getId());
//        }
//
//        model.addAttribute("bookings", bookings);
//        return "booking/list";
//    }
    
    
    
    @GetMapping("/user")
    public String getUserBookings(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            List<Booking> bookings = bookingService.getBookingsByUserId(loggedInUser.getId());

            // Format LocalDateTime to String
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy hh:mm a");
            List<Map<String, Object>> formattedBookings = bookings.stream().map(booking -> {
                Map<String, Object> bookingMap = new HashMap<>();
                bookingMap.put("serviceTitle", booking.getService().getTitle());
                bookingMap.put("professionalName", booking.getProfessional().getName());
                bookingMap.put("bookingDateTime", booking.getBookingDateTime().format(formatter));
                bookingMap.put("status", booking.getStatus().toString());
                return bookingMap;
            }).collect(Collectors.toList());

            model.addAttribute("bookings", formattedBookings);
            return "booking/user-bookings";
        } else {
            return "redirect:/users/login";
        }
    }

    // View professional's bookings
    @GetMapping("/professional")
    public String getProfessionalBookings(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Professional)) {
            return "redirect:/login";
        }

        List<Booking> bookings = bookingService.getBookingsByProfessionalId(user.getId());
        model.addAttribute("bookings", bookings);
        return "booking/professional-bookings";
    }

    // View booking details
    @GetMapping("/{id}")
    public String getBookingDetails(@PathVariable Long id,
                                  Model model,
                                  HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/users/login";
        }

        Booking booking = bookingService.getBookingById(id)
            .orElseThrow(() -> new RuntimeException("Booking not found"));

        if (!booking.getUser().getId().equals(user.getId()) && 
            !(user instanceof Professional && booking.getProfessional().getId().equals(user.getId()))) {
            return "redirect:/bookings/user";
        }

        model.addAttribute("booking", booking);
        return "booking/details";
    }

    // Update booking status
    @PostMapping("/{id}/status")
    public String updateBookingStatus(@PathVariable Long id, 
                                    @RequestParam BookingStatus status,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Booking booking = bookingService.getBookingById(id)
            .orElseThrow(() -> new RuntimeException("Booking not found"));

        if (!(user instanceof Professional) && !booking.getUser().getId().equals(user.getId())) {
            redirectAttributes.addFlashAttribute("error", "Unauthorized access");
            return "redirect:/bookings/user";
        }

        bookingService.updateBookingStatus(id, status);
        redirectAttributes.addFlashAttribute("success", "Booking status updated successfully");
        
        return user instanceof Professional ? "redirect:/bookings/professional" : "redirect:/bookings/user";
    }

    // Cancel booking
    @PostMapping("/{id}/cancel")
    public String cancelBooking(@PathVariable Long id,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/users/login";
        }

        try {
            Booking booking = bookingService.getBookingById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

            if (!booking.getUser().getId().equals(user.getId())) {
                throw new RuntimeException("Unauthorized access");
            }

            if (booking.getStatus() != BookingStatus.PENDING) {
                throw new RuntimeException("Only pending bookings can be cancelled");
            }

            booking.setStatus(BookingStatus.CANCELLED);
            bookingService.updateBooking(booking);
            redirectAttributes.addFlashAttribute("success", "Booking cancelled successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/bookings/user";
    }
    
    @PostMapping("/{id}/confirm")
    public String confirmBooking(@PathVariable Long id,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/users/login";
        }

        try {
            Booking booking = bookingService.getBookingById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

            if (!booking.getUser().getId().equals(user.getId())) {
                throw new RuntimeException("Unauthorized access");
            }

            if (booking.getStatus() != BookingStatus.PENDING) {
                throw new RuntimeException("Only pending bookings can be confirmed");
            }

            booking.setStatus(BookingStatus.CONFIRMED);
            bookingService.updateBooking(booking);
            redirectAttributes.addFlashAttribute("success", "Booking confirmed successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/bookings/user";
    }    
    
    
    
    
    
    @GetMapping("/create/service/{serviceId}")
    public String showServiceBookingForm(@PathVariable Long serviceId, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/users/login";
        }

        professionalService.getServiceById(serviceId).ifPresent(service -> {
            model.addAttribute("service", service);
            model.addAttribute("professional", service.getProfessional());
        });
        model.addAttribute("booking", new Booking());
        return "booking/create";
    }

    @PostMapping("/create")
    public String createBooking(
        @RequestParam Long serviceId,
        @ModelAttribute Booking booking,
        HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            professionalService.getServiceById(serviceId).ifPresent(service -> {
                booking.setService(service);
                booking.setProfessional(service.getProfessional());
            });
            booking.setUser(loggedInUser);

            // Automatically set the booking date-time to the current time
            booking.setBookingDateTime(LocalDateTime.now());
            booking.setStatus(BookingStatus.PENDING); // Default status
            bookingService.createBooking(booking);

            return "redirect:/bookings/user";
        } else {
            return "redirect:/users/login";
        }
    }




    
}
