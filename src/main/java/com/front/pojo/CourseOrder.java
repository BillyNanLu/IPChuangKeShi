package com.front.pojo;

import java.time.LocalDateTime;

public class CourseOrder {
    private Integer id;
    private String orderNo;
    private Integer courseId;
    private Integer userId;
    private String payMethod;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime paidAt;

    private String userName;     // 对应数据库 user_name
    private String courseName;   // 对应数据库 course_name

    public CourseOrder() {
    }

    public CourseOrder(Integer id, String orderNo, Integer courseId, Integer userId, String payMethod, String status, LocalDateTime createdAt, LocalDateTime paidAt) {
        this.id = id;
        this.orderNo = orderNo;
        this.courseId = courseId;
        this.userId = userId;
        this.payMethod = payMethod;
        this.status = status;
        this.createdAt = createdAt;
        this.paidAt = paidAt;
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
     * @return orderNo
     */
    public String getOrderNo() {
        return orderNo;
    }

    /**
     * 设置
     * @param orderNo
     */
    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    /**
     * 获取
     * @return courseId
     */
    public Integer getCourseId() {
        return courseId;
    }

    /**
     * 设置
     * @param courseId
     */
    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    /**
     * 获取
     * @return userId
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * 设置
     * @param userId
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * 获取
     * @return payMethod
     */
    public String getPayMethod() {
        return payMethod;
    }

    /**
     * 设置
     * @param payMethod
     */
    public void setPayMethod(String payMethod) {
        this.payMethod = payMethod;
    }

    /**
     * 获取
     * @return status
     */
    public String getStatus() {
        return status;
    }

    /**
     * 设置
     * @param status
     */
    public void setStatus(String status) {
        this.status = status;
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
     * @return paidAt
     */
    public LocalDateTime getPaidAt() {
        return paidAt;
    }

    /**
     * 设置
     * @param paidAt
     */
    public void setPaidAt(LocalDateTime paidAt) {
        this.paidAt = paidAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    @Override
    public String toString() {
        return "CourseOrder{" +
                "id=" + id +
                ", orderNo='" + orderNo + '\'' +
                ", courseId=" + courseId +
                ", userId=" + userId +
                ", payMethod='" + payMethod + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                ", paidAt=" + paidAt +
                ", userName='" + userName + '\'' +
                ", courseName='" + courseName + '\'' +
                '}';
    }
}
