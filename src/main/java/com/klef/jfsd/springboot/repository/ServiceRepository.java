package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.klef.jfsd.springboot.model.Service;
import com.klef.jfsd.springboot.model.ServiceStatus;

import java.util.List;
import java.util.Optional;

public interface ServiceRepository extends JpaRepository<Service, Long> {
    List<Service> findByProfessionalId(Long professionalId);
    List<Service> findByCategory(String category);
    List<Service> findByIsAvailableTrue();
    
    Optional<Service> findById(Long id);
    
    

    List<Service> findByStatus(ServiceStatus status);
    
    List<Service> findByTitleContainingIgnoreCase(String keyword);
}