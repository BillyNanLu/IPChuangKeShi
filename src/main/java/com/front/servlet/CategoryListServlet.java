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

@WebServlet("/categoryList")
public class CategoryListServlet extends HttpServlet {
    private final CourseCategoryService categoryService = new CourseCategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<CourseCategory> topCategories = categoryService.getNestedCategoryList();

        request.setAttribute("topCategories", topCategories);
        request.getRequestDispatcher("category_list.jsp").forward(request, response);
    }
}
