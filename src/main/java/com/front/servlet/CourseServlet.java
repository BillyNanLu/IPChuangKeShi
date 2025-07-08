package com.front.servlet;

import com.front.pojo.Course;
import com.front.pojo.CourseCategory;
import com.front.service.CourseCategoryService;
import com.front.service.CourseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(name = "courses", value = "/courses")
public class CourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CourseService courseService = new CourseService();
    private CourseCategoryService categoryService = new CourseCategoryService();

    public CourseServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");

        if (keyword != null && !keyword.trim().isEmpty()) {
            List<Course> searchResult = courseService.searchCoursesByKeyword(keyword);
            request.setAttribute("searchResult", searchResult);
            request.setAttribute("searchKeyword", keyword);
        }

//        // 生涯规划师课程（category_id=1）
//        List<Course> plannerCourses = courseService.findByCategoryId(1);
//        request.setAttribute("plannerCourses", plannerCourses);
//
//        // IP个体 - 校园版（二级分类id=3）
//        List<CourseCategory> campusSubCategories = categoryService.findSubCategories(3);
//        Map<CourseCategory, List<Course>> campusMap = new LinkedHashMap<>();
//        for (CourseCategory cat : campusSubCategories) {
//            List<Course> courses = courseService.findByCategoryId(cat.getId());
//            campusMap.put(cat, courses);
//        }
//        request.setAttribute("campusCourses", campusMap);
//
//        // IP个体 - 职场版（二级分类id=4）
//        List<CourseCategory> careerSubCategories = categoryService.findSubCategories(4);
//        Map<CourseCategory, List<Course>> careerMap = new LinkedHashMap<>();
//        for (CourseCategory cat : careerSubCategories) {
//            List<Course> courses = courseService.findByCategoryId(cat.getId());
//            careerMap.put(cat, courses);
//        }
//        request.setAttribute("careerCourses", careerMap);

        // 1. 生涯规划师课程（不需要优化）
        List<Course> plannerCourses = courseService.findByCategoryId(1);
        request.setAttribute("plannerCourses", plannerCourses);

        // 2. 校园版
        List<CourseCategory> campusSubCategories = categoryService.findSubCategories(3);
        List<Integer> campusCategoryIds = campusSubCategories.stream().map(CourseCategory::getId).toList();
        List<Course> campusAllCourses = courseService.findByCategoryIds(campusCategoryIds);

        Map<CourseCategory, List<Course>> campusMap = new LinkedHashMap<>();
        for (CourseCategory cat : campusSubCategories) {
            List<Course> courses = campusAllCourses.stream()
                    .filter(c -> Objects.equals(c.getCategoryId(), cat.getId()))
                    .toList();
            campusMap.put(cat, courses);
        }
        request.setAttribute("campusCourses", campusMap);

        // 3. 职场版
        List<CourseCategory> careerSubCategories = categoryService.findSubCategories(4);
        List<Integer> careerCategoryIds = careerSubCategories.stream().map(CourseCategory::getId).toList();
        List<Course> careerAllCourses = courseService.findByCategoryIds(careerCategoryIds);

        Map<CourseCategory, List<Course>> careerMap = new LinkedHashMap<>();
        for (CourseCategory cat : careerSubCategories) {
            List<Course> courses = careerAllCourses.stream()
                    .filter(c -> Objects.equals(c.getCategoryId(), cat.getId()))
                    .toList();
            careerMap.put(cat, courses);
        }
        request.setAttribute("careerCourses", careerMap);

        System.out.println("=== 校园版课程 ===");
        for (Map.Entry<CourseCategory, List<Course>> entry : campusMap.entrySet()) {
            System.out.println("分类: " + entry.getKey().getName() + "，课程数量: " + entry.getValue().size());
        }

        System.out.println("=== 职场版课程 ===");
        for (Map.Entry<CourseCategory, List<Course>> entry : careerMap.entrySet()) {
            System.out.println("分类: " + entry.getKey().getName() + "，课程数量: " + entry.getValue().size());
        }

        request.getRequestDispatcher("/course.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        super.doPost(request, response);
    }
}
