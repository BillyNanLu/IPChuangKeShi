package com.front.servlet;

import com.front.pojo.CourseCategory;
import com.front.service.CourseCategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/categoryAdd")
public class CategoryAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CourseCategoryService service = new CourseCategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int parent_id = 0;
        try {
            parent_id = Integer.parseInt(request.getParameter("parent_id"));
        } catch (Exception ignored) {}

        List<String> typeList = service.getAllTypes();
        CourseCategory parent = parent_id > 0 ? service.findById(parent_id) : null;

        request.setAttribute("typeList", typeList);
        request.setAttribute("parent_id", parent_id);
        request.setAttribute("parent", parent);
        request.getRequestDispatcher("category_add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int parent_id = Integer.parseInt(request.getParameter("parent_id"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");

        boolean success = service.insertCategory(parent_id, name, type);
        request.getSession().setAttribute("msg", success ? "添加成功" : "添加失败");
        response.sendRedirect("categoryList");
    }
}
