package com.klef.jfsd.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.User;
import com.klef.jfsd.springboot.model.UserRole;
import com.klef.jfsd.springboot.repository.UserRepository;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserRepository userRepository;

    @Override
    public User createUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public User updateUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    @Override
    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    
    @Override
    public void deleteUserPermanently(Long id) {
        userRepository.deleteById(id);
    }
    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }
    
    @Override
    public User authenticateUser(String email, String password) {
        // Find user by email
        User user = userRepository.findByEmail(email);

        // Validate password
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null; // Return null if authentication fails
    }

    @Override
    public User authenticateAdmin(String email, String password) {
        return userRepository.findByEmailAndPasswordAndRole(email, password, UserRole.ADMIN);
    }

    @Override
    public long getUserCount() {
        return userRepository.count();
    }

	

}