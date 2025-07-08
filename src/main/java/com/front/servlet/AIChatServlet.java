package com.front.servlet;

import com.front.mapper.AIChatMessageMapper;
import com.front.pojo.AIChatMessage;
import com.front.service.AIChatMessageService;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet("/chat")
public class AIChatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DOUBAO_API_URL = "https://ark.cn-beijing.volces.com/api/v3/chat/completions";
    private static final String DOUBAO_API_TOKEN = "93e2af81-9a21-435c-8950-a022b0ca8068";

    private final AIChatMessageService chatService = new AIChatMessageService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("user_id");
        if (userId == null) {
            resp.sendRedirect("login.jsp?redirect=chat");
            return;
        }

        List<AIChatMessage> history = chatService.getMessagesByUserId(userId);
        req.setAttribute("history", history);
        req.getRequestDispatcher("aichat.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Integer userId = (Integer) req.getSession().getAttribute("user_id");
        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String userInput = req.getParameter("message");

        // 保存用户消息
        AIChatMessage userMsg = new AIChatMessage();
        userMsg.setUserId(userId);
        userMsg.setRole("user");
        userMsg.setMessage(userInput);
        chatService.insertMessage(userMsg);

        // 调用豆包 AI 获取回复
        String aiReply = callDoubaoAI(userInput, userId);

        // 保存 AI 回复
        AIChatMessage aiMsg = new AIChatMessage();
        aiMsg.setUserId(userId);
        aiMsg.setRole("assistant");
        aiMsg.setMessage(aiReply);
        chatService.insertMessage(aiMsg);

        resp.sendRedirect("chat");

    }

    private String callDoubaoAI(String userInput, Integer userId) {
        try {
            URL url = new URL(DOUBAO_API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + DOUBAO_API_TOKEN);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // 获取最近记录
            AIChatMessageService chatService = new AIChatMessageService();
            List<AIChatMessage> history = chatService.getRecentMessages(userId, 5);

            // 构建 messages JSON
            JSONArray messagesArray = new JSONArray();
            for (AIChatMessage msg : history) {
                JSONObject msgObj = new JSONObject();
                msgObj.put("role", msg.getRole());
                msgObj.put("content", msg.getMessage());
                messagesArray.put(msgObj);
            }

            // 添加当前用户输入
            JSONObject userMessage = new JSONObject();
            userMessage.put("role", "user");
            userMessage.put("content", userInput);
            messagesArray.put(userMessage);

            // 构造 payload
            JSONObject payload = new JSONObject();
            payload.put("model", "doubao-seed-1-6-250615");
            payload.put("messages", messagesArray);
            payload.put("temperature", 0.7);
            payload.put("max_tokens", 2048);

            // 发送请求
            try (OutputStream os = conn.getOutputStream()) {
                os.write(payload.toString().getBytes(StandardCharsets.UTF_8));
            }

            int code = conn.getResponseCode();
            InputStream input = code == 200 ? conn.getInputStream() : conn.getErrorStream();

            try (BufferedReader reader = new BufferedReader(new InputStreamReader(input, StandardCharsets.UTF_8))) {
                StringBuilder res = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    res.append(line);
                }

                if (code != 200) {
                    return "豆包API错误：" + res;
                }

                JSONObject resultJson = new JSONObject(res.toString());
                JSONArray choices = resultJson.getJSONArray("choices");
                if (!choices.isEmpty()) {
                    return choices.getJSONObject(0).getJSONObject("message").getString("content");
                } else {
                    return "AI 没有返回内容";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "调用豆包失败：" + e.getMessage();
        }
    }
}
