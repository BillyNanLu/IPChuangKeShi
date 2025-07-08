package com.front.mapper;

import com.front.pojo.Course;
import com.front.pojo.CourseMore;
import com.front.pojo.CourseView;
import com.front.pojo.Teacher;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CourseMapper {
    // （可选）按关键词搜索课程
    List<Course> searchCoursesByKeyword(@Param("keyword") String keyword);

    List<Course> findByCategoryId(@Param("categoryId") int categoryId);

    // 一次性查多个分类下的课程（用于性能优化）
    List<Course> findByCategoryIds(@Param("ids") List<Integer> ids);

    // 通过二级分类的 parent_id 一次性查出所有三级分类下的课程
    List<Course> findCoursesByParentCategoryId(int parentId);

    Course findCourseById(@Param("id") int id);

    CourseMore findCourseMoreByCourseId(@Param("courseId") int courseId);

    List<Teacher> findTeachersByCourseId(@Param("courseId") int courseId);

    // （可选）通过课程ID查单个课程
    Course findById(@Param("id") int id);

    int countCourses(@Param("keyword") String keyword);

    List<CourseView> getCourseList(@Param("keyword") String keyword,
                                   @Param("offset") int offset,
                                   @Param("limit") int limit
    );

    CourseView findCourseViewById(@Param("id") int id);


    Course selectCourseById(int id);

    List<Integer> selectTeacherIdsByCourseId(int courseId);

    int insertCourse(Course course);

    int updateCourse(Course course);

    void deleteCourseTeachersByCourseId(int courseId);

    void insertCourseTeachers(@Param("courseId") int courseId, @Param("teacherIds") List<Integer> teacherIds);

    int updateCourseMore(Course course);
}
