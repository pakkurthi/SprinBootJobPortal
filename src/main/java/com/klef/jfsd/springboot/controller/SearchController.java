package com.klef.jfsd.springboot.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.klef.jfsd.springboot.model.Service;
import com.klef.jfsd.springboot.service.ServiceService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/search")
public class SearchController {

    @Autowired
    private ServiceService serviceService;

    @GetMapping
    public String showSearchPage(@RequestParam(required = false) String keyword, Model model, HttpSession session) {
        List<Service> services = serviceService.getAllServices();
        System.out.println("Retrieved Services: " + services); // Debugging
        model.addAttribute("services", services);
        return "user/search";
    }

}