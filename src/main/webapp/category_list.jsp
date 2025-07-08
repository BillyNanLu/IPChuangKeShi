<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/1
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>IP创氪师-管理后台</title>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
  <h1 class="text-2xl font-bold mb-6">课程分类管理</h1>

  <c:if test="${not empty sessionScope.msg}">
    <div class="bg-green-100 text-green-800 px-4 py-2 mb-4 rounded">${sessionScope.msg}</div>
    <c:remove var="msg" scope="session"/>
  </c:if>

  <div class="bg-white rounded shadow p-6">
    <ul class="space-y-4">
      <a href="categoryAdd?parent_id=0" style="float: right" class="inline-flex items-center px-3 py-1.5 bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-medium rounded-md shadow-md hover:shadow-lg transition-all duration-300 transform hover:-translate-y-0.25 focus:outline-none focus:ring-2 focus:ring-blue-300 focus:ring-opacity-50">
        <i class="fa fa-plus-circle text-sm mr-1.5"></i> 添加顶级分类
      </a>
      <c:forEach var="top" items="${topCategories}">
        <li>
          <div class="font-bold text-lg text-gray-800">${top.name}</div>

          <c:if test="${not empty top.children}">
            <ul class="ml-6 space-y-3 border-l border-gray-300 pl-4">
              <c:forEach var="second" items="${top.children}">
                <li>
                  <div class="flex justify-between items-center">
                    <span class="text-blue-700 font-medium">${second.name}</span>
                    <div class="space-x-2 text-sm">
                      <a href="categoryAdd?parent_id=${second.id}" class="text-blue-600 hover:underline">添加子类</a>
                      <a href="categoryEdit?id=${second.id}" class="text-green-600 hover:underline">编辑</a>
                      <a href="categoryDelete?id=${second.id}" class="text-red-600 hover:underline"
                         onclick="return confirm('确定删除该分类吗？');">删除</a>
                    </div>
                  </div>

                  <c:if test="${not empty second.children}">
                    <ul class="ml-6 mt-2 space-y-1 border-l border-gray-200 pl-3">
                      <c:forEach var="third" items="${second.children}">
                        <li class="flex justify-between items-center">
                          <span>${third.name}</span>
                          <div class="space-x-2 text-sm">
                            <a href="categoryEdit?id=${third.id}" class="text-green-600 hover:underline">编辑</a>
                            <a href="categoryDelete?id=${third.id}" class="text-red-600 hover:underline"
                               onclick="return confirm('确定删除该分类吗？');">删除</a>
                          </div>
                        </li>
                      </c:forEach>
                    </ul>
                  </c:if>
                </li>
              </c:forEach>
            </ul>
          </c:if>
        </li>
      </c:forEach>
    </ul>
  </div>
</div>

