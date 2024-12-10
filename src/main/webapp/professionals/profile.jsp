<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Professional Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <div class="max-w-3xl mx-auto">
            <h1 class="text-3xl font-bold mb-8">Professional Profile</h1>
            
            <c:if test="${not empty successMessage}">
    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
        <span class="block sm:inline">${successMessage}</span>
    </div>
</c:if>
            
            
            <form action="/professionals/profile/update" method="POST" class="bg-white rounded-lg shadow p-6 mb-8">
                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="name">
                        Full Name
                    </label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                           id="name" type="text" name="name" value="${professional.name}" required>
                </div>

                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="title">
                        Professional Title
                    </label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                           id="title" type="text" name="title" value="${professional.title}" required>
                </div>

                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="bio">
                        Bio
                    </label>
                    <textarea class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                              id="bio" name="bio" rows="4">${professional.bio}</textarea>
                </div>

                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="skills">
                        Skills (comma separated)
                    </label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                           id="skills" type="text" name="skills" value="${professional.skills}">
                </div>

                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="hourlyRate">
                        Hourly Rate ($)
                    </label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                           id="hourlyRate" type="number" name="hourlyRate" value="${professional.hourlyRate}" required>
                </div>

                <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                        type="submit">
                    Update Profile
                </button>
            </form>

            <!-- Resume Upload -->
            <div class="bg-white rounded-lg shadow p-6 mb-8">
                <h2 class="text-xl font-semibold mb-4">Resume Management</h2>
                <form action="/professionals/resume/upload" method="POST" enctype="multipart/form-data">
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="resume">
                            Upload Resume (PDF)
                        </label>
                        <input type="file" id="resume" name="file" accept=".pdf" required
                               class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100">
                    </div>
                    <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                            type="submit">
                        Upload Resume
                    </button>
                </form>
                
                <c:if test="${professional.resumePath != null}">
                    <div class="mt-4">
                        <a href="/professionals/resume/download/${professional.id}" 
                           class="text-blue-600 hover:text-blue-800">
                            Download Current Resume
                        </a>
                    </div>
                </c:if>
            </div>

            <!-- Services List -->
            <div class="bg-white rounded-lg shadow p-6">
                <h2 class="text-xl font-semibold mb-4">Your Services</h2>
                <div class="grid grid-cols-1 gap-4">
                    <c:forEach items="${professional.services}" var="service">
                        <div class="border rounded p-4">
                            <h3 class="font-semibold">${service.title}</h3>
                            <p class="text-gray-600">${service.description}</p>
                            <p class="text-gray-800 mt-2">$${service.price}</p>
                            <div class="mt-2">
                                
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</body>
</html>