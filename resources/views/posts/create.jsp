<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Create Post - Mindet" />
<jsp:include page="../layouts/header.jsp" />
<jsp:include page="../layouts/navbar.jsp" />

<h4 class="mb-3">Create a Post</h4>
<div class="card p-4 card-modern">
<form method="POST" action="${pageContext.request.contextPath}/posts/store">
    <div class="mb-3">
        <label class="form-label">Category</label>
        <select name="category_id" class="form-select" required>
            <option value=""> Select Category </option>
            <c:forEach items="${categories}" var="c">
                <option value="${c.id}">
                    ${c.name}
                </option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">Title</label>
        <input type="text" name="title" class="form-control" required value="<c:out value='${title}' />">
    </div>
    <div class="mb-3">
        <label class="form-label">Content</label>
        <textarea name="body" class="form-control" rows="6" required><c:out value='${body}' /></textarea>
    </div>
    <div class="d-flex gap-2">
        <button type="submit" class="btn btn-primary btn-form">Post</button>
        <a href="${pageContext.request.contextPath}/posts" class="btn btn-outline-secondary btn-form">Cancel</a>
    </div>
</form>
</div>

<jsp:include page="../layouts/footer.jsp" />
