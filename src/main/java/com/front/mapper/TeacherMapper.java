package com.front.mapper;

import com.front.pojo.Teacher;

import java.util.List;

public interface TeacherMapper {
    List<Teacher> findByDepartment(String department);
    List<Teacher> findByCourseId(int courseId);
    List<Teacher> findAll();
    Teacher findById(int id);
}