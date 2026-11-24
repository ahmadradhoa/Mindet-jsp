package com.mindet.dao;

import com.mindet.model.Category;
import com.mindet.model.Comment;
import com.mindet.model.Post;
import com.mindet.model.User;
import com.mindet.util.DB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    public List<Post> getPosts(Integer categoryId, String search) {
        List<Post> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.*, "
                + "u.name AS user_name, u.email AS user_email, u.profile_picture AS user_profile_picture, "
                + "c.name AS category_name, "
                + "(SELECT COUNT(*) FROM comments cm WHERE cm.post_id = p.id) AS comments_count "
                + "FROM posts p "
                + "JOIN users u ON p.user_id = u.id "
                + "JOIN categories c ON p.category_id = c.id "
                + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();
        if (categoryId != null && categoryId > 0) {
            sql.append("AND p.category_id = ? ");
            params.add(categoryId);
        }
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (p.title LIKE ? OR p.body LIKE ?) ");
            String wild = "%" + search.trim() + "%";
            params.add(wild);
            params.add(wild);
        }
        sql.append("ORDER BY p.created_at DESC;");

        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post p = new Post();
                    p.setId(rs.getInt("id"));
                    p.setUserId(rs.getInt("user_id"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setTitle(rs.getString("title"));
                    p.setBody(rs.getString("body"));
                    p.setCreatedAt(rs.getTimestamp("created_at"));
                    p.setUpdatedAt(rs.getTimestamp("updated_at"));
                    p.setCommentsCount(rs.getInt("comments_count"));

                    User u = new User();
                    u.setId(rs.getInt("user_id"));
                    u.setName(rs.getString("user_name"));
                    u.setEmail(rs.getString("user_email"));
                    u.setProfilePicture(rs.getString("user_profile_picture"));
                    p.setUser(u);

                    Category cat = new Category();
                    cat.setId(rs.getInt("category_id"));
                    cat.setName(rs.getString("category_name"));
                    p.setCategory(cat);

                    list.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Post findById(int id) {
        String sql = "SELECT p.*, "
                + "u.name AS user_name, u.email AS user_email, u.profile_picture AS user_profile_picture, "
                + "c.name AS category_name, "
                + "(SELECT COUNT(*) FROM comments cm WHERE cm.post_id = p.id) AS comments_count "
                + "FROM posts p "
                + "JOIN users u ON p.user_id = u.id "
                + "JOIN categories c ON p.category_id = c.id "
                + "WHERE p.id = ?;";

        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Post p = new Post();
                    p.setId(rs.getInt("id"));
                    p.setUserId(rs.getInt("user_id"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setTitle(rs.getString("title"));
                    p.setBody(rs.getString("body"));
                    p.setCreatedAt(rs.getTimestamp("created_at"));
                    p.setUpdatedAt(rs.getTimestamp("updated_at"));
                    p.setCommentsCount(rs.getInt("comments_count"));

                    User u = new User();
                    u.setId(rs.getInt("user_id"));
                    u.setName(rs.getString("user_name"));
                    u.setEmail(rs.getString("user_email"));
                    u.setProfilePicture(rs.getString("user_profile_picture"));
                    p.setUser(u);

                    Category cat = new Category();
                    cat.setId(rs.getInt("category_id"));
                    cat.setName(rs.getString("category_name"));
                    p.setCategory(cat);

                    // Load comments
                    p.setComments(loadComments(conn, id));

                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private List<Comment> loadComments(Connection conn, int postId) throws SQLException {
        List<Comment> list = new ArrayList<>();
        String sql = "SELECT cm.*, u.name AS user_name, u.profile_picture AS user_profile_picture "
                + "FROM comments cm "
                + "JOIN users u ON cm.user_id = u.id "
                + "WHERE cm.post_id = ? "
                + "ORDER BY cm.created_at ASC;";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comment cm = new Comment();
                    cm.setId(rs.getInt("id"));
                    cm.setPostId(rs.getInt("post_id"));
                    cm.setUserId(rs.getInt("user_id"));
                    cm.setBody(rs.getString("body"));
                    cm.setCreatedAt(rs.getTimestamp("created_at"));
                    cm.setUpdatedAt(rs.getTimestamp("updated_at"));

                    User u = new User();
                    u.setId(rs.getInt("user_id"));
                    u.setName(rs.getString("user_name"));
                    u.setProfilePicture(rs.getString("user_profile_picture"));
                    cm.setUser(u);

                    list.add(cm);
                }
            }
        }
        return list;
    }

    public boolean create(Post post) {
        String sql = "INSERT INTO posts (user_id, category_id, title, body) VALUES (?, ?, ?, ?);";
        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, post.getUserId());
            ps.setInt(2, post.getCategoryId());
            ps.setString(3, post.getTitle());
            ps.setString(4, post.getBody());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        post.setId(keys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Post post) {
        String sql = "UPDATE posts SET category_id = ?, title = ?, body = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?;";
        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, post.getCategoryId());
            ps.setString(2, post.getTitle());
            ps.setString(3, post.getBody());
            ps.setInt(4, post.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM posts WHERE id = ?;";
        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
