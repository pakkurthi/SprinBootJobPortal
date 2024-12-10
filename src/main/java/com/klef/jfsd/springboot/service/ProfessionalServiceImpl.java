package com.klef.jfsd.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.multipart.MultipartFile;

import com.klef.jfsd.springboot.model.Professional;
import com.klef.jfsd.springboot.model.Service;
import com.klef.jfsd.springboot.repository.ProfessionalRepository;
import com.klef.jfsd.springboot.repository.ServiceRepository;

import jakarta.transaction.Transactional;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

@org.springframework.stereotype.Service
public class ProfessionalServiceImpl implements ProfessionalService {
    
    @Autowired
    private ProfessionalRepository professionalRepository;
    

    @Autowired
    private ServiceRepository serviceRepository;
    
    private final Path resumeStorageLocation = Paths.get("uploads/resumes");

    public ProfessionalServiceImpl() {
        try {
            Files.createDirectories(resumeStorageLocation);
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload directory", e);
        }
    }

    @Override
    public Professional createProfessional(Professional professional) {
        return professionalRepository.save(professional);
    }

    @Override
    public Professional updateProfessional(Professional professional) {
        return professionalRepository.save(professional);
    }

    @Override
    public void deleteProfessional(Long id) {
        professionalRepository.deleteById(id);
    }

    @Override
    public Optional<Professional> getProfessionalById(Long id) {
        return professionalRepository.findById(id);
    }

    @Override
    public List<Professional> getAllProfessionals() {
        return professionalRepository.findAll();
    }

    @Override
    public List<Professional> findBySkills(String skills) {
        return professionalRepository.findBySkillsContainingIgnoreCase(skills);
    }

    @Override
    public List<Professional> findByCity(String city) {
        return professionalRepository.findByCity(city);
    }

    @Override
    public String uploadResume(Long professionalId, MultipartFile file) {
        try {
            String fileName = professionalId + "_" + file.getOriginalFilename();
            Path targetLocation = resumeStorageLocation.resolve(fileName);
            Files.copy(file.getInputStream(), targetLocation);
            
            Professional professional = professionalRepository.findById(professionalId)
                .orElseThrow(() -> new RuntimeException("Professional not found"));
            professional.setResumePath(fileName);
            professionalRepository.save(professional);
            
            return fileName;
        } catch (IOException e) {
            throw new RuntimeException("Could not store resume", e);
        }
    }

    @Override
    public byte[] downloadResume(Long professionalId) {
        try {
            Professional professional = professionalRepository.findById(professionalId)
                .orElseThrow(() -> new RuntimeException("Professional not found"));
            Path filePath = resumeStorageLocation.resolve(professional.getResumePath());
            return Files.readAllBytes(filePath);
        } catch (IOException e) {
            throw new RuntimeException("Could not read resume", e);
        }
    }
    
    @Override
    public Professional authenticateProfessional(String email, String password) {
        // Find professional by email
        Professional professional = professionalRepository.findByEmail(email);

        // Validate password
        if (professional != null && professional.getPassword().equals(password)) {
            return professional;
        }
        return null; // Return null if authentication fails
    }
    
    @Override
    public List<Service> getAllProfessionalServices() {
        return professionalRepository.findAllProfessionalServices();
    }
    
    
    @Override
    @Transactional
    public void addService(Professional professional, Service service) {
    	
    	
        // Add the new service to the professional's set of services
        professional.getServices().add(service);
        serviceRepository.save(service); // Save the new service
        professionalRepository.save(professional); // Save the updated professional
    }
    
    @Override
    public Optional<Service> getServiceById(Long serviceId) {
        return serviceRepository.findById(serviceId);
    }

	@Override
	public long getProfessionalCount() {
		return professionalRepository.count();
	}
	 @Override
	    public void deleteProfessionalPermanently(Long id) {
	        professionalRepository.deleteById(id);
	    }

	
	 @Override
	    public long getPendingVerificationsCount() {
	        return professionalRepository.countPendingVerifications();
	    }
}