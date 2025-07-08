package com.front.pojo;

public class CourseMore {
    private Integer id;
    private Integer courseId;
    private String image;
    private Double price;
    private Double discount;

    public CourseMore() {
    }

    public CourseMore(Integer id, Integer courseId, String image, Double price, Double discount) {
        this.id = id;
        this.courseId = courseId;
        this.image = image;
        this.price = price;
        this.discount = discount;
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
     * @return image
     */
    public String getImage() {
        return image;
    }

    /**
     * 设置
     * @param image
     */
    public void setImage(String image) {
        this.image = image;
    }

    /**
     * 获取
     * @return price
     */
    public Double getPrice() {
        return price;
    }

    /**
     * 设置
     * @param price
     */
    public void setPrice(Double price) {
        this.price = price;
    }

    /**
     * 获取
     * @return discount
     */
    public Double getDiscount() {
        return discount;
    }

    /**
     * 设置
     * @param discount
     */
    public void setDiscount(Double discount) {
        this.discount = discount;
    }

    public String toString() {
        return "CourseMore{id = " + id + ", courseId = " + courseId + ", image = " + image + ", price = " + price + ", discount = " + discount + "}";
    }
}
