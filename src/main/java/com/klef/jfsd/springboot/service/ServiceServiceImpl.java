package com.klef.jfsd.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import com.klef.jfsd.springboot.model.Service;
import com.klef.jfsd.springboot.model.ServiceStatus;
import com.klef.jfsd.springboot.repository.ServiceRepository;
import java.util.List;
import java.util.Optional;

@org.springframework.stereotype.Service
public class ServiceServiceImpl implements ServiceService {
    
    @Autowired
    private ServiceRepository serviceRepository;

    @Override
    public Service createService(Service service) {
        return serviceRepository.save(service);
    }

    @Override
    public Service updateService(Service service) {
        return serviceRepository.save(service);
    }

    @Override
    public void deleteService(Long id) {
        serviceRepository.deleteById(id);
    }

    @Override
    public Optional<Service> getServiceById(Long id) {
        return serviceRepository.findById(id);
    }

    @Override
    public List<Service> getAllServices() {
        return serviceRepository.findAll();
    }

    @Override
    public List<Service> getServicesByProfessional(Long professionalId) {
        return serviceRepository.findByProfessionalId(professionalId);
    }

    @Override
    public List<Service> getServicesByCategory(String category) {
        return serviceRepository.findByCategory(category);
    }

    @Override
    public List<Service> getServicesByStatus(ServiceStatus status) {
        return serviceRepository.findByStatus(status);
    }

    @Override
    public List<Service> getAvailableServices() {
        return serviceRepository.findByIsAvailableTrue();
    }

    @Override
    public List<Service> searchServices(String keyword) {
        return serviceRepository.findByTitleContainingIgnoreCase(keyword);
    }
}