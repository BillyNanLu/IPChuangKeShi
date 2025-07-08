package com.front.servlet;

import com.front.pojo.CourseView;
import com.front.service.CourseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/courseList")
public class CourseListServlet extends HttpServlet {
    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        int page = 1;
        int pageSize = 10;

        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
                if (page <= 0) page = 1;
            }
        } catch (Exception ignored) {}

        int totalCount = courseService.countCourses(keyword);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        List<CourseView> courseList = courseService.getCourseList(keyword, page, pageSize);

        request.setAttribute("courseList", courseList);
        request.setAttribute("keyword", keyword != null ? keyword : "");
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("course_list.jsp").forward(request, response);
    }
}
