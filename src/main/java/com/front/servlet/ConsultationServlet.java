package com.front.servlet;

import com.front.pojo.AppointConsult;
import com.front.service.AppointConsultService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/consultationList")
public class ConsultationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AppointConsultService service = new AppointConsultService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");

        int page = 1;
        int pageSize = 10;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page <= 0) page = 1;
        } catch (Exception ignored) {}

        int totalCount = service.count(keyword);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        List<AppointConsult> consultList = service.getByPage(keyword, page, pageSize);

        request.setAttribute("consultList", consultList);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("consultation_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                service.deleteById(id);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/consultationList");
    }
}
