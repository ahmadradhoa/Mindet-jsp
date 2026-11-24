package com.mindet.dao;

import com.mindet.model.Comment;
import com.mindet.util.DB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CommentDao {
    public boolean create(Comment comment) {
        String sql = "INSERT INTO comments (post_id, user_id, body) VALUES (?, ?, ?);";
        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, comment.getPostId());
            ps.setInt(2, comment.getUserId());
            ps.setString(3, comment.getBody());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        comment.setId(keys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Comment findById(int id) {
        String sql = "SELECT * FROM comments WHERE id = ?;";
        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Comment c = new Comment();
                    c.setId(rs.getInt("id"));
                    c.setPostId(rs.getInt("post_id"));
                    c.setUserId(rs.getInt("user_id"));
                    c.setBody(rs.getString("body"));
                    c.setCreatedAt(rs.getTimestamp("created_at"));
                    c.setUpdatedAt(rs.getTimestamp("updated_at"));
                    return c;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM comments WHERE id = ?;";
        try (Connection conn = DB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
