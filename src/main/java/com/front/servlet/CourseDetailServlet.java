package com.front.servlet;

import com.front.pojo.Course;
import com.front.pojo.CourseMore;
import com.front.pojo.Teacher;
import com.front.service.CourseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/courseDetail")
public class CourseDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CourseService courseService = new CourseService();

    public CourseDetailServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("courses");
            return;
        }
        int courseId = Integer.parseInt(idStr);
        Course course = courseService.getCourseById(courseId);
        CourseMore courseMore = courseService.getCourseMoreByCourseId(courseId);
        List<Teacher> teachers = courseService.getTeachersByCourseId(courseId);

        request.setAttribute("course", course);
        request.setAttribute("courseMore", courseMore);
        request.setAttribute("teachers", teachers);

        request.getRequestDispatcher("courseDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        super.doPost(request, response);
    }
}
