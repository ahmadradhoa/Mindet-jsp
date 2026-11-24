<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Mindet</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/image/Mindet_Logo.png">
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
            border: 1px solid #e5e7eb;
            color: var(--text-main);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            z-index: 1000;
        }
        [data-theme="dark"] .theme-toggle-btn {
            background-color: #1e293b;
            border-color: #334155;
            color: #f1f5f9;
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
            border-color: #334155;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.4);
        }
        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            background-color: var(--card-bg);
            color: var(--text-main);
            border: 1px solid #cbd5e1;
        }
        [data-theme="dark"] .form-control {
            background-color: #334155;
            border-color: #475569;
            color: #f1f5f9;
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

        .auth-card .border-top { border-color: var(--border-color) !important; }

        .auth-card a.text-primary,
        .auth-card a.text-primary:hover { color: var(--link-color) !important; }

        .form-control::placeholder { color: var(--text-muted); opacity: 0.7; }

        .form-control:focus {
            background-color: var(--card-bg);
            color: var(--text-main);
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(99, 102, 241, 0.25);
        }

        [data-theme="dark"] .form-control:focus { background-color: #334155; }

        [data-theme="dark"] .form-check-input {
            background-color: #334155;
            border-color: #64748b;
        }
        [data-theme="dark"] .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
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
            <c:if test="${not empty error}">
                <div class="alert alert-danger border-0 rounded-3 mb-4">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success border-0 rounded-3 mb-4">
                    <i class="bi bi-check-circle-fill me-2"></i> ${success}
                </div>
            </c:if>

            <form method="POST" action="${pageContext.request.contextPath}/login">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Email</label>
                    <input type="email" name="email" class="form-control" value="<c:out value='${email}' />" required autofocus autocomplete="username" placeholder="name@example.com">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Password</label>
                    <input type="password" name="password" class="form-control" required autocomplete="current-password" placeholder="••••••••">
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="remember" id="remember">
                        <label class="form-check-label small" for="remember">Remember me</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="small text-decoration-none text-primary">Forgot password?</a>
                </div>

                <button type="submit" class="btn btn-primary w-100 mb-4">Log in</button>
            </form>

            <div class="text-center pt-3 border-top">
                <p class="text-muted small mb-0">
                    Don't have an account yet? 
                    <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-primary text-decoration-none">
                        Register
                    </a>
                </p>
            </div>
        </div>
    </div>

    <script>
        const themeToggle = document.getElementById('theme-toggle');
        const themeIcon = document.getElementById('theme-icon');
        function applyTheme(t) {
            document.documentElement.setAttribute('data-theme', t);
            localStorage.setItem('theme', t);
            themeIcon.className = t === 'light' ? 'bi bi-moon-stars-fill' : 'bi bi-sun-fill';
        }
        applyTheme(localStorage.getItem('theme') || 'light');
        themeToggle.addEventListener('click', () => {
            const next = document.documentElement.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
            applyTheme(next);
        });
    </script>
</body>
</html>
