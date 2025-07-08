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

@WebServlet("/adminAdd")
@MultipartConfig
public class AdminAddServlet extends HttpServlet {
    private final UserService usersService = new UserService();

    public AdminAddServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("adminAdd.jsp").forward(req, resp);
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String roleStr = request.getParameter("role_id");

        if (username == null || password == null || phone == null || email == null || roleStr == null) {
            request.setAttribute("msg", "所有字段必须填写！");
            request.getRequestDispatcher("adminAdd.jsp").forward(request, response);
            return;
        }

        int roleId = Integer.parseInt(roleStr);

        // 加密密码
        String md5Password = MD5Util.getMD5Str(password);

        // 头像处理
        Part avatarPart = request.getPart("avatar");
        String avatarPath = null;
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/uploads/avatars");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String fileName = UUID.randomUUID() + getFileExtension(avatarPart.getSubmittedFileName());
            avatarPart.write(uploadDir + File.separator + fileName);
            avatarPath = "/uploads/avatars/" + fileName;
        }

        // 封装Bean
        User user = new User();
        user.setUsername(username);
        user.setPassword(md5Password);
        user.setGender(gender);
        user.setPhone(phone);
        user.setEmail(email);
        user.setAvatar(avatarPath);
        user.setRoleId(roleId);

        boolean success = usersService.insertUser(user);  // 直接调用Dao

        if (success) {
            response.sendRedirect("adminList");
        } else {
            request.setAttribute("msg", "添加失败，请检查是否有重复的用户名或手机号！");
            request.getRequestDispatcher("adminAdd.jsp").forward(request, response);
        }
    }

    private String getFileExtension(String fileName) {
        return fileName.lastIndexOf(".") != -1 ? fileName.substring(fileName.lastIndexOf(".")) : "";
    }
}
