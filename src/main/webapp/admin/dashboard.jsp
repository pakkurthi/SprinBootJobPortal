<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="../shared/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-4">
    <div class="row mb-4">
        <div class="col">
            <h2 class="h3">Admin Dashboard</h2>
        </div>
    </div>
    <div class="row g-4">
        <!-- Statistics Cards -->
      
        
        <c:forEach items="${statistics}" var="entry">
    <div class="col-md-3">
        <div class="card h-100">
            <div class="card-body">
                <h6 class="card-subtitle mb-2 text-muted">${entry.key}</h6>
                <h2 class="card-title mb-0">${entry.value}</h2>
                <!-- <h6 class="card-subtitle mb-2 text-muted">${stat.title}</h6>-->
            </div>
        </div>
    </div>
</c:forEach>
        

        <!-- Recent Activities -->
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Recent Activities</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Activity</th>
                                    <th>User</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentActivities}" var="activity">
                                    <tr>
                                        <td>${activity.description}</td>
                                        <td>${activity.user}</td>
                                        <td>${activity.date}</td>
                                        <td>
                                            <span class="badge bg-${activity.status == 'COMPLETED' ? 'success' : 'warning'}">
                                                ${activity.status}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Quick Actions</h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="/admin/users" class="btn btn-outline-primary">Manage Users</a>
                        <a href="/admin/professionals" class="btn btn-outline-primary">Manage Professionals</a>
                        <a href="/admin/services" class="btn btn-outline-primary">Manage Services</a>
                        <a href="/admin/tickets" class="btn btn-outline-primary">Support Tickets</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="../shared/footer.jsp" %>