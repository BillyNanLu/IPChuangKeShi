package com.front.servlet;

import com.front.pojo.AppointInformation;
import com.front.service.AppointInformationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/appoint") // 保持与JSP表单提交路径一致
public class AppointInformationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AppointInformationService appointService = new AppointInformationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 转发到咨询页面
        request.getRequestDispatcher("/consult.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 封装表单数据到pojo
        AppointInformation appointInfo = new AppointInformation();
        appointInfo.setName(request.getParameter("name"));
        appointInfo.setPhone(request.getParameter("phone"));
        appointInfo.setTime(request.getParameter("time"));
        appointInfo.setCity(request.getParameter("city"));
        appointInfo.setIndustry(request.getParameter("industry"));
        appointInfo.setExperience(request.getParameter("experience"));
        appointInfo.setPaidConsult(request.getParameter("paid"));
        appointInfo.setDescription(request.getParameter("description"));
        appointInfo.setCreatedAt(LocalDateTime.now());

        // 调用Service处理业务
        boolean success;
        try {
            success = appointService.addAppointInformation(appointInfo);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "预约失败，请稍后重试");
            request.getRequestDispatcher("/consult.jsp").forward(request, response);
            return;
        }

        // 重定向防止表单重复提交
        if (success) {
            response.sendRedirect("consult.jsp?appointSuccess=true");
        } else {
            request.setAttribute("error", "预约失败，请检查信息");
            request.getRequestDispatcher("/consult.jsp").forward(request, response);
        }
    }
}