<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section>
    <header>
        <h2 class="text-lg font-medium text-gray-900">Update Password</h2>
        <p class="mt-1 text-sm text-gray-600">Ensure your account is using a long, random password to stay secure.</p>
    </header>
    <form method="POST" action="${pageContext.request.contextPath}/password" class="mt-6 space-y-6">
        <div class="mb-3">
            <label class="form-label">Current Password</label>
            <input type="password" name="current_password" class="form-control" autocomplete="current-password">
        </div>
        <div class="mb-3">
            <label class="form-label">New Password</label>
            <input type="password" name="password" class="form-control" autocomplete="new-password">
        </div>
        <div class="mb-3">
            <label class="form-label">Confirm Password</label>
            <input type="password" name="password_confirmation" class="form-control" autocomplete="new-password">
        </div>
        <button type="submit" class="btn btn-primary">Save Password</button>
    </form>
</section>
