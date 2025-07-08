package com.front.pojo;

import java.time.LocalDateTime;

public class AppointInformation {
    private Integer id;
    private String appointmentId; // 对应数据库appointment_id
    private String name;
    private String phone;
    private String time;
    private String city;
    private String industry;
    private String experience;
    private String paidConsult; // 对应数据库paid_consult
    private String description;
    private LocalDateTime createdAt; // 对应数据库created_at
    private LocalDateTime updatedAt; // 对应数据库updated_at
    private Integer status;

    // 无参构造
    public AppointInformation() {}

    // getter和setter（严格对应数据库字段与实体类属性）
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getAppointmentId() { return appointmentId; }
    public void setAppointmentId(String appointmentId) { this.appointmentId = appointmentId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getIndustry() { return industry; }
    public void setIndustry(String industry) { this.industry = industry; }
    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }
    public String getPaidConsult() { return paidConsult; }
    public void setPaidConsult(String paidConsult) { this.paidConsult = paidConsult; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
}