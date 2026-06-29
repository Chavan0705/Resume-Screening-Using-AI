<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Resume Screening System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <!-- Include FontAwesome icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <c:if test="${not empty sessionScope.currentUser}">
        <header class="main-header">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-brand" id="nav-brand-logo">AI Resume Screener</a>
            <nav>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-link" id="nav-link-dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/upload" class="nav-link" id="nav-link-upload">Upload Resume</a></li>
                    <li><a href="${pageContext.request.contextPath}/history" class="nav-link" id="nav-link-history">Screening History</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile" class="nav-link" id="nav-link-profile">Profile</a></li>
                    <li><span class="user-badge" id="nav-user-badge">${sessionScope.currentUser.role}: ${sessionScope.currentUser.username}</span></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="nav-link" id="nav-link-logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
                </ul>
            </nav>
        </header>
    </c:if>
