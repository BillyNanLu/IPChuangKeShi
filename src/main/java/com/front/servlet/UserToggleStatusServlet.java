package com.front.servlet;

import com.front.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/userToggleStatus")
public class UserToggleStatusServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdStr = request.getParameter("user_id");
        if (userIdStr != null && !userIdStr.isEmpty()) {
            try {
                int userId = Integer.parseInt(userIdStr);
                userService.toggleUserStatus(userId);
            } catch (NumberFormatException e) {
                e.printStackTrace(); // 可替换为日志记录
            }
        }

        response.sendRedirect(request.getContextPath() + "/userList");
    }
}
