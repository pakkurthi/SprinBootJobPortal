package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.klef.jfsd.springboot.model.SupportTicket;
import com.klef.jfsd.springboot.model.TicketStatus;

import java.util.List;

public interface SupportTicketRepository extends JpaRepository<SupportTicket, Long> {
    List<SupportTicket> findByUserId(Long userId);
    List<SupportTicket> findBySupportAgentId(Long supportAgentId);
    List<SupportTicket> findByStatus(TicketStatus status);
}