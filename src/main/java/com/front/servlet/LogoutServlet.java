package com.front.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 清除 session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // 获取 Referer 头，即上一个页面的地址
        String referer = request.getHeader("Referer");

        // 重定向回原页面
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            // 如果没有 Referer，默认回首页
            response.sendRedirect("home");
        }
    }
}

