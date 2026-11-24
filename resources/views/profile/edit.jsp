<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Profile Settings - Mindet" />
<jsp:include page="../layouts/header.jsp" />
<jsp:include page="../layouts/navbar.jsp" />

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card card-modern p-4">
            <h4 class="fw-bold mb-4"><i class="bi bi-person-gear me-2"></i>Profile Settings</h4>
            
            <form method="POST" action="${pageContext.request.contextPath}/profile">
                <div class="text-center mb-4">
                    <div id="avatar-preview" 
                         class="d-flex align-items-center justify-content-center text-white fw-bold rounded-circle mx-auto mb-3 border border-3 border-primary" 
                         style="background-color: ${authUser.profilePicture}; width: 128px; height: 128px; font-size: 3rem;">
                        ${authUser.initials}
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Username</label>
                    <input type="text" name="name" class="form-control" value="<c:out value='${authUser.name}' />" required>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold mb-3">Choose a Profile Color</label>
                    <div class="d-flex gap-3 flex-wrap">
                        <c:set var="palette" value="#6366f1,#ef4444,#10b981,#f59e0b,#ec4899,#8b5cf6,#06b6d4,#f97316" />
                        <c:forTokens items="${palette}" delims="," var="color" varStatus="loop">
                            <div class="text-center">
                                <input type="radio" class="btn-check" name="profile_picture" id="color-${loop.index}" value="${color}" 
                                    ${authUser.profilePicture == color ? 'checked' : ''} required>
                                <label class="btn p-0 border-0 rounded-circle d-flex align-items-center justify-content-center color-btn" 
                                    for="color-${loop.index}" 
                                    style="width: 35px; height: 35px; background-color: ${color}; cursor: pointer;">
                                    <i class="bi bi-check-lg text-white check-icon" style="font-size: 1.5rem; display: ${authUser.profilePicture == color ? 'block' : 'none'};"></i>
                                </label>
                            </div>
                        </c:forTokens>
                    </div>
                </div>

                <script>
                    document.querySelectorAll('input[name="profile_picture"]').forEach(radio => {
                        radio.addEventListener('change', function() {
                            document.getElementById('avatar-preview').style.backgroundColor = this.value;
                            document.querySelectorAll('.check-icon').forEach(icon => icon.style.display = 'none');
                            this.nextElementSibling.querySelector('.check-icon').style.display = 'block';
                        });
                    });
                </script>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                    <a href="${pageContext.request.contextPath}/posts" class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../layouts/footer.jsp" />
