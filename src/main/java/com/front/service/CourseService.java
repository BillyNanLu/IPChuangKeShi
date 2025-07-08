package com.front.service;

import com.front.mapper.CourseMapper;
import com.front.pojo.Course;
import com.front.pojo.CourseMore;
import com.front.pojo.CourseView;
import com.front.pojo.Teacher;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.Arrays;
import java.util.List;

public class CourseService {
    public List<Course> searchCoursesByKeyword(String keyword) {
        SqlSession session = MybatisUtil.getSession();
        CourseMapper courseMapper = session.getMapper(CourseMapper.class);
        return courseMapper.searchCoursesByKeyword(keyword);
    }

    public List<Course> findByCategoryId(int categoryId) {
        SqlSession session = MybatisUtil.getSession();
        CourseMapper mapper = session.getMapper(CourseMapper.class);
        List<Course> courses = mapper.findByCategoryId(categoryId);
        session.close();
        return courses;
    }

    public Course getCourseById(int id) {
        SqlSession session = MybatisUtil.getSession();
        CourseMapper mapper = session.getMapper(CourseMapper.class);
        return mapper.findCourseById(id);
    }

    public List<Course> findByCategoryIds(List<Integer> ids) {
        SqlSession session = MybatisUtil.getSession();
        CourseMapper mapper = session.getMapper(CourseMapper.class);
        List<Course> courses = mapper.findByCategoryIds(ids);
        session.close();
        return courses;
    }

    public List<Course> findCoursesByParentCategoryId(int parentId) {
        try (SqlSession session = MybatisUtil.getSession()) {
            CourseMapper mapper = session.getMapper(CourseMapper.class);
            return mapper.findCoursesByParentCategoryId(parentId);
        }
    }

    public CourseMore getCourseMoreByCourseId(int courseId) {
        SqlSession session = MybatisUtil.getSession();
        CourseMapper mapper = session.getMapper(CourseMapper.class);
        return mapper.findCourseMoreByCourseId(courseId);
    }

    public List<Teacher> getTeachersByCourseId(int courseId) {
        SqlSession session = MybatisUtil.getSession();
        CourseMapper mapper = session.getMapper(CourseMapper.class);
        return mapper.findTeachersByCourseId(courseId);
    }

    public int countCourses(String keyword) {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(CourseMapper.class).countCourses(keyword);
        }
    }

    public List<CourseView> getCourseList(String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(CourseMapper.class).getCourseList(keyword, offset, pageSize);
        }
    }

    public CourseView getCourseViewById(int id) {
        SqlSession session = MybatisUtil.getSession();
        CourseView course = null;
        try {
            CourseMapper mapper = session.getMapper(CourseMapper.class);
            course = mapper.findCourseViewById(id);
            if (course != null && course.getTeacherNames() != null) {
                List<String> teacherList = Arrays.asList(course.getTeacherNames().split(","));
                course.setTeachers(teacherList);
            }
        } finally {
            session.close();
        }
        return course;
    }

    public int insertCourse(Course course) {
        try (SqlSession session = MybatisUtil.getSession()) {
            CourseMapper mapper = session.getMapper(CourseMapper.class);
            int result = mapper.insertCourse(course);
            session.commit();
            return result > 0 ? course.getId() : 0;
        }
    }

    public boolean updateCourse(Course course) {
        try (SqlSession session = MybatisUtil.getSession()) {
            CourseMapper mapper = session.getMapper(CourseMapper.class);
            int rows = mapper.updateCourse(course);
            session.commit();
            return rows > 0;
        }
    }

    public void deleteCourseTeachers(int courseId) {
        try (SqlSession session = MybatisUtil.getSession()) {
            CourseMapper mapper = session.getMapper(CourseMapper.class);
            mapper.deleteCourseTeachersByCourseId(courseId);
            session.commit();
        }
    }

    public void insertCourseTeachers(int courseId, List<Integer> teacherIds) {
        try (SqlSession session = MybatisUtil.getSession()) {
            CourseMapper mapper = session.getMapper(CourseMapper.class);
            mapper.insertCourseTeachers(courseId, teacherIds);
            session.commit();
        }
    }

    public boolean updateCourseMore(Course course) {
        try (SqlSession session = MybatisUtil.getSession()) {
            CourseMapper mapper = session.getMapper(CourseMapper.class);
            int rows = mapper.updateCourseMore(course);
            session.commit();
            return rows > 0;
        }
    }
}
