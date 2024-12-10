package com.klef.jfsd.springboot.service;


import org.springframework.web.multipart.MultipartFile;

import com.klef.jfsd.springboot.model.Professional;
import com.klef.jfsd.springboot.model.Service;

import java.util.List;
import java.util.Optional;

public interface ProfessionalService {
    Professional createProfessional(Professional professional);
    Professional updateProfessional(Professional professional);
    void deleteProfessional(Long id);
    Optional<Professional> getProfessionalById(Long id);
    List<Professional> getAllProfessionals();
    List<Professional> findBySkills(String skills);
    List<Professional> findByCity(String city);
    String uploadResume(Long professionalId, MultipartFile file);
    byte[] downloadResume(Long professionalId);
    
    Professional authenticateProfessional(String email, String password);
    
    void addService(Professional professional, Service service);
    
    List<Service> getAllProfessionalServices();
    
    Optional<Service> getServiceById(Long serviceId);
    
    long getProfessionalCount();
    
    
    
    void deleteProfessionalPermanently(Long id);
    long getPendingVerificationsCount();

}