package com.front.servlet;

import com.front.service.UserService;
import com.front.pojo.User;
import com.front.utils.MD5Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    public LoginServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String redirect = request.getParameter("redirect");

        MD5Util md5Util = new MD5Util();
        password = md5Util.getMD5Str(password);
        System.out.println(password);

        User user = userService.findByPhoneAndPassword(phone, password);

        if (user != null) {
            LocalDateTime now = LocalDateTime.now();
            userService.updateLoginTime(user.getUserId(), now);

            request.getSession().setAttribute("loginUser", user);
            request.getSession().setAttribute("user_id", user.getUserId());

            // 登录成功后优先跳转 redirectAfterLogin（如从 enroll 跳转而来）
            String redirectAfterLogin = (String) request.getSession().getAttribute("redirectAfterLogin");
            if (redirectAfterLogin != null) {
                request.getSession().removeAttribute("redirectAfterLogin");
                response.sendRedirect(redirectAfterLogin);
                return;
            }

            // 判断是否存在回跳参数，优先回跳
            if ("chat".equals(redirect)) {
                response.sendRedirect("chat");
                return;
            }

            // 否则按角色跳转
            if (user.getRoleId() == 1 || user.getRoleId() == 2) {
                response.sendRedirect("adminDashboard");
            } else {
                response.sendRedirect("home");
            }
        } else {
            // 登录失败，返回登录页，附带错误信息
            request.setAttribute("error", "手机号或密码错误");
            // 把 redirect 参数传回去，保证登录页表单隐藏域能保留
            request.setAttribute("redirect", redirect);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        doGet(request, response);
    }


}
