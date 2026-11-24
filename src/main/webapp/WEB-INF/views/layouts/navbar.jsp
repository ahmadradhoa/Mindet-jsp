<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg sticky-top mb-4">
  <div class="container" style="max-width: 900px;">
    <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/posts">
        <img src="${pageContext.request.contextPath}/image/Mindet_Logo.png" alt="Mindet Logo" height="35" class="d-inline-block align-text-top">
        <span class="fw-bold">Mindet</span>
        <span class="badge bg-primary text-white" style="font-size: 0.7rem; font-weight: 600; padding: 0.35em 0.65em; border-radius: 6px;">JSP Edition</span>
    </a>
    
    <div class="d-flex gap-2 align-items-center">
      <a class="btn btn-outline-secondary btn-sm d-none d-md-inline-flex align-items-center gap-1" href="${pageContext.request.contextPath}/posts">
        <i class="bi bi-house"></i> Home
      </a>
      <a class="btn btn-outline-secondary btn-sm d-none d-md-inline-flex align-items-center gap-1" href="${pageContext.request.contextPath}/categories">
        <i class="bi bi-grid"></i> Category
      </a>
      <a class="btn btn-primary btn-sm d-none d-md-inline-flex align-items-center gap-1" href="${pageContext.request.contextPath}/posts/create">
        <i class="bi bi-plus-lg"></i> Post
      </a>
      
      <c:choose>
        <c:when test="${not empty authUser}">
            <div class="vr mx-2 d-none d-md-block"></div>
            
            <button id="theme-toggle" class="btn btn-outline-secondary btn-sm rounded-circle d-flex align-items-center justify-content-center" style="width: 38px; height: 38px; padding: 0;" title="Switch Dark/Light Mode">
                <i class="bi bi-moon-stars-fill" id="theme-icon"></i>
            </button>

            <div class="dropdown">
                <a href="#" class="d-flex align-items-center gap-2 text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" style="color: var(--text-main);">
                    <div class="d-flex align-items-center justify-content-center text-white fw-bold rounded-circle" 
                        style="background-color: ${authUser.profilePicture}; width: 40px; height: 40px; font-size: 14px; flex-shrink: 0;">
                        ${authUser.initials}
                    </div>
                    <span class="fw-semibold small d-none d-md-block">${authUser.name}</span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-4">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="bi bi-person-gear me-2"></i>Profile Settings</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <form method="POST" action="${pageContext.request.contextPath}/logout" class="m-0">
                            <button type="submit" class="dropdown-item text-danger"><i class="bi bi-box-arrow-right me-2"></i>Logout</button>
                        </form>
                    </li>
                </ul>
            </div>
        </c:when>
        <c:otherwise>
            <button id="theme-toggle-mobile" class="btn btn-outline-secondary btn-sm rounded-circle d-md-none" style="width: 38px; height: 38px; padding: 0;">
                <i class="bi bi-moon-stars-fill" id="theme-icon-mobile"></i>
            </button>
            <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/login">Login</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</nav>

<div class="container" style="max-width: 900px;">
    <c:if test="${not empty success}">
        <div class="alert alert-success border-0 shadow-sm rounded-4 d-flex align-items-center">
            <i class="bi bi-check-circle-fill me-2 fs-5"></i> ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger border-0 shadow-sm rounded-4">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
        </div>
    </c:if>
