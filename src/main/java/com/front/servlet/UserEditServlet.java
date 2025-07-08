package com.front.servlet;

import com.front.pojo.User;
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

@WebServlet("/userEdit")
@MultipartConfig
public class UserEditServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = userService.getUserById(userId);

        if (user == null) {
            request.setAttribute("msg", "未找到用户信息");
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("user_edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int userId = Integer.parseInt(request.getParameter("user_id"));
        String username = request.getParameter("username");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        int roleId = Integer.parseInt(request.getParameter("role_id"));

        // 原始用户
        User originalUser = userService.getUserById(userId);

        // 密码加密（留空则不改）
        String encryptedPassword = password != null && !password.trim().isEmpty()
                ? MD5Util.getMD5Str(password)
                : originalUser.getPassword();

        // 头像处理
        Part avatarPart = request.getPart("avatar");
        String avatarPath = originalUser.getAvatar();
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/uploads/avatars");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String fileName = UUID.randomUUID() + getFileExtension(avatarPart.getSubmittedFileName());
            avatarPart.write(uploadDir + File.separator + fileName);
            avatarPath = "/uploads/avatars/" + fileName;
        }

        User user = new User();
        user.setUserId(userId);
        user.setUsername(username);
        user.setGender(gender);
        user.setPhone(phone);
        user.setEmail(email);
        user.setAvatar(avatarPath);
        user.setRoleId(roleId);
        user.setPassword(encryptedPassword);

        boolean updated = userService.updateUser(user);

        if (updated) {
            response.sendRedirect("userList");
        } else {
            request.setAttribute("msg", "更新失败");
            request.setAttribute("user", user);
            request.getRequestDispatcher("user_edit.jsp").forward(request, response);
        }
    }

    private String getFileExtension(String fileName) {
        return fileName.lastIndexOf(".") != -1 ? fileName.substring(fileName.lastIndexOf(".")) : "";
    }
}
