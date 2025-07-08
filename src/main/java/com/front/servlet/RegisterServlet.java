package com.front.servlet;

import com.front.service.UserService;
import com.front.utils.MD5Util;

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

@WebServlet("/register")

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,  // 1MB
        maxFileSize = 1024 * 1024 * 5,    // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    UserService usersService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String username = request.getParameter("username");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String identity = request.getParameter("identity");

        // MD5加密
        MD5Util md5 = new MD5Util();
        password = md5.getMD5Str(password);

        // 处理类别
        int role_id;
        if ("professional".equals(identity)) {
            role_id = 4;
        } else if ("student".equals(identity)) {
            role_id = 3;
        } else {
            // 处理非法值（比如默认值或错误提示）
            role_id = 4; // 或者其他默认处理方式
        }

        // 处理头像上传
        Part avatarPart = request.getPart("avatar");
        String avatarPath = null;
        if (avatarPart != null && avatarPart.getSize() > 0) {
            // 获取上传目录的真实路径
            String uploadDir = getServletContext().getRealPath("/uploads/avatars");
            File uploadPath = new File(uploadDir);

            // 如果目录不存在则创建
            if (!uploadPath.exists()) {
                uploadPath.mkdirs();
            }

            // 生成唯一文件名
            String fileName = UUID.randomUUID().toString() + getFileExtension(avatarPart.getSubmittedFileName());

            // 保存文件
            avatarPath = "/uploads/avatars/" + fileName;
            avatarPart.write(uploadDir + File.separator + fileName);
        }


        boolean success = false;

        try {
            success = usersService.addUser(username, password, gender, phone, email, avatarPath, role_id);
        } catch (Exception e) {
            System.err.println("注册用户失败: " + e.getMessage());
            request.setAttribute("error", "注册失败，请稍后再试");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            // 注册失败，可能是用户名已存在
            request.setAttribute("error", "注册失败，用户名或手机号可能已被使用");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    // 获取文件扩展名
    private String getFileExtension(String fileName) {
        if (fileName == null || fileName.lastIndexOf(".") == -1) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf("."));
    }
}
