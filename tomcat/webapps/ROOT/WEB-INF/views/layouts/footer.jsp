<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

</div> <!-- End of container -->

<footer class="text-center text-muted small py-5 mt-5">
    <p class="mb-0">© 2026 <strong>Mindet (Jakarta Server Pages / Tomcat 10)</strong></p>
</footer>

<nav class="bottom-nav d-md-none">
    <a href="${pageContext.request.contextPath}/posts" class="${currentUri.contains('/posts') && !currentUri.contains('/create') ? 'active' : ''}">
        <i class="bi bi-house"></i>Home
    </a>
    <a href="${pageContext.request.contextPath}/categories" class="${currentUri.contains('/categories') ? 'active' : ''}">
        <i class="bi bi-grid"></i>Category
    </a>
    <a href="${pageContext.request.contextPath}/posts/create" class="${currentUri.contains('/posts/create') ? 'active' : ''}">
        <i class="bi bi-plus-circle"></i>Post
    </a>
</nav>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.querySelectorAll('.delete-form').forEach(form => {
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        Swal.fire({
            html: `
                <div class="text-start">
                    <p class="mb-0" style="color: var(--text-main); font-size: 1rem;">
                        <i class="bi bi-exclamation-triangle-fill text-warning me-2" style="font-size: 1.1rem;"></i>
                        Are you sure you want to delete this?
                    </p>
                    <p class="text-muted small mt-2 mb-0">
                        Deleted data cannot be recovered
                    </p>
                </div>
            `,
            showCancelButton: true,
            confirmButtonColor: '#ef4444',
            cancelButtonColor: '#94a3b8',
            confirmButtonText: 'Delete',
            cancelButtonText: 'Cancel',
            reverseButtons: true,
            customClass: {
                popup: 'rounded-3 shadow-sm border-0',
                confirmButton: 'rounded-2 px-4 py-2 fw-semibold',
                cancelButton: 'rounded-2 px-4 py-2 fw-semibold'
            },
            buttonsStyling: true,
            width: '400px',
            padding: '1.5rem'
        }).then((result) => {
            if (result.isConfirmed) {
                this.submit();
            }
        });
    });
});

const themeToggles = document.querySelectorAll('#theme-toggle, #theme-toggle-mobile');
const themeIcons = document.querySelectorAll('#theme-icon, #theme-icon-mobile');

function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    document.documentElement.setAttribute('data-bs-theme', theme);
    localStorage.setItem('theme', theme);
    updateIcons(theme);
}

function updateIcons(theme) {
    themeIcons.forEach(icon => {
        if (icon) {
            icon.className = theme === 'light' ? 'bi bi-moon-stars-fill' : 'bi bi-sun-fill';
        }
    });
}

applyTheme(localStorage.getItem('theme') || 'light');

themeToggles.forEach(toggle => {
    toggle.addEventListener('click', () => {
        const newTheme = document.documentElement.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
        applyTheme(newTheme);
    });
});
</script>
</body>
</html>
