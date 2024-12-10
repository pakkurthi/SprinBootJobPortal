<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="../shared/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm border-2 border-black bg-black text-white">
                <div class="card-body p-5">
                    <h2 class="text-center mb-4 text-white">Admin Login</h2>
                    
                    <c:if test="${error != null}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>
                    
                    <form action="/admin/alogin" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label text-white">Email address</label>
                            <input type="email" class="form-control border-2 border-gray-500 bg-gray-900 text-white" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label text-white">Password</label>
                            <input type="password" class="form-control border-2 border-gray-500 bg-gray-900 text-white" id="password" name="password" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-warning">Login</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../shared/footer.jsp" %>
