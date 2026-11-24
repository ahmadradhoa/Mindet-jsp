<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="mb-3">
  <label class="form-label">Category Name</label>
  <input type="text" name="name" class="form-control" value="<c:out value='${category.name}' />" required>
</div>
<div class="mb-3">
  <label class="form-label">Description</label>
  <textarea name="description" class="form-control" rows="3"><c:out value='${category.description}' /></textarea>
</div>
<div class="d-flex gap-2">
  <button type="submit" class="btn btn-primary btn-form">Save</button>
  <a href="${pageContext.request.contextPath}/categories" class="btn btn-outline-secondary btn-form">Cancel</a>
</div>
