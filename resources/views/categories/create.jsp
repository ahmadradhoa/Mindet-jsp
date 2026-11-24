<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Add Category - Mindet" />
<jsp:include page="../layouts/header.jsp" />
<jsp:include page="../layouts/navbar.jsp" />

<h4 class="mb-3">Add Category</h4>
<div class="card p-4 card-modern">
<form method="POST" action="${pageContext.request.contextPath}/categories/store">
  <div class="mb-3">
    <label class="form-label">Category Name</label>
    <input type="text" name="name" class="form-control" value="<c:out value='${name}' />" required>
  </div>
  <div class="mb-3">
    <label class="form-label">Description</label>
    <textarea name="description" class="form-control" rows="3"><c:out value='${description}' /></textarea>
  </div>
  <div class="d-flex gap-2">
    <button type="submit" class="btn btn-primary btn-form">Add</button>
    <a href="${pageContext.request.contextPath}/categories" class="btn btn-outline-secondary btn-form">Cancel</a>
  </div>
</form>
</div>

<jsp:include page="../layouts/footer.jsp" />
