<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Professionals</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">
                ${sessionScope.message}
                <% session.removeAttribute("message"); %>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                ${sessionScope.error}
                <% session.removeAttribute("error"); %>
            </div>
        </c:if>
        
        <h2>Manage Professionals</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Skills</th>
                    <th>Verification Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${professionals}" var="professional">
                    <tr>
                        <td>${professional.name}</td>
                        <td>${professional.email}</td>
                        <td>${professional.skills}</td>
                        <td>
                            <span class="badge bg-${professional.verified ? 'success' : 'warning'}">
                                ${professional.verified ? 'Verified' : 'Pending'}
                            </span>
                        </td>
                        <td>
                             <a href="/admin/professionals/edit/${professional.id}" class="btn btn-primary btn-sm">Edit</a>
                            <form action="/admin/professionals/delete/${professional.id}" method="post" style="display: inline;"
                                  onsubmit="return confirm('Are you sure you want to permanently delete this professional?');">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
