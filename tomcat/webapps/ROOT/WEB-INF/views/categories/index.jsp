<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Categories - Mindet" />
<jsp:include page="../layouts/header.jsp" />
<jsp:include page="../layouts/navbar.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h2 class="fw-bold mb-1">Discussion Categories</h2>
        <p class="text-muted mb-0">Select the topics you want to follow</p>
    </div>
    <a href="${pageContext.request.contextPath}/categories/create" class="btn btn-primary shadow-sm">
        <i class="bi bi-plus-lg me-1"></i> Add Category
    </a>
</div>

<div class="row g-3">
<c:choose>
    <c:when test="${not empty categories}">
        <c:forEach items="${categories}" var="c">
            <div class="col-md-6 col-lg-4">
                <div class="card card-modern h-100 p-4 d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="bg-primary bg-opacity-10 text-primary rounded-3 p-2">
                            <i class="bi bi-folder2-open fs-4"></i>
                        </div>
                        <span class="badge bg-dark bg-opacity-75 rounded-pill">${c.postsCount} Post</span>
                    </div>
                    
                    <h5 class="fw-bold mb-2"><c:out value="${c.name}" /></h5>
                    <p class="text-muted small flex-grow-1 mb-3"><c:out value="${not empty c.description ? c.description : 'No description'}" /></p>
                    
                    <div class="d-flex gap-2 mt-auto">
                        <a href="${pageContext.request.contextPath}/posts?category_id=${c.id}" class="btn btn-outline-primary btn-sm flex-grow-1">View Discussion</a>
                        <c:if test="${not empty authUser}">
                            <a href="${pageContext.request.contextPath}/categories/edit?id=${c.id}" class="btn btn-outline-warning btn-sm"><i class="bi bi-pencil"></i></a>
                            
                            <form action="${pageContext.request.contextPath}/categories/delete" method="POST" class="d-inline delete-form">
                                <input type="hidden" name="id" value="${c.id}">
                                <button class="btn btn-outline-danger btn-sm" type="submit"><i class="bi bi-trash"></i></button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="col-12 text-center py-5">
            <i class="bi bi-folder-x text-muted display-4 mb-3"></i>
            <h5 class="fw-bold text-muted">No categories yet</h5>
            <a href="${pageContext.request.contextPath}/categories/create" class="btn btn-primary mt-2">Create the First Category</a>
        </div>
    </c:otherwise>
</c:choose>
</div>

<jsp:include page="../layouts/footer.jsp" />
