package com.front.servlet;

import com.front.pojo.User;
import com.front.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/userList")
public class UserListServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        int page = 1;
        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception ignored) {}

        int offset = (page - 1) * PAGE_SIZE;

        // 改用 service
        List<User> userList = userService.searchUsers(keyword, offset, PAGE_SIZE);
        int totalCount = userService.countUsers(keyword);
        int totalPage = (int) Math.ceil(totalCount / (double) PAGE_SIZE);

        req.setAttribute("userList", userList);
        req.setAttribute("keyword", keyword);
        req.setAttribute("page", page);
        req.setAttribute("totalPage", totalPage);
        req.setAttribute("totalCount", totalCount);

        req.getRequestDispatcher("user_list.jsp").forward(req, resp);
    }

}
