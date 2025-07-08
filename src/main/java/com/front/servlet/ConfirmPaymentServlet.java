package com.front.servlet;

import com.front.service.CourseOrderService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/confirmPayment")
public class ConfirmPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");

        String orderNo = request.getParameter("orderNo");
        String method = request.getParameter("method");

        if (orderNo != null && method != null) {
            CourseOrderService service = new CourseOrderService();
            service.confirmPayment(orderNo, method);
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "参数缺失");
        }
    }
}
