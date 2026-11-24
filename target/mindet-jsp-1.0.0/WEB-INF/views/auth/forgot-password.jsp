<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Forgot Password - Mindet</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/image/Mindet_Logo.png">

    <!-- Terapkan tema sebelum render supaya tidak berkedip -->
    <script>
        (function () {
            var t = 'light';
            try { t = localStorage.getItem('theme') || 'light'; } catch (e) {}
            document.documentElement.setAttribute('data-theme', t);
            document.documentElement.setAttribute('data-bs-theme', t);
        })();
    </script>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root {
            --bg-color: #f3f4f6;
            --card-bg: #ffffff;
            --text-main: #111827;
            --text-muted: #6b7280;
            --border-color: #e2e8f0;
            --input-bg: #ffffff;
            --input-border: #cbd5e1;
            --link-color: #4f46e5;
            --primary-color: #6366f1;
            --primary-hover: #4f46e5;
        }
        [data-theme="dark"] {
            --bg-color: #0f172a;
            --card-bg: #1e293b;
            --text-main: #f1f5f9;
            --text-muted: #94a3b8;
            --border-color: #334155;
            --input-bg: #334155;
            --input-border: #475569;
            --link-color: #a5b4fc;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s, color 0.3s;
        }

        .theme-toggle-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            color: var(--text-main);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .auth-card {
            background-color: var(--card-bg);
            width: 100%;
            max-width: 440px;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--border-color);
            transition: background-color 0.3s, border-color 0.3s;
        }
        [data-theme="dark"] .auth-card {
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.4);
        }

        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            background-color: var(--input-bg);
            color: var(--text-main);
            border: 1px solid var(--input-border);
        }
        .form-control::placeholder { color: var(--text-muted); opacity: 0.7; }
        .form-control:focus {
            background-color: var(--input-bg);
            color: var(--text-main);
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(99, 102, 241, 0.25);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 10px;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
        }
        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
        }

        .text-muted { color: var(--text-muted) !important; }
        .auth-card a.text-muted:hover { color: var(--link-color) !important; }
    </style>
</head>
<body>
    <button id="theme-toggle" class="theme-toggle-btn" title="Switch Dark/Light Mode">
        <i class="bi bi-moon-stars-fill" id="theme-icon"></i>
    </button>

    <div class="d-flex flex-column align-items-center w-100 p-3">
        <div class="mb-4 text-center">
            <a href="${pageContext.request.contextPath}/posts">
                <img src="${pageContext.request.contextPath}/image/Mindet_Logo.png" alt="Mindet Logo" style="width: 120px; height: 120px; object-fit: contain;">
            </a>
            <h4 class="fw-bold mt-2">Mindet</h4>
        </div>

        <div class="auth-card">
            <p class="text-muted small mb-4">
                Forgot your password? No problem. Just let us know your email address and we will email you a password reset link.
            </p>

            <c:if test="${not empty status}">
                <div class="alert alert-success border-0 rounded-3 mb-4 small">
                    ${status}
                </div>
            </c:if>

            <form method="POST" action="${pageContext.request.contextPath}/forgot-password">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Email</label>
                    <input type="email" name="email" class="form-control" required autofocus placeholder="name@example.com">
                </div>

                <button type="submit" class="btn btn-primary w-100 mb-3">Email Password Reset Link</button>
                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/login" class="text-muted small text-decoration-none">
                        <i class="bi bi-arrow-left"></i> Back to login
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        const themeToggle = document.getElementById('theme-toggle');
        const themeIcon = document.getElementById('theme-icon');

        function applyTheme(t) {
            document.documentElement.setAttribute('data-theme', t);
            document.documentElement.setAttribute('data-bs-theme', t);
            try { localStorage.setItem('theme', t); } catch (e) {}
            themeIcon.className = t === 'light' ? 'bi bi-moon-stars-fill' : 'bi bi-sun-fill';
        }

        applyTheme(document.documentElement.getAttribute('data-theme') || 'light');

        themeToggle.addEventListener('click', () => {
            const next = document.documentElement.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
            applyTheme(next);
        });
    </script>
</body>
</html>
