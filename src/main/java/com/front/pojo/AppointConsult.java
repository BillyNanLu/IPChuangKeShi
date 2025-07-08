package com.front.pojo;

import java.time.LocalDateTime;

public class AppointConsult {
    private Integer id;
    private String appointment_id;
    private String name;
    private String phone;
    private String description;
    private LocalDateTime created_at;

    public AppointConsult() {
    }

    public AppointConsult(Integer id, String appointment_id, String name, String phone, String description, LocalDateTime created_at) {
        this.id = id;
        this.appointment_id = appointment_id;
        this.name = name;
        this.phone = phone;
        this.description = description;
        this.created_at = created_at;
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
     * @return appointment_id
     */
    public String getAppointment_id() {
        return appointment_id;
    }

    /**
     * 设置
     * @param appointment_id
     */
    public void setAppointment_id(String appointment_id) {
        this.appointment_id = appointment_id;
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
     * @return phone
     */
    public String getPhone() {
        return phone;
    }

    /**
     * 设置
     * @param phone
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * 获取
     * @return description
     */
    public String getDescription() {
        return description;
    }

    /**
     * 设置
     * @param description
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * 获取
     * @return created_at
     */
    public LocalDateTime getCreated_at() {
        return created_at;
    }

    /**
     * 设置
     * @param created_at
     */
    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public String toString() {
        return "AppointConsultBean{id = " + id + ", appointment_id = " + appointment_id + ", name = " + name + ", phone = " + phone + ", description = " + description + ", created_at = " + created_at + "}";
    }
}
