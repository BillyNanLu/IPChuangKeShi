package com.front.servlet;

import com.front.pojo.AppointConsult;
import com.front.pojo.Course;
import com.front.pojo.Teacher;
import com.front.service.AppointConsultService;
import com.front.service.CourseCategoryService;
import com.front.service.CourseService;
import com.front.service.TeacherService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CourseService courseService = new CourseService();
    private final TeacherService teacherService = new TeacherService();
    private final CourseCategoryService categoryService = new CourseCategoryService();
    private final AppointConsultService appointService = new AppointConsultService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int plannerId = categoryService.findIdByName("生涯规划师");
        List<Course> plannerCourses = courseService.findByCategoryId(plannerId);
        List<Teacher> departmentTeachers = teacherService.findByDepartment("生涯规划学院");

        request.setAttribute("plannerCourses", plannerCourses);
        request.setAttribute("departmentTeachers", departmentTeachers);
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        AppointConsult bean = new AppointConsult();
        bean.setName(request.getParameter("appoint_name"));
        bean.setPhone(request.getParameter("appoint_phone"));
        bean.setDescription(request.getParameter("appoint_description"));
        bean.setCreated_at(LocalDateTime.now());
        bean.setAppointment_id("AP" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 4));

        boolean success = appointService.addAppointConsult(bean);

        if (success) {
            response.sendRedirect("home.jsp?success=true");
        } else {
            request.setAttribute("error", "咨询申请失败，请稍后再试");
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        }
    }
}