package com.front.servlet;

import com.front.pojo.User;
import com.front.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/adminList")
public class AdminListServlet extends HttpServlet {
    private final UserService usersService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<User> superAdmins;
        List<User> normalAdmins;

        if (keyword != null && !keyword.trim().isEmpty()) {
            keyword = keyword.trim();
            superAdmins = usersService.findAdminsByRoleAndKeyword(1, keyword);
            normalAdmins = usersService.findAdminsByRoleAndKeyword(2, keyword);
        } else {
            superAdmins = usersService.findByRoleId(1);
            normalAdmins = usersService.findByRoleId(2);
        }

        request.setAttribute("keyword", keyword);
        request.setAttribute("superAdmins", superAdmins);
        request.setAttribute("normalAdmins", normalAdmins);
        request.getRequestDispatcher("admin_list.jsp").forward(request, response);
    }
}
