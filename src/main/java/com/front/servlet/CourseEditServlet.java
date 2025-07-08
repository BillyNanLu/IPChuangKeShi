package com.front.servlet;

import com.front.pojo.Course;
import com.front.service.CourseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

@WebServlet("/courseEdit")
@MultipartConfig
public class CourseEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CourseService courseService = new CourseService();

    // 统一转发到编辑页面
    private void forwardToEditPage(HttpServletRequest request, HttpServletResponse response, Course course, String msg) throws ServletException, IOException {
        request.getRequestDispatcher("course_edit.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        response.sendRedirect("courseList");
    }

}
