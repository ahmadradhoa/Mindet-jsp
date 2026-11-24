package com.mindet.util;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB {
    private static String dbPath = null;

    static {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static synchronized void init(String customPath) {
        if (customPath != null && !customPath.isEmpty()) {
            dbPath = customPath;
        } else {
            dbPath = new File("mindet.sqlite").getAbsolutePath();
        }
        initializeSchema();
    }

    public static Connection getConnection() throws SQLException {
        if (dbPath == null) {
            init(null);
        }
        Connection conn = DriverManager.getConnection("jdbc:sqlite:" + dbPath);
        try (Statement stmt = conn.createStatement()) {
            stmt.execute("PRAGMA foreign_keys = ON;");
        }
        return conn;
    }

    private static void initializeSchema() {
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            stmt.execute("CREATE TABLE IF NOT EXISTS users ("
                    + "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    + "name VARCHAR(255) NOT NULL, "
                    + "email VARCHAR(255) NOT NULL UNIQUE, "
                    + "password VARCHAR(255) NOT NULL, "
                    + "profile_picture VARCHAR(50) DEFAULT '#6366f1', "
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);");

            stmt.execute("CREATE TABLE IF NOT EXISTS categories ("
                    + "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    + "name VARCHAR(100) NOT NULL UNIQUE, "
                    + "description TEXT, "
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);");

            stmt.execute("CREATE TABLE IF NOT EXISTS posts ("
                    + "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    + "user_id INTEGER NOT NULL, "
                    + "category_id INTEGER NOT NULL, "
                    + "title VARCHAR(255) NOT NULL, "
                    + "body TEXT NOT NULL, "
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE, "
                    + "FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE);");

            stmt.execute("CREATE TABLE IF NOT EXISTS comments ("
                    + "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    + "post_id INTEGER NOT NULL, "
                    + "user_id INTEGER NOT NULL, "
                    + "body TEXT NOT NULL, "
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                    + "FOREIGN KEY(post_id) REFERENCES posts(id) ON DELETE CASCADE, "
                    + "FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE);");

            // Seed if users table is empty
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users;");
            if (rs.next() && rs.getInt(1) == 0) {
                seedData(conn);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void seedData(Connection conn) throws SQLException {
        // Create demo user
        String userSql = "INSERT INTO users (name, email, password, profile_picture) VALUES (?, ?, ?, ?);";
        int userId = 1;
        try (PreparedStatement ps = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, "Demo User");
            ps.setString(2, "demo@mail.com");
            ps.setString(3, PasswordUtil.hash("password"));
            ps.setString(4, "#6366f1");
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                userId = keys.getInt(1);
            }
        }

        // Create categories
        int techId = 1;
        String catSql = "INSERT INTO categories (name, description) VALUES (?, ?);";
        try (PreparedStatement ps = conn.prepareStatement(catSql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, "Teknologi");
            ps.setString(2, "Diskusi seputar programming dan teknologi.");
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                techId = keys.getInt(1);
            }
        }
        try (PreparedStatement ps = conn.prepareStatement(catSql)) {
            ps.setString(1, "Gaming");
            ps.setString(2, "Share game favorit dan tips bermain.");
            ps.executeUpdate();
            ps.setString(1, "General");
            ps.setString(2, "Apa saja yang ingin kamu obrolkan.");
            ps.executeUpdate();
        }

        // Create post
        int postId = 1;
        String postSql = "INSERT INTO posts (user_id, category_id, title, body) VALUES (?, ?, ?, ?);";
        try (PreparedStatement ps = conn.prepareStatement(postSql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setInt(2, techId);
            ps.setString(3, "Belajar Laravel & JSP itu gampang banget!");
            ps.setString(4, "Setelah paham MVC, routing, dan Servlets/JSP, bikin CRUD jadi jauh lebih cepat dan terstruktur. Ada yang punya tips belajar lain?");
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                postId = keys.getInt(1);
            }
        }

        // Create comment
        String commentSql = "INSERT INTO comments (post_id, user_id, body) VALUES (?, ?, ?);";
        try (PreparedStatement ps = conn.prepareStatement(commentSql)) {
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ps.setString(3, "Setuju! Dokumentasi resminya juga lengkap banget.");
            ps.executeUpdate();
        }
    }
}
