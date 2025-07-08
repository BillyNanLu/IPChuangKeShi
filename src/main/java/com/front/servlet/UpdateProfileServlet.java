package com.front.servlet;

import com.front.pojo.User;
import com.front.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    private UserService usersService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer userId = Integer.valueOf(request.getParameter("user_id"));
        String username = request.getParameter("username");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        User usersBean = new User();
        usersBean.setUserId(userId);
        usersBean.setUsername(username);
        usersBean.setGender(gender);
        usersBean.setEmail(email);
        usersBean.setPhone(phone);
        usersBean.setAvatar("2222222");
        usersService.updateProfile(usersBean);
        User userProfile = usersService.get(userId);
        request.getSession().setAttribute("loginUser", userProfile);

        response.sendRedirect(request.getContextPath() + "/personCenter");

    }
}
