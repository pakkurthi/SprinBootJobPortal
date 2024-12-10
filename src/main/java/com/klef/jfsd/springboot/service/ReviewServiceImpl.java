package com.klef.jfsd.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Professional;
import com.klef.jfsd.springboot.model.Review;
import com.klef.jfsd.springboot.repository.ProfessionalRepository;
import com.klef.jfsd.springboot.repository.ReviewRepository;

import java.util.List;
import java.util.Optional;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private ProfessionalRepository professionalRepository;

    @Override
    public Review createReview(Review review) {
        Review savedReview = reviewRepository.save(review);
        updateProfessionalRating(review.getProfessional().getId());
        return savedReview;
    }

    @Override
    public Review updateReview(Review review) {
        Review updatedReview = reviewRepository.save(review);
        updateProfessionalRating(review.getProfessional().getId());
        return updatedReview;
    }

    @Override
    public void deleteReview(Long id) {
        Review review = reviewRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Review not found"));
        Long professionalId = review.getProfessional().getId();
        reviewRepository.deleteById(id);
        updateProfessionalRating(professionalId);
    }

    @Override
    public Optional<Review> getReviewById(Long id) {
        return reviewRepository.findById(id);
    }

    @Override
    public List<Review> getReviewsByProfessionalId(Long professionalId) {
        return reviewRepository.findByProfessionalId(professionalId);
    }

    @Override
    public List<Review> getReviewsByUserId(Long userId) {
        return reviewRepository.findByUserId(userId);
    }

    @Override
    public double calculateAverageRating(Long professionalId) {
        List<Review> reviews = reviewRepository.findByProfessionalId(professionalId);
        if (reviews.isEmpty()) {
            return 0.0;
        }
        double sum = reviews.stream()
                .mapToInt(Review::getRating)
                .sum();
        return sum / reviews.size();
    }

    private void updateProfessionalRating(Long professionalId) {
        Professional professional = professionalRepository.findById(professionalId)
                .orElseThrow(() -> new RuntimeException("Professional not found"));
        double averageRating = calculateAverageRating(professionalId);
        professional.setAverageRating(averageRating);
        professionalRepository.save(professional);
    }
}