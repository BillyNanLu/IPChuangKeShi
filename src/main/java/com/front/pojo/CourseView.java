package com.front.pojo;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class CourseView {
    private int id;
    private String name;
    private String tags;
    private String intro;
    private LocalDateTime createTime;
    private BigDecimal price;
    private BigDecimal discount;
    private String image;
    private String targetUser;
    private String recommendation;
    private String teacherNames;
    private String fullCategoryPath;
    private LocalDateTime updateTime;

    // 分类
    private String category1;
    private String category2;
    private String category3;

    public CourseView() {
    }

    public CourseView(int id, String name, String tags, String intro, LocalDateTime createTime, BigDecimal price, BigDecimal discount, String image, String category1, String category2, String category3, List<String> teachers) {
        this.id = id;
        this.name = name;
        this.tags = tags;
        this.intro = intro;
        this.createTime = createTime;
        this.price = price;
        this.discount = discount;
        this.image = image;
        this.category1 = category1;
        this.category2 = category2;
        this.category3 = category3;
        this.teachers = teachers;
    }

    public String getFullCategoryPath() {
        StringBuilder sb = new StringBuilder();
        if (category1 != null) sb.append(category1).append("/");
        if (category2 != null) sb.append(category2).append("/");
        if (category3 != null) sb.append(category3);
        return sb.toString().replaceAll("/$", ""); // 去尾部斜杠
    }

    // 教师
    private List<String> teachers;

    public void setTeacherNames(String names) {
        if (names != null) {
            this.teachers = Arrays.asList(names.split(","));
        } else {
            this.teachers = new ArrayList<>();
        }
    }

    /**
     * 获取
     * @return id
     */
    public int getId() {
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
     * @return createdAt
     */
    public LocalDateTime getCreateTime() {
        return createTime;
    }

    /**
     * 设置
     * @param createTime
     */
    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public String getCreateTimeStr() {
        return createTime != null ? createTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : null;
    }

    /**
     * 获取
     * @return price
     */
    public BigDecimal getPrice() {
        return price;
    }

    /**
     * 设置
     * @param price
     */
    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    /**
     * 获取
     * @return discount
     */
    public BigDecimal getDiscount() {
        return discount;
    }

    /**
     * 设置
     * @param discount
     */
    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
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

    public String getTargetUser() {
        return targetUser;
    }

    public void setTargetUser(String targetUser) {
        this.targetUser = targetUser;
    }

    public String getRecommendation() {
        return recommendation;
    }

    public void setRecommendation(String recommendation) {
        this.recommendation = recommendation;
    }

    public String getTeacherNames() {
        return teacherNames;
    }

    public void setFullCategoryPath(String fullCategoryPath) {
        this.fullCategoryPath = fullCategoryPath;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }

    /**
     * 获取
     * @return category1
     */
    public String getCategory1() {
        return category1;
    }

    /**
     * 设置
     * @param category1
     */
    public void setCategory1(String category1) {
        this.category1 = category1;
    }

    /**
     * 获取
     * @return category2
     */
    public String getCategory2() {
        return category2;
    }

    /**
     * 设置
     * @param category2
     */
    public void setCategory2(String category2) {
        this.category2 = category2;
    }

    /**
     * 获取
     * @return category3
     */
    public String getCategory3() {
        return category3;
    }

    /**
     * 设置
     * @param category3
     */
    public void setCategory3(String category3) {
        this.category3 = category3;
    }

    /**
     * 获取
     * @return teachers
     */
    public List<String> getTeachers() {
        return teachers;
    }

    /**
     * 设置
     * @param teachers
     */
    public void setTeachers(List<String> teachers) {
        this.teachers = teachers;
    }

    @Override
    public String toString() {
        return "CourseView{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", tags='" + tags + '\'' +
                ", intro='" + intro + '\'' +
                ", createTime=" + createTime +
                ", price=" + price +
                ", discount=" + discount +
                ", image='" + image + '\'' +
                ", targetUser='" + targetUser + '\'' +
                ", recommendation='" + recommendation + '\'' +
                ", teacherNames='" + teacherNames + '\'' +
                ", fullCategoryPath='" + fullCategoryPath + '\'' +
                ", updateTime=" + updateTime +
                ", category1='" + category1 + '\'' +
                ", category2='" + category2 + '\'' +
                ", category3='" + category3 + '\'' +
                ", teachers=" + teachers +
                '}';
    }
}
