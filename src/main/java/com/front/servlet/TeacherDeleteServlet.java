package com.front.servlet;

import com.front.service.TeacherService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/teacherDelete")
public class TeacherDeleteServlet extends HttpServlet {
    private final TeacherService teacherService = new TeacherService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                boolean success = teacherService.deleteTeacherById(id);
                if (success) {
                    response.sendRedirect("teacherList");
                } else {
                    request.setAttribute("msg", "删除失败");
                    request.getRequestDispatcher("teacherList").forward(request, response);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("msg", "ID格式错误");
                request.getRequestDispatcher("teacherList").forward(request, response);
            }
        } else {
            response.sendRedirect("teacherList");
        }
    }
}
