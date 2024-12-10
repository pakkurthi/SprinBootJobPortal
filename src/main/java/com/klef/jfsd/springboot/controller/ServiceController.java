package com.klef.jfsd.springboot.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klef.jfsd.springboot.model.Professional;
import com.klef.jfsd.springboot.model.Service;
import com.klef.jfsd.springboot.model.ServiceStatus;
import com.klef.jfsd.springboot.model.User;
import com.klef.jfsd.springboot.service.BookingService;
import com.klef.jfsd.springboot.service.ServiceService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/services")
public class ServiceController {
    
    @Autowired
    private ServiceService serviceService;
    
    
    @Autowired
    private BookingService bookingService;
    
    @GetMapping("/available")
    public String showAvailableServices(Model model) {
        List<Service> services = serviceService.getAvailableServices();
        model.addAttribute("services", services);
        return "services/available";
    }
    
    @GetMapping("/{id}")
    public String getServiceDetails(@PathVariable Long id, Model model) {
        serviceService.getServiceById(id).ifPresent(service -> {
            model.addAttribute("service", service);
        });
        return "services/details";
    }

    @GetMapping("/search")
    public String searchServices(@RequestParam(required = false) String keyword, Model model) {
        List<Service> services;
        if (keyword != null && !keyword.trim().isEmpty()) {
            services = serviceService.searchServices(keyword);
        } else {
            services = serviceService.getAvailableServices();
        }
        model.addAttribute("services", services);
        return "service/search";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (!(user instanceof Professional)) {
            return "redirect:/login";
        }
        model.addAttribute("service", new Service());
        return "service/create";
    }

    @PostMapping("/create")
    public String createService(@ModelAttribute Service service, 
                              HttpSession session, 
                              RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (!(user instanceof Professional)) {
            return "redirect:/login";
        }

        service.setProfessional((Professional) user);
        service.setStatus(ServiceStatus.PENDING_REVIEW);
        service.setAvailable(true);
        serviceService.createService(service);
        redirectAttributes.addFlashAttribute("success", "Service created successfully");
        return "redirect:/professionals/dashboard";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (!(user instanceof Professional)) {
            return "redirect:/login";
        }

        Service service = serviceService.getServiceById(id)
            .orElseThrow(() -> new RuntimeException("Service not found"));

        if (!service.getProfessional().getId().equals(user.getId())) {
            return "redirect:/professionals/dashboard";
        }

        model.addAttribute("service", service);
        return "service/edit";
    }

    @PostMapping("/{id}/edit")
    public String updateService(@PathVariable Long id, 
                              @ModelAttribute Service service,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (!(user instanceof Professional)) {
            return "redirect:/login";
        }

        Service existingService = serviceService.getServiceById(id)
            .orElseThrow(() -> new RuntimeException("Service not found"));

        if (!existingService.getProfessional().getId().equals(user.getId())) {
            return "redirect:/professionals/dashboard";
        }

        service.setId(id);
        service.setProfessional((Professional) user);
        serviceService.updateService(service);
        
        redirectAttributes.addFlashAttribute("success", "Service updated successfully");
        return "redirect:/professionals/dashboard";
    }

    @PostMapping("/{id}/delete")
    public String deleteService(@PathVariable Long id,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (!(user instanceof Professional)) {
            return "redirect:/login";
        }

        Service service = serviceService.getServiceById(id)
            .orElseThrow(() -> new RuntimeException("Service not found"));

        if (!service.getProfessional().getId().equals(user.getId())) {
            return "redirect:/professionals/dashboard";
        }

        serviceService.deleteService(id);
        redirectAttributes.addFlashAttribute("success", "Service deleted successfully");
        return "redirect:/professionals/dashboard";
    }
}
