<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Home - Mindet" />
<jsp:include page="../layouts/header.jsp" />
<jsp:include page="../layouts/navbar.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h2 class="fw-bold mb-1">Home</h2>
        <p class="text-muted mb-0">Find an interesting topic or start a new discussion</p>
    </div>
    <a href="${pageContext.request.contextPath}/posts/create" class="btn btn-primary shadow-sm">
        <i class="bi bi-pencil-square me-1"></i> Create Post
    </a>
</div>

<div class="card card-modern p-3 mb-4">
    <form method="GET" action="${pageContext.request.contextPath}/posts" class="row g-2 align-items-end">
        <div class="col-md-4">
            <label class="form-label small fw-semibold text-muted">Category Filter</label>
            <select name="category_id" class="form-select">
                <option value="">All Categories</option>
                <c:forEach items="${categories}" var="c">
                    <option value="${c.id}" ${selectedCategoryId == c.id ? 'selected' : ''}>
                        ${c.name}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-6">
            <label class="form-label small fw-semibold text-muted">Search</label>
            <div class="input-group">
                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search"></i></span>
                <input type="text" name="search" class="form-control border-start-0" placeholder="Type a title or text..." value="<c:out value='${search}' />">
            </div>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Search</button>
        </div>
    </form>
    <c:if test="${not empty search or not empty selectedCategoryId}">
        <div class="mt-2">
            <a href="${pageContext.request.contextPath}/posts" class="btn btn-sm btn-outline-danger">
                <i class="bi bi-x-circle"></i> Reset
            </a>
        </div>
    </c:if>
</div>

<c:choose>
    <c:when test="${not empty posts}">
        <c:forEach items="${posts}" var="p">
            <div class="card card-modern mb-3 p-3">
                <div class="d-flex gap-3">
                    <div class="flex-shrink-0 text-center">
                        <div class="d-flex align-items-center justify-content-center text-white fw-bold rounded-circle mx-auto mb-1" 
                            style="background-color: ${p.user.profilePicture}; width: 40px; height: 40px; font-size: 14px;">
                            ${p.user.initials}
                        </div>
                        <div class="small text-muted" style="font-size: 0.7rem;">${p.diffForHumans}</div>
                    </div>
                    
                    <div class="flex-grow-1" style="min-width: 0;">
                        <div class="d-flex align-items-center flex-wrap gap-2 mb-1">
                            <span class="badge-category">${p.category.name}</span>
                            <span class="text-muted small text-break">• From <strong>${p.user.name}</strong></span>
                        </div>
                        
                        <h5 class="fw-bold mb-2">
                            <a href="${pageContext.request.contextPath}/posts/show?id=${p.id}" class="text-decoration-none text-dark stretched-link">
                                <c:out value="${p.title}" />
                            </a>
                        </h5>
                        <p class="text-muted small mb-3" style="line-height: 1.6;"><c:out value="${p.snippet}" /></p>
                        
                        <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center gap-2 gap-md-3 text-muted small position-relative" style="z-index: 2;">
                            <span class="d-flex align-items-center gap-1 text-nowrap">
                                <i class="bi bi-chat-dots"></i> ${p.commentsCount} Comments
                            </span>

                            <c:if test="${not empty authUser and authUser.id == p.userId}">
                                <div class="vr d-none d-md-block"></div>

                                <div class="d-flex align-items-center gap-2">
                                    <a href="${pageContext.request.contextPath}/posts/edit?id=${p.id}"
                                    class="btn btn-outline-warning btn-sm d-inline-flex align-items-center gap-1 text-nowrap">
                                        <i class="bi bi-pencil"></i> Edit
                                    </a>

                                    <form action="${pageContext.request.contextPath}/posts/delete" method="POST" class="m-0 delete-form">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button type="submit"
                                                class="btn btn-outline-danger btn-sm d-inline-flex align-items-center gap-1 text-nowrap">
                                            <i class="bi bi-trash"></i> Delete
                                        </button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="card card-modern p-5 text-center">
            <i class="bi bi-chat-square-dots text-muted display-4 mb-3"></i>
            <h5 class="fw-bold text-muted">No posts found</h5>
            <p class="text-muted small mb-3">There are no discussions yet or no results matched your search.</p>
            <div>
                <a href="${pageContext.request.contextPath}/posts/create" class="btn btn-primary">
                    <i class="bi bi-pencil-square me-1"></i> Start a Discussion
                </a>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="../layouts/footer.jsp" />
