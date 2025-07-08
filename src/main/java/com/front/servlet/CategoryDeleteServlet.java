package com.front.servlet;

import com.front.service.CourseCategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/categoryDelete")
public class CategoryDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CourseCategoryService service = new CourseCategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        if (service.hasCourses(id)) {
            req.getSession().setAttribute("msg", "该分类下存在课程，无法删除");
        } else {
            boolean success = service.deleteById(id);
            req.getSession().setAttribute("msg", success ? "分类已删除" : "删除失败");
        }

        resp.sendRedirect("categoryList");
    }
}
