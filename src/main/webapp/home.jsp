<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Quest Hunt </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .navbar-brand img {
            height: 40px;
        }
        .dropdown-large {
            min-width: 300px;
            padding: 1rem;
        }
        .nav-link {
            color: #8EB486 !important;
        }
        .nav-link:hover {
            color: #FDF7F4 !important;
        }
        .btn-outline-primary {
            border-width: 2px;
        }
        .dropdown-menu {
            border-radius: 0.5rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="/">
                <span class="fw-bold text-primary">JobQuest</span>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link px-3" href="/professionals">Search clients</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="/services">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="/about">About JQ</a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <!-- Login Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="loginDropdown" role="button" 
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-sign-in-alt me-1"></i> Login
                        </a>
                        <div class="dropdown-menu dropdown-large">
                            <h6 class="dropdown-header">Login Type</h6>
                            <a class="dropdown-item py-2" href="/admin/alogin">
                                <i class="fas fa-user-shield me-2"></i> Admin Login
                            </a>
                            <a class="dropdown-item py-2" href="/professionals/login">
                                <i class="fas fa-briefcase me-2"></i> Professional Login
                            </a>
                            <a class="dropdown-item py-2" href="/users/login">
                                <i class="fas fa-user me-2"></i> User Login
                            </a>
                        </div>
                    </li>
                    
                    <!-- Register Dropdown -->
                    <li class="nav-item dropdown ms-3">
                        <a class="nav-link dropdown-toggle" href="#" id="registerDropdown" role="button" 
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user-plus me-1"></i> Register
                        </a>
                        <div class="dropdown-menu dropdown-large">
                            <h6 class="dropdown-header">Registration Type</h6>
                            <a class="dropdown-item py-2" href="/professionals/register">
                                <i class="fas fa-briefcase me-2"></i> Register as Recruiter


<p class="small text-muted mb-0"></p>
                            </a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item py-2" href="/users/register">
                                <i class="fas fa-user me-2"></i> Register as User
                                <p class="small text-muted mb-0"></p>
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Hero Section -->
<div class="position-relative overflow-hidden">
    <!-- Dynamic Background using Carousel -->
    <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://source.unsplash.com/1200x600/?teamwork,professionals" class="w-100" style="height: 600px; object-fit: cover; filter: brightness(0.7);" alt="Teamwork">
            </div>
            <div class="carousel-item">
                <img src="https://source.unsplash.com/1200x600/?consulting,business" class="w-100" style="height: 600px; object-fit: cover; filter: brightness(0.7);" alt="Consulting">
            </div>
            <div class="carousel-item">
                <img src="https://source.unsplash.com/1200x600/?technology,team" class="w-100" style="height: 600px; object-fit: cover; filter: brightness(0.7);" alt="Technology">
            </div>
        </div>
    </div>
    
    <div class="position-absolute top- start-50 translate-middle text-center text-white">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <h1 class="display-4 fw-bold mb-4">Welcome, ${sessionScope.user.name}!</h1>
            </c:when>
            <c:otherwise>
                <h1 class="display-4 fw-bold mb-4">Find Expert Professionals</h1>
            </c:otherwise>
        </c:choose>
        <p class="lead mb-4">Connect with verified professionals for all your service needs</p>
        <div class="d-flex justify-content-center gap-3">
            <form action="/search" method="get" class="d-flex w-50">
                <input type="text" name="query" class="form-control" placeholder="Search services or locations..." aria-label="Search">
                <button type="submit" class="btn btn-primary ms-2">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>
    </div>
</div>

<!-- Featured Categories -->
<div class="container bg-warning">
    <h2 class="text-center mb-5 ">JobQuest Services</h2>
    <div class="row g-4">
        <c:forEach var="category" items="${categories}">
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm hover-zoom">
                    <img src="https://source.unsplash.com/400x200/?${category.name}" class="card-img-top" alt="${category.name}" style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">${category.name}</h5>
                        <p class="card-text text-muted">${category.description}</p>
                        <a href="/search?category=${category.id}" class="btn btn-outline-primary">Browse ${category.name}</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<!-- How It Works -->
<div class="bg-warning py-5">
    <div class="container ">
        <h2 class="text-center mb-5">Behind the Scenes</h2>
        <div class="row g-4">
            <div class="col-md-3 text-center">
                <div class="bg-warning rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" 
                     style="width: 80px; height: 80px;">
                    <i class="fas fa-search fa-2x text-primary"></i>
                </div>
                <h5>Choose</h5>
                <p class="text-muted"></p>
            </div>
            
            <div class="col-md-3 text-center">
                <div class="bg-warning rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" 
                     style="width: 80px; height: 80px;">
                    <i class="fas fa-check-circle fa-2x text-primary"></i>
                </div>
                <h5>Select</h5>
                <p class="text-muted"></p>
            </div>
            
            <div class="col-md-3 text-center">
                <div class="bg-warning rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" 
                     style="width: 80px; height: 80px;">
                    <i class="fas fa-calendar-check fa-2x text-primary"></i>
                </div>
                <h5>Book</h5>
                <p class="text-muted"></p>
            </div>
            
            <div class="col-md-3 text-center">
                <div class="bg-warning rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" 
                     style="width: 80px; height: 80px;">
                    <i class="fas fa-star fa-2x text-primary"></i>
                </div>
                <h5>Feedback</h5>
                <p class="text-muted"></p>
            </div>
        </div>
    </div>
</div>

<!-- Testimonials -->
<div id="testimonialsCarousel" class="carousel slide py-5 bg-warning" data-bs-ride="carousel" >
    <h2 class="text-center mb-5">Reviews of our clients</h2>
    <div class="carousel-inner">
        <c:forEach var="testimonial" items="${testimonials}">
            <div class="carousel-item ${testimonial.id == 1 ? 'active' : ''}">
                <div class="card border-0 shadow-sm mx-auto" style="max-width: 600px;">
                    <div class="card-body p-4">
                        <div class="mb-3">
                            <c:forEach begin="1" end="${testimonial.rating}">
                                <i class="fas fa-star text-warning"></i>
                            </c:forEach>
                        </div>
                        <p class="card-text">${testimonial.feedback}</p>
                        <div class="d-flex align-items-center mt-3">
                            <img src="https://source.unsplash.com/50x50/?person,${testimonial.userTitle}" class="rounded-circle me-3" width="50" height="50" alt="${testimonial.userName}">
                            <div>
                                <h6 class="mb-0">${testimonial.userName}</h6>
                                <small class="text-muted">${testimonial.userTitle}</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <a class="carousel-control-prev" href="#testimonialsCarousel" role="button" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </a>
    <a class="carousel-control-next" href="#testimonialsCarousel" role="button" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </a>
</div>
<footer class="bg-dark text-light py-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <h5 class="mb-3">About JobQuest</h5>
                <p class="text-muted">Hunt for the Job. Choose correct Professional. </p>
                <div class="d-flex gap-3 mt-3">
                    <a href="#" class="text-muted"><i class="fab fa-facebook fa-lg"></i></a>
                    <a href="#" class="text-muted"><i class="fab fa-twitter fa-lg"></i></a>
                    <a href="#" class="text-muted"><i class="fab fa-linkedin fa-lg"></i></a>
                    <a href="#" class="text-muted"><i class="fab fa-instagram fa-lg"></i></a>
                </div>
            </div>
            
            <div class="col-md-2">
                <h5 class="mb-3">Links</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="/about" class="text-muted text-decoration-none">About Us</a></li>
                    <li class="mb-2"><a href="/contact" class="text-muted text-decoration-none">Contact</a></li>
                    <li class="mb-2"><a href="/careers" class="text-muted text-decoration-none">Careers</a></li>
                    
                </ul>
            </div>
            
            <div class="col-md-2">
                <h5 class="mb-3">Services</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="/services/legal" class="text-muted text-decoration-none">Legal</a></li>
                    <li class="mb-2"><a href="/services/finance" class="text-muted text-decoration-none">Finance</a></li>
                    <li class="mb-2"><a href="/services/it" class="text-muted text-decoration-none">IT Services</a></li>
                    <li class="mb-2"><a href="/services/consulting" class="text-muted text-decoration-none">Consulting</a></li>
                </ul>
            </div>
            
            <div class="col-md-4">
                <h5 class="mb-3">Newsletter</h5>
                <p class="text-muted">Stay updated with our latest news and updates.</p>
                <form class="mt-3">
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Enter your email">
                        <button class="btn btn-primary" type="submit">Subscribe</button>
                    </div>
                </form>
            </div>
        </div>
        
        <hr class="my-4 border-secondary">
        
        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0 text-muted">&copy; 2024 JobQuest. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <ul class="list-inline mb-0">
                    <li class="list-inline-item">
                        <a href="/terms" class="text-muted text-decoration-none">Terms</a>
                    </li>
                    <li class="list-inline-item ms-3">
                        <a href="/privacy" class="text-muted text-decoration-none">Privacy</a>
                    </li>
                    <li class="list-inline-item ms-3">
                        <a href="/support" class="text-muted text-decoration-none">Support</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>