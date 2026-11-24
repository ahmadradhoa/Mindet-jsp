package com.mindet.servlet;

import com.mindet.dao.UserDao;
import com.mindet.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class ProfileServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/profile/edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String name = req.getParameter("name");
        String profilePicture = req.getParameter("profile_picture");

        if (name == null || name.trim().isEmpty() || profilePicture == null || !profilePicture.matches("^#[0-9A-Fa-f]{6}$")) {
            req.setAttribute("error", "Valid name and color selection are required.");
            req.getRequestDispatcher("/WEB-INF/views/profile/edit.jsp").forward(req, resp);
            return;
        }

        if (userDao.updateProfile(user.getId(), name.trim(), profilePicture)) {
            user.setName(name.trim());
            user.setProfilePicture(profilePicture);
            req.getSession().setAttribute("user", user);
            setFlash(req, "flash_success", "Your profile has been successfully updated!");
            resp.sendRedirect(req.getContextPath() + "/profile");
        } else {
            req.setAttribute("error", "Failed to update profile.");
            req.getRequestDispatcher("/WEB-INF/views/profile/edit.jsp").forward(req, resp);
        }
    }

    private User getAuthUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null ? (User) session.getAttribute("user") : null;
    }

    private void setFlash(HttpServletRequest req, String key, String val) {
        req.getSession(true).setAttribute(key, val);
    }
}
