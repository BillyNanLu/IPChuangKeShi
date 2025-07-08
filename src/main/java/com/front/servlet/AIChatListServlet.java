package com.front.servlet;

import com.front.pojo.AIChatMessage;
import com.front.service.AiChatService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/aiChatList")
public class AIChatListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;
    private AiChatService chatService = new AiChatService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String role = request.getParameter("role");
        String pageStr = request.getParameter("page");

        int page = 1;
        try {
            if (pageStr != null) page = Integer.parseInt(pageStr);
        } catch (Exception e) {
            page = 1;
        }

        int offset = (page - 1) * PAGE_SIZE;

        List<AIChatMessage> chatList = chatService.findChats(keyword, role, offset, PAGE_SIZE);
        int totalCount = chatService.countChats(keyword, role);
        int totalPage = (int) Math.ceil(totalCount / (double) PAGE_SIZE);

        request.setAttribute("chatList", chatList);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("page", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("keyword", keyword);
        request.setAttribute("role", role);

        request.getRequestDispatcher("ai_chat_list.jsp").forward(request, response);
    }
}
