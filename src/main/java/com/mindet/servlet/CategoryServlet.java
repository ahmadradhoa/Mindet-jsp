package com.mindet.servlet;

import com.mindet.dao.CategoryDao;
import com.mindet.model.Category;
import com.mindet.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class CategoryServlet extends HttpServlet {
    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath() + (req.getPathInfo() != null ? req.getPathInfo() : "");
        if ("/categories".equals(path)) {
            handleIndex(req, resp);
        } else if ("/categories/create".equals(path)) {
            handleCreate(req, resp);
        } else if ("/categories/edit".equals(path)) {
            handleEdit(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath() + (req.getPathInfo() != null ? req.getPathInfo() : "");
        if ("/categories".equals(path) || "/categories/store".equals(path)) {
            handleStore(req, resp);
        } else if ("/categories/update".equals(path)) {
            handleUpdate(req, resp);
        } else if ("/categories/delete".equals(path)) {
            handleDelete(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryDao.getAllWithPostCount();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/WEB-INF/views/categories/index.jsp").forward(req, resp);
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/categories/create.jsp").forward(req, resp);
    }

    private void handleStore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Category name is required.");
            req.setAttribute("description", description);
            req.getRequestDispatcher("/WEB-INF/views/categories/create.jsp").forward(req, resp);
            return;
        }

        if (categoryDao.nameExists(name.trim(), 0)) {
            req.setAttribute("error", "Category with this name already exists.");
            req.setAttribute("name", name);
            req.setAttribute("description", description);
            req.getRequestDispatcher("/WEB-INF/views/categories/create.jsp").forward(req, resp);
            return;
        }

        Category cat = new Category();
        cat.setName(name.trim());
        cat.setDescription(description != null ? description.trim() : "");

        if (categoryDao.create(cat)) {
            setFlash(req, "flash_success", "The category has been successfully added!");
            resp.sendRedirect(req.getContextPath() + "/categories");
        } else {
            req.setAttribute("error", "Failed to create category.");
            req.getRequestDispatcher("/WEB-INF/views/categories/create.jsp").forward(req, resp);
        }
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        int id = Integer.parseInt(idParam.trim());
        Category cat = categoryDao.findById(id);
        if (cat == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        req.setAttribute("category", cat);
        req.getRequestDispatcher("/WEB-INF/views/categories/edit.jsp").forward(req, resp);
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Category name is required.");
            Category cat = categoryDao.findById(id);
            req.setAttribute("category", cat);
            req.getRequestDispatcher("/WEB-INF/views/categories/edit.jsp").forward(req, resp);
            return;
        }

        if (categoryDao.nameExists(name.trim(), id)) {
            req.setAttribute("error", "Another category already uses this name.");
            Category cat = categoryDao.findById(id);
            req.setAttribute("category", cat);
            req.getRequestDispatcher("/WEB-INF/views/categories/edit.jsp").forward(req, resp);
            return;
        }

        Category cat = new Category(id, name.trim(), description != null ? description.trim() : "");
        if (categoryDao.update(cat)) {
            setFlash(req, "flash_success", "The category has been successfully updated!");
            resp.sendRedirect(req.getContextPath() + "/categories");
        } else {
            req.setAttribute("error", "Failed to update category.");
            req.setAttribute("category", cat);
            req.getRequestDispatcher("/WEB-INF/views/categories/edit.jsp").forward(req, resp);
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        categoryDao.delete(id);
        setFlash(req, "flash_success", "The category and all its posts have been successfully deleted!");
        resp.sendRedirect(req.getContextPath() + "/categories");
    }

    private void setFlash(HttpServletRequest req, String key, String val) {
        req.getSession(true).setAttribute(key, val);
    }
}
