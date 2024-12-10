package com.klef.jfsd.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klef.jfsd.springboot.model.Professional;
import com.klef.jfsd.springboot.model.Service;
import com.klef.jfsd.springboot.model.UserRole;
import com.klef.jfsd.springboot.service.ProfessionalService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
@RequestMapping("/professionals")
public class ProfessionalController {
    
    @Autowired
    private ProfessionalService professionalService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("professional", new Professional());
        return "professionals/register";
    }

    @PostMapping("/register")
    public String registerProfessional(@ModelAttribute Professional professional) {
        if (professional.getName() == null || professional.getName().isEmpty()) {
            throw new IllegalArgumentException("Name is required");
        }
        professional.setRole(UserRole.PROFESSIONAL); // Set default role for Professional
        professionalService.createProfessional(professional);
        return "redirect:/professionals/login";
    }


    @GetMapping("/profile")
    public String showProfile(Model model) {
        Long professionalId = 1L; // Replace with actual session handling
        professionalService.getProfessionalById(professionalId)
            .ifPresent(professional -> model.addAttribute("professional", professional));
        return "professionals/profile";
    }
    
    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute Professional professional, HttpSession session, RedirectAttributes redirectAttributes) {
        Professional loggedInProfessional = (Professional) session.getAttribute("loggedInProfessional");
        if (loggedInProfessional == null) {
            return "redirect:/professionals/login";
        }

        loggedInProfessional.setName(professional.getName());
        loggedInProfessional.setTitle(professional.getTitle());
        loggedInProfessional.setBio(professional.getBio());
        loggedInProfessional.setSkills(professional.getSkills());
        loggedInProfessional.setHourlyRate(professional.getHourlyRate());

        professionalService.updateProfessional(loggedInProfessional);

        // Add success message as flash attribute
        redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");

        return "redirect:/professionals/profile"; // Redirect back to the profile page
    }

    
    @PostMapping("/resume/upload")
    public String uploadResume(@RequestParam("file") MultipartFile file) {
        Long professionalId = 1L; // Replace with actual session handling
        professionalService.uploadResume(professionalId, file);
        return "redirect:/professionals/profile";
    }

    @GetMapping("/resume/download/{professionalId}")
    public ResponseEntity<ByteArrayResource> downloadResume(@PathVariable Long professionalId) {
        byte[] data = professionalService.downloadResume(professionalId);
        ByteArrayResource resource = new ByteArrayResource(data);
        
        return ResponseEntity.ok()
            .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=resume.pdf")
            .contentType(MediaType.APPLICATION_PDF)
            .contentLength(data.length)
            .body(resource);
    }
    
    
    
    @GetMapping("/login")
    public String showLoginPage() {
        return "professionals/login"; // Maps to login.jsp
    }

    // Login POST - Authenticate professional
    @PostMapping("/login")
    public String loginProfessional(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        // Authenticate professional
        Professional professional = professionalService.authenticateProfessional(email, password);

        if (professional != null) {
            // Store authenticated professional in session
            session.setAttribute("loggedInProfessional", professional);
            return "redirect:/professionals/dashboard"; // Redirect to dashboard page
        } else {
            // Add error message to model
            model.addAttribute("error", "Invalid email or password");
            return "professionals/login"; // Redirect back to login.jsp
        }
    }
    @Transactional
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Professional loggedInProfessional = (Professional) session.getAttribute("loggedInProfessional");

        if (loggedInProfessional == null) {
            return "redirect:/professionals/login"; // Redirect to login if not authenticated
        }

        // Add any data you want to display on the dashboard
        model.addAttribute("professional", loggedInProfessional);
        return "professionals/dashboard"; // Maps to dashboard.jsp
    }


    // Logout
    @GetMapping("/logout")
    public String logoutProfessional(HttpSession session) {
        session.invalidate(); // Invalidate session
        return "redirect:/professionals/login"; // Redirect to login page
    }
    
    
    
    
    @GetMapping("/services/add")
    public String showAddServiceForm(HttpSession session, Model model) {
        Professional loggedInProfessional = (Professional) session.getAttribute("loggedInProfessional");

        if (loggedInProfessional == null) {
            return "redirect:/professionals/login"; // Redirect to login if not authenticated
        }

        model.addAttribute("service", new Service()); // Bind a new Service object to the form
        return "professionals/add-service"; // Maps to add-service.jsp
    }

    @PostMapping("/services/add")
    public String addService(@ModelAttribute Service service, HttpSession session) {
        Professional loggedInProfessional = (Professional) session.getAttribute("loggedInProfessional");

        if (loggedInProfessional == null) {
            return "redirect:/professionals/login"; // Redirect to login if not authenticated
        }

        // Fetch the Professional entity from the database
        Professional professionalWithServices = professionalService.getProfessionalById(loggedInProfessional.getId())
                .orElseThrow(() -> new RuntimeException("Professional not found"));

        // Associate the service with the logged-in professional
        service.setProfessional(professionalWithServices);
        professionalService.addService(professionalWithServices, service);

        return "redirect:/professionals/dashboard"; // Redirect back to dashboard after adding service
    }

}