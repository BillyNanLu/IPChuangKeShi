package com.front.mapper;

import com.front.pojo.Teacher;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherMapper {
    List<Teacher> findByDepartment(String department);
    List<Teacher> findByCourseId(int courseId);
    List<Teacher> findAll();
    Teacher findById(int id);

    int getTeacherCount(@Param("keyword") String keyword);

    List<Teacher> getTeachers(@Param("keyword") String keyword,
                              @Param("offset") int offset,
                              @Param("limit") int limit);

    Teacher selectById(int id);

    int update(Teacher teacher);

    int insert(Teacher teacher);

    int deleteById(@Param("id") int id);
}