<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<section>
    <header>
        <h2 class="text-lg font-medium text-gray-900">Profile Information</h2>
        <p class="mt-1 text-sm text-gray-600">Update your account's profile information and email address.</p>
    </header>
    <form method="POST" action="${pageContext.request.contextPath}/profile" class="mt-6 space-y-6">
        <div>
            <label class="form-label">Username</label>
            <input type="text" name="name" class="form-control" value="<c:out value='${authUser.name}' />" required>
        </div>
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </form>
</section>
