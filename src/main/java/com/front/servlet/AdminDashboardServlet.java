package com.front.servlet;

import com.front.pojo.User;
import com.front.service.AdminDashboardService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDashboardService dashboardService = new AdminDashboardService();

    public AdminDashboardServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loginUser = (User) request.getSession().getAttribute("loginUser");

        if (loginUser == null || (loginUser.getRoleId() != 1 && loginUser.getRoleId() != 2)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 使用 Service 获取数据
        int totalUsers = dashboardService.getTotalUsers();
        int totalAdmins = dashboardService.getTotalAdmins();
        int activeUsers = dashboardService.getActiveUsers();
        int todayLogins = dashboardService.getTodayLogins();
        List<Map<String, String>> recentAdmins = dashboardService.getRecentAdmins();
        List<Map<String, String>> recentUsers = dashboardService.getRecentUsers();

        request.setAttribute("loginUser", loginUser);
        request.setAttribute("totalAdmins", totalAdmins);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("todayLogins", todayLogins);
        request.setAttribute("recentAdmins", recentAdmins);
        request.setAttribute("recentUsers", recentUsers);

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
}
