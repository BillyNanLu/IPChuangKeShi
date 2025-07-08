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

@WebServlet("/teacherAdd")
@MultipartConfig
public class teacherAdd extends HttpServlet {
    private final TeacherService teacherService = new TeacherService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String title = request.getParameter("title");
        String department = request.getParameter("department");
        String expertise = request.getParameter("expertise");
        String profile = request.getParameter("profile");

        // 处理头像上传
        Part imagePart = request.getPart("imgage");
        String imagePath = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/uploads/teachers");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String fileName = UUID.randomUUID().toString() + getFileExtension(imagePart.getSubmittedFileName());
            imagePart.write(uploadDir + File.separator + fileName);
            imagePath = "/uploads/teachers/" + fileName;
        }

        // 构造对象
        Teacher teacher = new Teacher();
        teacher.setName(name);
        teacher.setTitle(title);
        teacher.setDepartment(department);
        teacher.setExpertise(expertise);
        teacher.setProfile(profile);
        teacher.setImgage(imagePath);

        boolean success = teacherService.addTeacher(teacher);

        if (success) {
            response.sendRedirect("teacherList");
        } else {
            request.setAttribute("msg", "教师添加失败，请检查信息是否完整或有重复！");
            request.getRequestDispatcher("teacherAdd.jsp").forward(request, response);
        }
    }

    private String getFileExtension(String fileName) {
        return (fileName != null && fileName.contains(".")) ?
                fileName.substring(fileName.lastIndexOf(".")) : "";
    }

}
