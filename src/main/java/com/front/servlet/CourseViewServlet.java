package com.front.servlet;

import com.front.pojo.CourseView;
import com.front.service.CourseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/courseView")
public class CourseViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        CourseView course = courseService.getCourseViewById(id);
        request.setAttribute("course", course);
        request.getRequestDispatcher("course_view.jsp").forward(request, response);
    }
}
