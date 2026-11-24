<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${not empty pageTitle ? pageTitle : 'Mindet'}</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/image/Mindet_Logo.png">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #6366f1;
            --primary-hover: #4f46e5;
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #0f172a;
            --text-muted: #64748b;
        }

        [data-theme="dark"] {
            --bg-color: #0f172a;
            --card-bg: #1e293b;
            --text-main: #f1f5f9;
            --text-muted: #94a3b8;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            transition: background-color 0.3s, color 0.3s;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.9) !important;
            backdrop-filter: blur(10px);
            border-bottom: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            transition: background 0.3s, border-color 0.3s;
        }

        [data-theme="dark"] .navbar {
            background: rgba(15, 23, 42, 0.9) !important;
            border-bottom: 1px solid #334155;
        }

        .navbar-brand {
            color: var(--primary-color) !important;
            font-weight: 800;
            font-size: 1.5rem;
            letter-spacing: -0.5px;
        }

        .card-modern {
            background: var(--card-bg);
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            color: var(--text-main);
        }

        .card-modern:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            border-color: var(--primary-color);
        }

        [data-theme="dark"] .card-modern {
            border-color: #334155;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            border-radius: 10px;
            font-weight: 600;
            padding: 0.6rem 1.2rem;
            transition: all 0.2s;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        .avatar {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border: 2px solid transparent;
        }

        .badge-category {
            background-color: #e0e7ff;
            color: var(--primary-color);
            font-weight: 600;
            padding: 0.4em 0.8em;
            border-radius: 8px;
            font-size: 0.75rem;
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 1px solid #cbd5e1;
            padding: 0.75rem 1rem;
            background-color: var(--card-bg);
            color: var(--text-main);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
        }

        .input-group-text {
            background-color: transparent !important;
            border: 1px solid #cbd5e1;
            border-right: none;
            color: var(--text-muted);
        }

        .form-control.border-start-0 {
            border-left: none !important;
        }

        [data-theme="dark"] .text-dark { color: var(--text-main) !important; }
        [data-theme="dark"] .text-muted { color: var(--text-muted) !important; }
        [data-theme="dark"] .fw-bold, [data-theme="dark"] .fw-semibold, [data-theme="dark"] strong { color: var(--text-main) !important; }
        [data-theme="dark"] .bg-light { background-color: #334155 !important; }
        [data-theme="dark"] p { color: #e2e8f0; }
        [data-theme="dark"] .form-text, [data-theme="dark"] small.text-muted { color: #94a3b8 !important; }
        [data-theme="dark"] hr, [data-theme="dark"] .border-top { border-color: #334155 !important; }

        [data-theme="dark"] .form-control, [data-theme="dark"] .form-select {
            background-color: #334155;
            border-color: #475569;
            color: #f1f5f9;
        }
        [data-theme="dark"] .form-control::placeholder, [data-theme="dark"] input::placeholder, [data-theme="dark"] textarea::placeholder {
            color: #64748b;
        }

        [data-theme="dark"] .input-group-text {
            background-color: transparent !important;
            border-color: #475569;
            color: #94a3b8;
        }

        [data-theme="dark"] .card-modern p,
        [data-theme="dark"] .card-modern h1, [data-theme="dark"] .card-modern h2, 
        [data-theme="dark"] .card-modern h3, [data-theme="dark"] .card-modern h4, 
        [data-theme="dark"] .card-modern h5, [data-theme="dark"] .card-modern h6, 
        [data-theme="dark"] .card-modern strong, [data-theme="dark"] .card-modern .fw-bold, 
        [data-theme="dark"] .card-modern .fw-semibold {
            color: #f1f5f9 !important;
        }

        [data-theme="dark"] .card-modern a.text-dark { color: #f1f5f9 !important; }
        [data-theme="dark"] .card-modern a.text-dark:hover { color: #cbd5e1 !important; }

        [data-theme="dark"] .dropdown-menu {
            background-color: #1e293b;
            border-color: #334155;
        }
        [data-theme="dark"] .dropdown-item { color: #f1f5f9; }
        [data-theme="dark"] .dropdown-item:hover { background-color: #334155; color: #f1f5f9; }
        [data-theme="dark"] .dropdown-divider { border-color: #334155; }

        .card-modern.no-hover:hover {
            transform: none;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            border-color: #e2e8f0;
        }
        [data-theme="dark"] .card-modern.no-hover:hover {
            border-color: #334155;
        }

        [data-theme="dark"] .form-label,
        [data-theme="dark"] label {
            color: var(--text-main);
        }
        [data-theme="dark"] .btn-outline-secondary {
            color: #cbd5e1;
            border-color: #475569;
        }
        [data-theme="dark"] .btn-outline-secondary:hover {
            background-color: #334155;
            color: #f1f5f9;
            border-color: #475569;
        }

        [data-theme="dark"] .card,
        [data-theme="dark"] .bg-white {
            background-color: var(--card-bg) !important;
            border-color: #334155;
            color: var(--text-main);
        }

        .swal2-popup {
            background-color: var(--card-bg) !important;
            color: var(--text-main) !important;
            border-radius: 16px !important;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1) !important;
            border: 1px solid #e2e8f0;
            padding: 1.5rem !important;
        }
        [data-theme="dark"] .swal2-popup {
            border-color: #334155 !important;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5) !important;
        }
        .swal2-title {
            color: var(--text-main) !important;
            font-weight: 700 !important;
            font-size: 1.25rem !important;
            margin-bottom: 0.5rem !important;
        }
        .swal2-html-container {
            color: var(--text-muted) !important;
            font-size: 0.95rem !important;
            line-height: 1.5 !important;
            margin: 0 !important;
        }
        .swal2-confirm {
            background-color: #ef4444 !important;
            border: none !important;
            border-radius: 10px !important;
            font-weight: 600 !important;
            padding: 0.6rem 1.2rem !important;
            font-size: 0.9rem !important;
        }
        .swal2-confirm:hover {
            background-color: #dc2626 !important;
        }
        .swal2-cancel {
            background-color: #e2e8f0 !important;
            color: #475569 !important;
            border: none !important;
            border-radius: 10px !important;
            font-weight: 600 !important;
            padding: 0.6rem 1.2rem !important;
            font-size: 0.9rem !important;
        }
        [data-theme="dark"] .swal2-cancel {
            background-color: #334155 !important;
            color: #cbd5e1 !important;
        }
        .swal2-cancel:hover {
            background-color: #cbd5e1 !important;
        }
        [data-theme="dark"] .swal2-cancel:hover {
            background-color: #475569 !important;
        }

        @media (max-width: 767.98px) {
            .navbar { padding: 0.5rem 0 !important; }
            .navbar-brand { font-size: 1.2rem !important; }
            .navbar-brand img { height: 28px !important; }
            .container { padding-left: 12px !important; padding-right: 12px !important; }
            .card-modern.p-4 { padding: 1rem !important; }
            .card-modern.mb-3.p-3 { padding: 0.8rem !important; }
            body { padding-bottom: 70px; }
        }

        .bottom-nav {
            position: fixed;
            bottom: 0; left: 0; right: 0;
            z-index: 1030;
            display: flex;
            background: var(--card-bg);
            border-top: 1px solid #e2e8f0;
            padding-bottom: env(safe-area-inset-bottom);
        }
        [data-theme="dark"] .bottom-nav { border-top-color: #334155; }
        .bottom-nav a {
            flex: 1;
            text-align: center;
            padding: 0.5rem 0;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.7rem;
            font-weight: 600;
        }
        .bottom-nav a i { display: block; font-size: 1.3rem; }
        .bottom-nav a.active { color: var(--primary-color); }

        .btn-primary.btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            font-weight: 400;
            border-radius: 0.375rem;
        }
        .btn-outline-secondary.btn-sm {
            border-radius: 0.375rem;
        }
        .btn-form {
            padding: 0.6rem 1.4rem;
            border-radius: 10px;
            font-weight: 600;
        }
    </style>
</head>
<body>
