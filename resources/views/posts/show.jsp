<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="${post.title} - Mindet" />
<jsp:include page="../layouts/header.jsp" />
<jsp:include page="../layouts/navbar.jsp" />

<a href="${pageContext.request.contextPath}/posts" class="btn btn-outline-secondary btn-sm mb-4 rounded-pill px-3">
    <i class="bi bi-arrow-left"></i> Back
</a>

<div class="card card-modern p-4 mb-4">
    <div class="d-flex align-items-center gap-3 mb-3">
        <div class="d-flex align-items-center justify-content-center text-white fw-bold rounded-circle" 
            style="background-color: ${post.user.profilePicture}; width: 40px; height: 40px; font-size: 14px; flex-shrink: 0;">
            ${post.user.initials}
        </div>
        
        <div>
            <div class="fw-bold">${post.user.name}</div>
            <div class="text-muted small">${post.formattedDate} • <span class="badge-category">${post.category.name}</span></div>
        </div>
    </div>
    
    <h2 class="fw-bold mb-3"><c:out value="${post.title}" /></h2>
    <div class="text-muted" style="line-height: 1.8; white-space: pre-line;"><c:out value="${post.body}" /></div>

    <c:if test="${not empty authUser and authUser.id == post.userId}">
        <div class="d-flex gap-2 mt-4 pt-3 border-top">
            <a href="${pageContext.request.contextPath}/posts/edit?id=${post.id}" class="btn btn-outline-warning btn-sm"><i class="bi bi-pencil"></i> Edit</a>
            <form method="POST" action="${pageContext.request.contextPath}/posts/delete" class="d-inline delete-form">
                <input type="hidden" name="id" value="${post.id}">
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
            </form>
        </div>
    </c:if>
</div>

<h5 class="fw-bold mb-3"><i class="bi bi-chat-left-text me-2"></i>${post.comments.size()} Comments</h5>

<c:forEach items="${post.comments}" var="c">
    <div class="card card-modern mb-3 p-3 ms-md-4 border-start border-4 border-primary">
        <div class="d-flex justify-content-between align-items-start">
            <div class="d-flex gap-2">
                <div class="d-flex align-items-center justify-content-center text-white fw-bold rounded-circle flex-shrink-0" 
                    style="background-color: ${c.user.profilePicture}; width: 32px; height: 32px; font-size: 11px;">
                    ${c.user.initials}
                </div>
                
                <div>
                    <div class="fw-semibold small">${c.user.name}</div>
                    <div class="text-muted" style="font-size: 0.8rem;">${c.diffForHumans}</div>
                    <p class="mb-0 mt-1 small" style="line-height: 1.5;"><c:out value="${c.body}" /></p>
                </div>
            </div>
            <c:if test="${not empty authUser and authUser.id == c.userId}">
                <form method="POST" action="${pageContext.request.contextPath}/comments/delete" class="d-inline delete-form">
                    <input type="hidden" name="id" value="${c.id}">
                    <input type="hidden" name="post_id" value="${post.id}">
                    <button class="btn btn-link text-danger text-decoration-none p-0" style="font-size: 0.8rem;"><i class="bi bi-trash"></i></button>
                </form>
            </c:if>
        </div>
    </div>
</c:forEach>

<div class="card card-modern p-4 ms-md-4 mt-4 bg-light">
    <h6 class="fw-bold mb-3">Write a comment</h6>
    <c:choose>
        <c:when test="${not empty authUser}">
            <form method="POST" action="${pageContext.request.contextPath}/comments/store">
                <input type="hidden" name="post_id" value="${post.id}">
                <textarea name="body" class="form-control mb-3" rows="3" placeholder="What are your thoughts on this?" required></textarea>
                <button class="btn btn-primary"><i class="bi bi-send-fill me-1"></i> Post</button>
            </form>
        </c:when>
        <c:otherwise>
            <p class="text-muted small mb-3">Please login to join the conversation.</p>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm">Login to Comment</a>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="../layouts/footer.jsp" />
