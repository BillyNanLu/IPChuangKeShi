package com.front.servlet;

import com.front.pojo.AppointInformation;
import com.front.service.AppointInformationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/careerAppointments")
public class CareerAppointmentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final int PAGE_SIZE = 10;
    private final AppointInformationService service = new AppointInformationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) page = 1;
        } catch (Exception ignored) {}

        int totalCount = service.countByKeyword(keyword);
        int totalPage = (int) Math.ceil(totalCount * 1.0 / PAGE_SIZE);
        int offset = (page - 1) * PAGE_SIZE;

        List<AppointInformation> list = service.getByKeywordWithPage(keyword, offset, PAGE_SIZE);

        request.setAttribute("keyword", keyword);
        request.setAttribute("page", page);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("appointmentList", list);

        request.getRequestDispatcher("career_appointments.jsp").forward(request, response);
    }
}
