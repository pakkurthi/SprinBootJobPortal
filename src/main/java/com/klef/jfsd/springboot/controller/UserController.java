package com.klef.jfsd.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.klef.jfsd.springboot.model.Booking;
import com.klef.jfsd.springboot.model.BookingStatus;
import com.klef.jfsd.springboot.model.User;
import com.klef.jfsd.springboot.model.UserRole;
import com.klef.jfsd.springboot.service.BookingService;
import com.klef.jfsd.springboot.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/users")
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private BookingService bookingService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "user/register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user) {
        if (user.getRole() == null) {
            user.setRole(UserRole.USER); // Set a default role, e.g., USER
        }
        userService.createUser(user);
        return "redirect:/users/login";
    }


    @GetMapping("/login")
    public String showLoginForm() {
        return "user/login";
    }
    
    
    @PostMapping("/login")
    public String loginUser(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        // Authenticate user
        User user = userService.authenticateUser(email, password);

        if (user != null) {
            // Store authenticated user in session
            session.setAttribute("loggedInUser", user);
            return "redirect:/users/dashboard"; // Redirect to user dashboard
        } else {
            // Add error message to model
            model.addAttribute("error", "Invalid email or password");
            return "user/login"; // Redirect back to login.jsp
        }
    }
    
    
    @GetMapping("/dashboard")
    public String showUserDashboard(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            Long userId = loggedInUser.getId();
            model.addAttribute("user", loggedInUser);
            model.addAttribute("bookings", bookingService.getRecentBookingsByUser(userId));
            return "user/dashboard"; // Update JSP file path if necessary
        } else {
            return "redirect:/users/login";
        }
    }



    @GetMapping("/profile")
    public String showProfile(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            model.addAttribute("user", loggedInUser);
            return "user/profile"; // Display the profile update form
        } else {
            return "redirect:/users/login";
        }
    }

    // Handle profile update submission
    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute User user, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            // Update the user profile in the database
            user.setId(loggedInUser.getId()); // Make sure the ID stays the same
            userService.updateUser(user); // Call the service to update the user

            // Update the session with the new user details
            session.setAttribute("loggedInUser", user);

            return "redirect:/users/dashboard"; // Redirect to the dashboard after update
        } else {
            return "redirect:/users/login";
        }
    }
    
    @GetMapping("/bookings/user")
    public String showMyBookings(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            Long userId = loggedInUser.getId();
            model.addAttribute("bookings", bookingService.getBookingsByUser(userId));
            return "user/mybookings"; // Corresponds to the JSP file
        } else {
            return "redirect:/users/login";
        }
    }
    
    
    @GetMapping("/users")
    public String getUserBookings(@RequestParam(required = false) String status,
                                Model model, 
                                HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/users/login";
        }

        List<Booking> bookings;
        if (status != null && !status.equals("all")) {
            BookingStatus bookingStatus = BookingStatus.valueOf(status.toUpperCase());
            bookings = bookingService.getBookingsByUserAndStatus(user.getId(), bookingStatus);
        } else {
            bookings = bookingService.getBookingsByUserId(user.getId());
        }

        model.addAttribute("bookings", bookings);
        return "booking/list";
    }

}