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

@WebServlet("/adminEdit")
@MultipartConfig
public class AdminEditServlet extends HttpServlet {
    private final UserService usersService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        System.out.println(idStr);

        // 校验参数是否为空或非法
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("adminList"); // 没有 id 参数，直接返回管理员列表
            return;
        }

        try {
            int userId = Integer.parseInt(idStr);
            User admin = usersService.getUserById(userId);

            if (admin == null) {
                request.setAttribute("msg", "未找到对应管理员信息！");
                request.getRequestDispatcher("adminList").forward(request, response);
                return;
            }

            request.setAttribute("admin", admin);
            request.getRequestDispatcher("adminEdit.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("adminList"); // 非法 id 也跳回列表
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int userId = Integer.parseInt(request.getParameter("user_id"));
        String username = request.getParameter("username");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int roleId = Integer.parseInt(request.getParameter("role_id"));

        User old = usersService.getUserById(userId);

        // 处理密码
        String encryptedPassword = old.getPassword();
        if (password != null && !password.trim().isEmpty()) {
            encryptedPassword = MD5Util.getMD5Str(password);
        }

        // 处理头像上传
        Part avatarPart = request.getPart("avatar");
        String avatarPath = old.getAvatar();
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/uploads/avatars");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String fileName = UUID.randomUUID() + getFileExtension(avatarPart.getSubmittedFileName());
            avatarPart.write(uploadDir + File.separator + fileName);
            avatarPath = "/uploads/avatars/" + fileName;
        }

        User admin = new User();
        admin.setUserId(userId);
        admin.setUsername(username);
        admin.setGender(gender);
        admin.setPhone(phone);
        admin.setEmail(email);
        admin.setPassword(encryptedPassword);
        admin.setAvatar(avatarPath);
        admin.setRoleId(roleId);

        boolean success = usersService.updateUser(admin);

        if (success) {
            response.sendRedirect("adminList");
        } else {
            request.setAttribute("msg", "修改失败！");
            request.setAttribute("admin", admin);
            request.getRequestDispatcher("adminEdit.jsp").forward(request, response);
        }
    }

    private String getFileExtension(String fileName) {
        return fileName.lastIndexOf(".") != -1 ? fileName.substring(fileName.lastIndexOf(".")) : "";
    }

}
