package com.mindet.servlet;

import com.mindet.dao.UserDao;
import com.mindet.model.User;
import com.mindet.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Random;

public class AuthServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();
    private static final String[] COLOR_PALETTE = {
            "#6366f1", // Indigo
            "#ef4444", // Merah
            "#10b981", // Hijau Emerald
            "#f59e0b", // Kuning Amber
            "#ec4899", // Pink
            "#8b5cf6", // Ungu Violet
            "#06b6d4", // Cyan
            "#f97316"  // Orange
    };
    private final Random random = new Random();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath() + (req.getPathInfo() != null ? req.getPathInfo() : "");
        if ("/logout".equals(path)) {
            handleLogout(req, resp);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null && !"/forgot-password".equals(path)) {
            resp.sendRedirect(req.getContextPath() + "/posts");
            return;
        }

        if ("/login".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        } else if ("/register".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
        } else if ("/forgot-password".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath() + (req.getPathInfo() != null ? req.getPathInfo() : "");
        if ("/login".equals(path)) {
            handleLogin(req, resp);
        } else if ("/register".equals(path)) {
            handleRegister(req, resp);
        } else if ("/logout".equals(path)) {
            handleLogout(req, resp);
        } else if ("/forgot-password".equals(path)) {
            handleForgotPassword(req, resp);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            return;
        }

        User user = userDao.findByEmail(email.trim());
        if (user == null || !PasswordUtil.verify(password, user.getPassword())) {
            req.setAttribute("error", "These credentials do not match our records.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("flash_success", "Welcome back, " + user.getName() + "!");
        resp.sendRedirect(req.getContextPath() + "/posts");
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String passwordConfirmation = req.getParameter("password_confirmation");

        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(passwordConfirmation)) {
            req.setAttribute("error", "Passwords do not match.");
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
            return;
        }

        if (userDao.findByEmail(email.trim()) != null) {
            req.setAttribute("error", "Email is already registered.");
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
            return;
        }

        String randomColor = COLOR_PALETTE[random.nextInt(COLOR_PALETTE.length)];
        User user = new User();
        user.setName(name.trim());
        user.setEmail(email.trim().toLowerCase());
        user.setPassword(PasswordUtil.hash(password));
        user.setProfilePicture(randomColor);

        if (userDao.create(user)) {
            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("flash_success", "Welcome to Mindet, " + user.getName() + "!");
            resp.sendRedirect(req.getContextPath() + "/posts");
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + "/");
    }

    private void handleForgotPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        req.setAttribute("status", "If your email is registered, we have sent a password reset link to " + email);
        req.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(req, resp);
    }
}
