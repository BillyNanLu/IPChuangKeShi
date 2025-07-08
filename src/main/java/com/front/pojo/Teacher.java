package com.front.pojo;

import java.time.LocalDateTime;

public class Teacher {
    private Integer id;
    private String name;
    private String title;
    private String department;
    private String expertise;
    private String profile;
    private String imgage;
    private LocalDateTime createdTime;
    private LocalDateTime updatedTime;

    public Teacher() {
    }

    public Teacher(Integer id, String name, String title, String department, String expertise, String profile, String imgage, LocalDateTime createdTime, LocalDateTime updatedTime) {
        this.id = id;
        this.name = name;
        this.title = title;
        this.department = department;
        this.expertise = expertise;
        this.profile = profile;
        this.imgage = imgage;
        this.createdTime = createdTime;
        this.updatedTime = updatedTime;
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
    public void setId(Integer id) {
        this.id = id;
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
     * @return title
     */
    public String getTitle() {
        return title;
    }

    /**
     * 设置
     * @param title
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * 获取
     * @return department
     */
    public String getDepartment() {
        return department;
    }

    /**
     * 设置
     * @param department
     */
    public void setDepartment(String department) {
        this.department = department;
    }

    /**
     * 获取
     * @return expertise
     */
    public String getExpertise() {
        return expertise;
    }

    /**
     * 设置
     * @param expertise
     */
    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }

    /**
     * 获取
     * @return profile
     */
    public String getProfile() {
        return profile;
    }

    /**
     * 设置
     * @param profile
     */
    public void setProfile(String profile) {
        this.profile = profile;
    }

    /**
     * 获取
     * @return imgage
     */
    public String getImgage() {
        return imgage;
    }

    /**
     * 设置
     * @param imgage
     */
    public void setImgage(String imgage) {
        this.imgage = imgage;
    }

    /**
     * 获取
     * @return createdAt
     */
    public LocalDateTime getCreatedTime() {
        return createdTime;
    }

    /**
     * 设置
     * @param createdTime
     */
    public void setCreatedTime(LocalDateTime createdTime) {
        this.createdTime = createdTime;
    }

    /**
     * 获取
     * @return updatedTime
     */
    public LocalDateTime getUpdatedTime() {
        return updatedTime;
    }

    /**
     * 设置
     * @param updatedTime
     */
    public void setUpdatedTime(LocalDateTime updatedTime) {
        this.updatedTime = updatedTime;
    }

    public String toString() {
        return "Teacher{id = " + id + ", name = " + name + ", title = " + title + ", department = " + department + ", expertise = " + expertise + ", profile = " + profile + ", imgage = " + imgage + ", createdTime = " + createdTime + ", , createdTime = " + createdTime + "}";
    }
}
