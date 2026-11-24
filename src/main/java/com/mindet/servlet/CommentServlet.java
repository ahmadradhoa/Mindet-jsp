package com.mindet.servlet;

import com.mindet.dao.CommentDao;
import com.mindet.model.Comment;
import com.mindet.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class CommentServlet extends HttpServlet {
    private final CommentDao commentDao = new CommentDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath() + (req.getPathInfo() != null ? req.getPathInfo() : "");
        if ("/comments".equals(path) || "/comments/store".equals(path)) {
            handleStore(req, resp);
        } else if ("/comments/delete".equals(path)) {
            handleDelete(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleStore(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = getAuthUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String postIdParam = req.getParameter("post_id");
        String body = req.getParameter("body");

        if (postIdParam == null || body == null || body.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/posts");
            return;
        }

        int postId = Integer.parseInt(postIdParam.trim());
        Comment comment = new Comment();
        comment.setPostId(postId);
        comment.setUserId(user.getId());
        comment.setBody(body.trim());

        if (commentDao.create(comment)) {
            setFlash(req, "flash_success", "Comment posted!");
        } else {
            setFlash(req, "flash_error", "Failed to post comment.");
        }
        resp.sendRedirect(req.getContextPath() + "/posts/show?id=" + postId);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = getAuthUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        int postId = Integer.parseInt(req.getParameter("post_id"));

        Comment comment = commentDao.findById(id);
        if (comment == null || comment.getUserId() != user.getId()) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        commentDao.delete(id);
        setFlash(req, "flash_success", "Comment deleted!");
        resp.sendRedirect(req.getContextPath() + "/posts/show?id=" + postId);
    }

    private User getAuthUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null ? (User) session.getAttribute("user") : null;
    }

    private void setFlash(HttpServletRequest req, String key, String val) {
        req.getSession(true).setAttribute(key, val);
    }
}
