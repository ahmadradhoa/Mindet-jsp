package com.mindet.model;

import com.mindet.util.DateUtil;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Post {
    private int id;
    private int userId;
    private int categoryId;
    private String title;
    private String body;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private User user;
    private Category category;
    private int commentsCount;
    private List<Comment> comments = new ArrayList<>();

    public Post() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getCommentsCount() {
        return commentsCount;
    }

    public void setCommentsCount(int commentsCount) {
        this.commentsCount = commentsCount;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public String getDiffForHumans() {
        return DateUtil.diffForHumans(createdAt);
    }

    public String getFormattedDate() {
        return DateUtil.formatJakarta(createdAt);
    }

    public String getSnippet() {
        if (body == null) return "";
        if (body.length() <= 180) return body;
        return body.substring(0, 180) + "...";
    }
}
