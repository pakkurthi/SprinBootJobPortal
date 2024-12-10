package com.klef.jfsd.springboot.service;

import java.util.List;
import java.util.Optional;

import com.klef.jfsd.springboot.model.Review;

public interface ReviewService {
    Review createReview(Review review);
    Review updateReview(Review review);
    void deleteReview(Long id);
    Optional<Review> getReviewById(Long id);
    List<Review> getReviewsByProfessionalId(Long professionalId);
    List<Review> getReviewsByUserId(Long userId);
    double calculateAverageRating(Long professionalId);
}