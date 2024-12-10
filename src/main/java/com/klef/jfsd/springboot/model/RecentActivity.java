package com.klef.jfsd.springboot.model;



import lombok.Data;
import java.time.LocalDateTime;

@Data
public class RecentActivity {
    private String description;
    private String user;
    private LocalDateTime date;
    private String status;
    
    public RecentActivity(String description, String user, LocalDateTime date, String status) {
        this.description = description;
        this.user = user;
        this.date = date;
        this.status = status;
    }
    
    // Getters and setters
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getUser() {
        return user;
    }
    
    public void setUser(String user) {
        this.user = user;
    }
    
    public LocalDateTime getDate() {
        return date;
    }
    
    public void setDate(LocalDateTime date) {
        this.date = date;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
}