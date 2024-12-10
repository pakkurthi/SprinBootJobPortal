package com.klef.jfsd.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.klef.jfsd.springboot.model.Professional;
import com.klef.jfsd.springboot.model.User;
import com.klef.jfsd.springboot.service.BookingService;
import com.klef.jfsd.springboot.service.ProfessionalService;
import com.klef.jfsd.springboot.service.UserService;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ProfessionalService professionalService;
    
    @Autowired
    private BookingService bookingService;

    @GetMapping("/dashboard")
    public String showDashboard(Model model, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null) {
            return "redirect:/admin/alogin";
        }

        Map<String, Object> statistics = new HashMap<>();
        statistics.put("totalUsers", userService.getUserCount());
        statistics.put("totalProfessionals", professionalService.getProfessionalCount());
        statistics.put("totalBookings", bookingService.getBookingCount());
        statistics.put("pendingVerifications", professionalService.getPendingVerificationsCount());

        model.addAttribute("statistics", statistics);
        model.addAttribute("recentActivities", bookingService.getRecentActivities());
        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("professionals", professionalService.getAllProfessionals());
        
        return "admin/dashboard";
    }

    @GetMapping("/users")
    public String manageUsers(Model model, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null) {
            return "redirect:/admin/alogin";
        }
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users";
    }

    @GetMapping("/professionals")
    public String manageProfessionals(Model model, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null) {
            return "redirect:/admin/alogin";
        }
        model.addAttribute("professionals", professionalService.getAllProfessionals());
        return "admin/professionals";
    }

    @GetMapping("/users/{id}")
    @ResponseBody
    public ResponseEntity<?> getUserDetails(@PathVariable Long id) {
        return userService.getUserById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/professionals/{id}")
    @ResponseBody
    public ResponseEntity<?> getProfessionalDetails(@PathVariable Long id) {
        return professionalService.getProfessionalById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Long id, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        try {
            userService.deleteUserPermanently(id);
            session.setAttribute("message", "User deleted successfully");
        } catch (Exception e) {
            session.setAttribute("error", "Failed to delete user: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    @PostMapping("/professionals/delete/{id}")
    public String deleteProfessional(@PathVariable Long id, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        try {
            professionalService.deleteProfessionalPermanently(id);
            session.setAttribute("message", "Professional deleted successfully");
        } catch (Exception e) {
            session.setAttribute("error", "Failed to delete professional: " + e.getMessage());
        }
        return "redirect:/admin/professionals";
    }

    @PostMapping("/professionals/{id}/verify")
    @ResponseBody
    public ResponseEntity<?> verifyProfessional(@PathVariable Long id) {
        try {
            Professional professional = professionalService.getProfessionalById(id)
                .orElseThrow(() -> new RuntimeException("Professional not found"));
            professional.setVerified(true);
            professionalService.updateProfessional(professional);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Failed to verify professional: " + e.getMessage());
        }
    }

    @GetMapping("/alogin")
    public String showLoginForm() {
        return "admin/login";
    }

    @PostMapping("/alogin")
    public String loginUser(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {
        User user = userService.authenticateAdmin(email, password);
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            return "redirect:/admin/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "admin/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/alogin";
    }

    @PostMapping("/users/edit/{id}")
    public String updateUser(@PathVariable Long id, @ModelAttribute User updatedUser, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null) {
            return "redirect:/admin/alogin";
        }
        
        try {
            Optional<User> existingUser = userService.getUserById(id);
            if (existingUser.isPresent()) {
                User user = existingUser.get();
                // Update only the allowed fields
                user.setName(updatedUser.getName());
                user.setEmail(updatedUser.getEmail());
                user.setRole(updatedUser.getRole());
                user.setActive(updatedUser.isActive());
                
                userService.updateUser(user);
                return "redirect:/admin/users";
            }
            return "redirect:/admin/users?error=usernotfound";
        } catch (Exception e) {
            return "redirect:/admin/users?error=updatefailed";
        }
    }

    @GetMapping("/users/edit/{id}")
    public String showEditUserForm(@PathVariable Long id, Model model, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null) {
            return "redirect:/admin/alogin";
        }
        
        Optional<User> user = userService.getUserById(id);
        if (user.isPresent()) {
            model.addAttribute("user", user.get());
            return "admin/editUser";
        }
        return "redirect:/admin/users";
    }

    @GetMapping("/professionals/edit/{id}")
    public String showEditProfessionalForm(@PathVariable Long id, Model model, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        Optional<Professional> professional = professionalService.getProfessionalById(id);
        if (professional.isPresent()) {
            model.addAttribute("professional", professional.get());
            return "admin/editProfessional";
        }
        return "redirect:/admin/professionals";
    }

    @PostMapping("/professionals/edit/{id}")
    public String updateProfessional(@PathVariable Long id, @ModelAttribute Professional professional, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        
        try {
            professionalService.updateProfessional(professional);
            session.setAttribute("message", "Professional updated successfully");
        } catch (Exception e) {
            session.setAttribute("error", "Failed to update professional: " + e.getMessage());
        }
        return "redirect:/admin/professionals";
    }
}
