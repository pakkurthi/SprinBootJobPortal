package com.klef.jfsd.springboot.service;

import java.util.List;
import java.util.Optional;

import com.klef.jfsd.springboot.model.User;

public interface UserService {
    User createUser(User user);
    User updateUser(User user);
    void deleteUser(Long id);
    Optional<User> getUserById(Long id);
    
    List<User> getAllUsers();
    boolean existsByEmail(String email);
    User authenticateUser(String email, String password);
    
    
   
    User authenticateAdmin(String email, String password);
    long getUserCount();
    void deleteUserPermanently(Long id);
}