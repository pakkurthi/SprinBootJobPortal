package com.klef.jfsd.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.klef.jfsd.springboot.service.ProfessionalService;

@Controller
@RequestMapping("/professionals")
public class ProfessionalListController {

    @Autowired
    private ProfessionalService professionalService;

    @GetMapping("/list")
    public String listProfessionals(Model model) {
        model.addAttribute("professionals", professionalService.getAllProfessionals());
        return "professionals/list";
    }
}