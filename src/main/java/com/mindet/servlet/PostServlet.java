package com.mindet.servlet;

import com.mindet.dao.CategoryDao;
import com.mindet.dao.PostDao;
import com.mindet.model.Category;
import com.mindet.model.Post;
import com.mindet.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class PostServlet extends HttpServlet {
    private final PostDao postDao = new PostDao();
    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath() + (req.getPathInfo() != null ? req.getPathInfo() : "");
        if (path == null || path.isEmpty() || "/".equals(path) || "/posts".equals(path)) {
            handleIndex(req, resp);
        } else if ("/posts/create".equals(path)) {
            handleCreate(req, resp);
        } else if ("/posts/show".equals(path)) {
            handleShow(req, resp);
        } else if ("/posts/edit".equals(path)) {
            handleEdit(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath() + (req.getPathInfo() != null ? req.getPathInfo() : "");
        if ("/posts".equals(path) || "/posts/store".equals(path)) {
            handleStore(req, resp);
        } else if ("/posts/update".equals(path)) {
            handleUpdate(req, resp);
        } else if ("/posts/delete".equals(path)) {
            handleDelete(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String catParam = req.getParameter("category_id");
        Integer categoryId = null;
        if (catParam != null && !catParam.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(catParam.trim());
            } catch (NumberFormatException ignored) {}
        }
        String search = req.getParameter("search");

        List<Post> posts = postDao.getPosts(categoryId, search);
        List<Category> categories = categoryDao.getAll();

        req.setAttribute("posts", posts);
        req.setAttribute("categories", categories);
        req.setAttribute("selectedCategoryId", categoryId);
        req.setAttribute("search", search);

        req.getRequestDispatcher("/WEB-INF/views/posts/index.jsp").forward(req, resp);
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryDao.getAll();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/WEB-INF/views/posts/create.jsp").forward(req, resp);
    }

    private void handleStore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String catParam = req.getParameter("category_id");
        String title = req.getParameter("title");
        String body = req.getParameter("body");

        if (catParam == null || title == null || body == null
                || catParam.trim().isEmpty() || title.trim().isEmpty() || body.trim().isEmpty()) {
            req.setAttribute("error", "Category, title, and content are required.");
            req.setAttribute("categories", categoryDao.getAll());
            req.setAttribute("title", title);
            req.setAttribute("body", body);
            req.getRequestDispatcher("/WEB-INF/views/posts/create.jsp").forward(req, resp);
            return;
        }

        int categoryId = Integer.parseInt(catParam.trim());
        Post post = new Post();
        post.setUserId(user.getId());
        post.setCategoryId(categoryId);
        post.setTitle(title.trim());
        post.setBody(body.trim());

        if (postDao.create(post)) {
            setFlash(req, "flash_success", "The post was successfully published!");
            resp.sendRedirect(req.getContextPath() + "/posts");
        } else {
            req.setAttribute("error", "Failed to create post.");
            req.setAttribute("categories", categoryDao.getAll());
            req.getRequestDispatcher("/WEB-INF/views/posts/create.jsp").forward(req, resp);
        }
    }

    private void handleShow(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/posts");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam.trim());
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/posts");
            return;
        }

        Post post = postDao.findById(id);
        if (post == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Post not found");
            return;
        }

        req.setAttribute("post", post);
        req.getRequestDispatcher("/WEB-INF/views/posts/show.jsp").forward(req, resp);
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idParam = req.getParameter("id");
        int id = Integer.parseInt(idParam.trim());
        Post post = postDao.findById(id);
        if (post == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        if (post.getUserId() != user.getId()) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "This is not your post!");
            return;
        }

        req.setAttribute("post", post);
        req.setAttribute("categories", categoryDao.getAll());
        req.getRequestDispatcher("/WEB-INF/views/posts/edit.jsp").forward(req, resp);
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        Post post = postDao.findById(id);
        if (post == null || post.getUserId() != user.getId()) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "This is not your post!");
            return;
        }

        String catParam = req.getParameter("category_id");
        String title = req.getParameter("title");
        String body = req.getParameter("body");

        post.setCategoryId(Integer.parseInt(catParam.trim()));
        post.setTitle(title.trim());
        post.setBody(body.trim());

        if (postDao.update(post)) {
            setFlash(req, "flash_success", "Post updated!");
            resp.sendRedirect(req.getContextPath() + "/posts/show?id=" + id);
        } else {
            req.setAttribute("error", "Failed to update post.");
            req.setAttribute("post", post);
            req.setAttribute("categories", categoryDao.getAll());
            req.getRequestDispatcher("/WEB-INF/views/posts/edit.jsp").forward(req, resp);
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = getAuthUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        Post post = postDao.findById(id);
        if (post == null || post.getUserId() != user.getId()) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "This is not your post!");
            return;
        }

        postDao.delete(id);
        setFlash(req, "flash_success", "Post deleted!");
        resp.sendRedirect(req.getContextPath() + "/posts");
    }

    private User getAuthUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null ? (User) session.getAttribute("user") : null;
    }

    private void setFlash(HttpServletRequest req, String key, String val) {
        req.getSession(true).setAttribute(key, val);
    }
}
