package com.front.pojo;

import java.util.List;

public class CourseCategory {
    private Integer id;
    private Integer parentId;
    private String name;
    private String type;

    private List<CourseCategory> children; // 添加这个字段 + getter/setter

    public CourseCategory() {
    }

    public CourseCategory(Integer id, Integer parentId, String name, String type) {
        this.id = id;
        this.parentId = parentId;
        this.name = name;
        this.type = type;
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
     * @return parentId
     */
    public Integer getParentId() {
        return parentId;
    }

    /**
     * 设置
     * @param parentId
     */
    public void setParentId(Integer parentId) {
        this.parentId = parentId;
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
     * @return type
     */
    public String getType() {
        return type;
    }

    /**
     * 设置
     * @param type
     */
    public void setType(String type) {
        this.type = type;
    }

    public List<CourseCategory> getChildren() {
        return children;
    }

    public void setChildren(List<CourseCategory> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return "CourseCategory{" +
                "id=" + id +
                ", parentId=" + parentId +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", children=" + children +
                '}';
    }
}
