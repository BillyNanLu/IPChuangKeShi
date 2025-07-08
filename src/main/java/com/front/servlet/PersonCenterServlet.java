package com.front.servlet;

import com.front.pojo.CourseOrder;
import com.front.pojo.User;
import com.front.service.CourseOrderService;
import com.front.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/personCenter")
public class PersonCenterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService usersService = new UserService();
    private CourseOrderService orderService = new CourseOrderService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer user_id = (Integer) request.getSession().getAttribute("user_id");

        if (user_id == null) {

            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<CourseOrder> orderBeanList = orderService.listByUserId(user_id);
            User person = usersService.get(user_id);

            request.setAttribute("orderList", orderBeanList);
            request.setAttribute("person", person);

            request.getRequestDispatcher("/personalCenter.jsp").forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/");
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
