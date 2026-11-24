<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${not empty error}">
    <ul class="text-sm text-red-600 space-y-1 mt-2">
        <li>${error}</li>
    </ul>
</c:if>
