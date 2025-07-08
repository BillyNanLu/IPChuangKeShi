package com.front.servlet;

import com.front.pojo.Course;
import com.front.pojo.CourseMore;
import com.front.pojo.User;
import com.front.service.CourseOrderService;
import com.front.service.CourseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

@WebServlet("/enroll")
public class EnrollServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CourseService courseService = new CourseService();
    private final CourseOrderService orderService = new CourseOrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");

        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr == null) {
            response.sendRedirect("courses");
            return;
        }
        int courseId = Integer.parseInt(courseIdStr);

        if (user == null) {
            session.setAttribute("redirectAfterLogin", "enroll?courseId=" + courseId);
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUserId();

        if (orderService.hasEnrolled(courseId, userId)) {
            String msg = java.net.URLEncoder.encode("您已报名该课程，无需重复报名", "UTF-8");
            request.getRequestDispatcher("courseDetail?id=" + courseId + "&msg=" + msg).forward(request, response);
            return;
        }

        String orderNo = generateOrderNo();
        orderService.insertOrder(orderNo, courseId, userId);

        Course course = courseService.getCourseById(courseId);
        CourseMore courseMore = courseService.getCourseMoreByCourseId(courseId);

        request.setAttribute("orderNo", orderNo);
        request.setAttribute("course", course);
        request.setAttribute("courseMore", courseMore);

        request.getRequestDispatcher("courseSuccess.jsp").forward(request, response);
    }

    private String generateOrderNo() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String nowStr = LocalDateTime.now().format(dtf);
        int randomNum = new Random().nextInt(9000) + 1000;
        return "CO" + nowStr + randomNum;
    }
}
