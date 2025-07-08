package com.front.pojo;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Course {
    private Integer id;
    private Integer categoryId;
    private String name;
    private String tags;
    private String intro;
    private String targetUser;
    private String recommendation;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private CourseMore courseMore;

    public Course() {
    }

    public Course(Integer id, Integer categoryId, String name, String tags, String intro, String targetUser, String recommendation, LocalDateTime createdAt, LocalDateTime updatedAt, CourseMore courseMore) {
        this.id = id;
        this.categoryId = categoryId;
        this.name = name;
        this.tags = tags;
        this.intro = intro;
        this.targetUser = targetUser;
        this.recommendation = recommendation;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.courseMore = courseMore;
    }

    /**
     * 获取
     * @return id
     */
    public Integer getId() {
        return id;
    }

    /**
     * 设置
     * @param id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * 获取
     * @return categoryId
     */
    public Integer getCategoryId() {
        return categoryId;
    }

    /**
     * 设置
     * @param categoryId
     */
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    /**
     * 获取
     * @return name
     */
    public String getName() {
        return name;
    }

    /**
     * 设置
     * @param name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取
     * @return tags
     */
    public String getTags() {
        return tags;
    }

    /**
     * 设置
     * @param tags
     */
    public void setTags(String tags) {
        this.tags = tags;
    }

    /**
     * 获取
     * @return intro
     */
    public String getIntro() {
        return intro;
    }

    /**
     * 设置
     * @param intro
     */
    public void setIntro(String intro) {
        this.intro = intro;
    }

    /**
     * 获取
     * @return targetUser
     */
    public String getTargetUser() {
        return targetUser;
    }

    /**
     * 设置
     * @param targetUser
     */
    public void setTargetUser(String targetUser) {
        this.targetUser = targetUser;
    }

    /**
     * 获取
     * @return recommendation
     */
    public String getRecommendation() {
        return recommendation;
    }

    /**
     * 设置
     * @param recommendation
     */
    public void setRecommendation(String recommendation) {
        this.recommendation = recommendation;
    }

    /**
     * 获取
     * @return createdAt
     */
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    /**
     * 设置
     * @param createdAt
     */
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * 获取
     * @return updatedAt
     */
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    /**
     * 设置
     * @param updatedAt
     */
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    /**
     * 获取
     * @return courseMore
     */
    public CourseMore getCourseMore() {
        return courseMore;
    }

    /**
     * 设置
     * @param courseMore
     */
    public void setCourseMore(CourseMore courseMore) {
        this.courseMore = courseMore;
    }

    public String toString() {
        return "Course{id = " + id + ", categoryId = " + categoryId + ", name = " + name + ", tags = " + tags + ", intro = " + intro + ", targetUser = " + targetUser + ", recommendation = " + recommendation + ", createdAt = " + createdAt + ", updatedAt = " + updatedAt + ", courseMore = " + courseMore + "}";
    }
}
