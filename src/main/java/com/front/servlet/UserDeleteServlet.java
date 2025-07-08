package com.front.servlet;

import com.front.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/userDelete")
public class UserDeleteServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("user_id");
        if (idStr != null) {
            try {
                int userId = Integer.parseInt(idStr);
                boolean success = userService.deleteUserById(userId);
                if (success) {
                    response.sendRedirect("userList");
                } else {
                    request.setAttribute("msg", "删除失败");
                    request.getRequestDispatcher("userList").forward(request, response);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("msg", "用户 ID 非法");
                request.getRequestDispatcher("userList").forward(request, response);
            }
        } else {
            request.setAttribute("msg", "缺少用户 ID");
            request.getRequestDispatcher("userList").forward(request, response);
        }
    }
}
