package com.klef.jfsd.springboot.model;



import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "support_tickets")
public class SupportTicket {
 @Id
 @GeneratedValue(strategy = GenerationType.IDENTITY)
 private Long id;

 @ManyToOne
 @JoinColumn(name = "user_id", nullable = false)
 private User user;

 @ManyToOne
 @JoinColumn(name = "support_agent_id")
 private User supportAgent;

 private String subject;

 @Column(length = 1000)
 private String description;

 @Enumerated(EnumType.STRING)
 private TicketStatus status;

 @Enumerated(EnumType.STRING)
 private TicketPriority priority;

 private LocalDateTime createdAt;
 private LocalDateTime updatedAt;
 private LocalDateTime resolvedAt;

 @PrePersist
 protected void onCreate() {
     createdAt = LocalDateTime.now();
     updatedAt = LocalDateTime.now();
 }

 @PreUpdate
 protected void onUpdate() {
     updatedAt = LocalDateTime.now();
 }

public Long getId() {
	return id;
}

public void setId(Long id) {
	this.id = id;
}

public User getUser() {
	return user;
}

public void setUser(User user) {
	this.user = user;
}

public User getSupportAgent() {
	return supportAgent;
}

public void setSupportAgent(User supportAgent) {
	this.supportAgent = supportAgent;
}

public String getSubject() {
	return subject;
}

public void setSubject(String subject) {
	this.subject = subject;
}

public String getDescription() {
	return description;
}

public void setDescription(String description) {
	this.description = description;
}

public TicketStatus getStatus() {
	return status;
}

public void setStatus(TicketStatus status) {
	this.status = status;
}

public TicketPriority getPriority() {
	return priority;
}

public void setPriority(TicketPriority priority) {
	this.priority = priority;
}

public LocalDateTime getCreatedAt() {
	return createdAt;
}

public void setCreatedAt(LocalDateTime createdAt) {
	this.createdAt = createdAt;
}

public LocalDateTime getUpdatedAt() {
	return updatedAt;
}

public void setUpdatedAt(LocalDateTime updatedAt) {
	this.updatedAt = updatedAt;
}

public LocalDateTime getResolvedAt() {
	return resolvedAt;
}

public void setResolvedAt(LocalDateTime resolvedAt) {
	this.resolvedAt = resolvedAt;
}
}