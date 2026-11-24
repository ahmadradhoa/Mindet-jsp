<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${not empty status}">
    <div class="font-medium text-sm text-green-600 mb-4">
        ${status}
    </div>
</c:if>
