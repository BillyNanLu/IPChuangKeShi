package com.front.servlet;

import com.front.pojo.Teacher;
import com.front.service.TeacherService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/teacherEdit")
@MultipartConfig
public class TeacherEditServlet extends HttpServlet {
    private final TeacherService teacherService = new TeacherService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Teacher teacher = teacherService.getTeacherById(id);
        request.setAttribute("teacher", teacher);
        request.getRequestDispatcher("teacher_edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String title = request.getParameter("title");
        String department = request.getParameter("department");
        String expertise = request.getParameter("expertise");
        String profile = request.getParameter("profile");

        // 原始数据（头像保留逻辑）
        Teacher original = teacherService.getTeacherById(id);
        String imgagePath = original.getImgage();

        Part imgPart = request.getPart("imgage");
        if (imgPart != null && imgPart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/uploads/teachers");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String fileName = UUID.randomUUID() + getFileExtension(imgPart.getSubmittedFileName());
            imgPart.write(uploadDir + File.separator + fileName);
            imgagePath = "/uploads/teachers/" + fileName;
        }

        Teacher teacher = new Teacher();
        teacher.setId(id);
        teacher.setName(name);
        teacher.setTitle(title);
        teacher.setDepartment(department);
        teacher.setExpertise(expertise);
        teacher.setProfile(profile);
        teacher.setImgage(imgagePath);

        boolean success = teacherService.updateTeacher(teacher);

        if (success) {
            response.sendRedirect("teacherList");
        } else {
            request.setAttribute("msg", "教师信息更新失败");
            request.setAttribute("teacher", teacher);
            request.getRequestDispatcher("teacher_edit.jsp").forward(request, response);
        }
    }

    private String getFileExtension(String fileName) {
        return fileName != null && fileName.contains(".") ?
                fileName.substring(fileName.lastIndexOf(".")) : "";
    }

}
