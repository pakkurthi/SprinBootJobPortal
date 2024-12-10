package com.klef.jfsd.springboot.model;


import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "users")
@Inheritance(strategy = InheritanceType.JOINED)
public class User {
 @Id
 @GeneratedValue(strategy = GenerationType.IDENTITY)
 private Long id;

 @Column(nullable = true)
 private String name;

 @Column(unique = true, nullable = false)
 private String email;

 @Column(nullable = false)
 private String password;

 @Column(nullable = false)
 @Enumerated(EnumType.STRING)
 private UserRole role;

 private String phoneNumber;
 private String address;
 private String city;
 private String state;
 private String country;

 @Column(nullable = true)
 private LocalDateTime createdAt;

 private LocalDateTime lastLogin;
 private boolean isActive;

 @PrePersist
 protected void onCreate() {
     createdAt = LocalDateTime.now();
     isActive = true;
     if (role == null) {
         role = UserRole.USER; // Set default role
     }
 }


public Long getId() {
	return id;
}

public void setId(Long id) {
	this.id = id;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public String getPassword() {
	return password;
}

public void setPassword(String password) {
	this.password = password;
}

public UserRole getRole() {
	return role;
}

public void setRole(UserRole role) {
	this.role = role;
}

public String getPhoneNumber() {
	return phoneNumber;
}

public void setPhoneNumber(String phoneNumber) {
	this.phoneNumber = phoneNumber;
}

public String getAddress() {
	return address;
}

public void setAddress(String address) {
	this.address = address;
}

public String getCity() {
	return city;
}

public void setCity(String city) {
	this.city = city;
}

public String getState() {
	return state;
}

public void setState(String state) {
	this.state = state;
}

public String getCountry() {
	return country;
}

public void setCountry(String country) {
	this.country = country;
}

public LocalDateTime getCreatedAt() {
	return createdAt;
}

public void setCreatedAt(LocalDateTime createdAt) {
	this.createdAt = createdAt;
}

public LocalDateTime getLastLogin() {
	return lastLogin;
}

public void setLastLogin(LocalDateTime lastLogin) {
	this.lastLogin = lastLogin;
}

public boolean isActive() {
	return isActive;
}

public void setActive(boolean isActive) {
	this.isActive = isActive;
}
 
 
}
