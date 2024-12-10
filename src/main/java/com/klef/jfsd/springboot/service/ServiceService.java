package com.klef.jfsd.springboot.service;

import java.util.List;
import java.util.Optional;
import com.klef.jfsd.springboot.model.Service;
import com.klef.jfsd.springboot.model.ServiceStatus;

public interface ServiceService {
    Service createService(Service service);
    Service updateService(Service service);
    void deleteService(Long id);
    Optional<Service> getServiceById(Long id);
    List<Service> getAllServices();
    List<Service> getServicesByProfessional(Long professionalId);
    List<Service> getServicesByCategory(String category);
    List<Service> getServicesByStatus(ServiceStatus status);
    List<Service> getAvailableServices();
    List<Service> searchServices(String keyword);

}