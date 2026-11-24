<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Edit Category - Mindet" />
<jsp:include page="../layouts/header.jsp" />
<jsp:include page="../layouts/navbar.jsp" />

<h4 class="mb-3">Edit Category: <c:out value="${category.name}" /></h4>
<div class="card p-4 card-modern">
<form method="POST" action="${pageContext.request.contextPath}/categories/update">
  <input type="hidden" name="id" value="${category.id}">
  <div class="mb-3">
    <label class="form-label">Category Name</label>
    <input type="text" name="name" class="form-control" value="<c:out value='${category.name}' />" required>
  </div>
  <div class="mb-3">
    <label class="form-label">Description</label>
    <textarea name="description" class="form-control" rows="3"><c:out value='${category.description}' /></textarea>
  </div>
  <div class="d-flex gap-2">
    <button type="submit" class="btn btn-primary btn-form">Save Changes</button>
    <a href="${pageContext.request.contextPath}/categories" class="btn btn-outline-secondary btn-form">Cancel</a>
  </div>
</form>
</div>

<jsp:include page="../layouts/footer.jsp" />
