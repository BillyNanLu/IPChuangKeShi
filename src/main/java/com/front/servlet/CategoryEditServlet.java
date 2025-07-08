package com.front.servlet;

import com.front.pojo.CourseCategory;
import com.front.service.CourseCategoryService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class CategoryEditServlet extends HttpServlet {
    private final CourseCategoryService service = new CourseCategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            CourseCategory category = service.findById(id);
            List<String> typeList = service.getAllTypes();

            if (category != null) {
                req.setAttribute("category", category);
                req.setAttribute("typeList", typeList);
                req.getRequestDispatcher("category_edit.jsp").forward(req, resp);
                return;
            }
        }
        resp.sendRedirect("categoryList");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        int parent_id = Integer.parseInt(req.getParameter("parent_id"));
        String name = req.getParameter("name");
        String type = req.getParameter("type");

        // 1. 重名校验（排除当前分类）
        if (service.isNameDuplicate(name, parent_id, id)) {
            req.setAttribute("msg", "分类名已存在，请更换");

            CourseCategory category = new CourseCategory();
            category.setId(id);
            category.setParentId(parent_id);
            category.setName(name);
            category.setType(type);
            req.setAttribute("category", category);

            List<String> typeList = service.getAllTypes();
            req.setAttribute("typeList", typeList);

            if (parent_id > 0) {
                CourseCategory parent = service.findById(parent_id);
                req.setAttribute("parent", parent);
            }

            req.getRequestDispatcher("category_edit.jsp").forward(req, resp);
            return;
        }

        // 2. 执行更新
        boolean success = service.updateCategory(id, name, type);
        req.getSession().setAttribute("msg", success ? "分类更新成功" : "分类更新失败");
        resp.sendRedirect("categoryList");
    }

}
