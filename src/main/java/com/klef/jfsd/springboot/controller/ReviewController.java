package com.klef.jfsd.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.klef.jfsd.springboot.model.Review;
import com.klef.jfsd.springboot.service.ReviewService;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @GetMapping("/professional/{professionalId}")
    public String getProfessionalReviews(@PathVariable Long professionalId, Model model) {
        model.addAttribute("reviews", reviewService.getReviewsByProfessionalId(professionalId));
        return "review/professional-reviews";
    }

    @GetMapping("/create/{bookingId}")
    public String showReviewForm(@PathVariable Long bookingId, Model model) {
        model.addAttribute("review", new Review());
        model.addAttribute("bookingId", bookingId);
        return "review/create";
    }

    @PostMapping("/create")
    public String createReview(@ModelAttribute Review review) {
        reviewService.createReview(review);
        return "redirect:/bookings/user";
    }

    @PostMapping("/{id}/delete")
    public String deleteReview(@PathVariable Long id) {
        reviewService.deleteReview(id);
        return "redirect:/reviews/professional/" + id;
    }
}