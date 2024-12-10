package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.klef.jfsd.springboot.model.User;
import com.klef.jfsd.springboot.model.UserRole;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    
    boolean existsByEmail(String email);
    User findByEmail(String email);
    
    User findByEmailAndPasswordAndRole(String email, String password, UserRole role);

}