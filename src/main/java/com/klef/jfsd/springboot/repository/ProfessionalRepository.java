package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.klef.jfsd.springboot.model.Professional;
import com.klef.jfsd.springboot.model.Service;

import java.util.List;

public interface ProfessionalRepository extends JpaRepository<Professional, Long> {
    List<Professional> findBySkillsContainingIgnoreCase(String skills);
    List<Professional> findByCity(String city);
    
    @Query("SELECT p FROM Professional p WHERE p.isVerified = true AND p.isActive = true")
    List<Professional> findAllVerifiedAndActive();
    
    Professional findByEmail(String email);
    
    
    
    @Query("SELECT COUNT(p) FROM Professional p WHERE p.isVerified = false")
    long countPendingVerifications();
    
    @Query("SELECT s FROM Professional p JOIN p.services s")
    List<Service> findAllProfessionalServices();
}