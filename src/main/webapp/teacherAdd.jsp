<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/3
  Time: 20:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-gray-800">添加教师</h1>
        <a href="teacherList" class="text-sm bg-gray-200 hover:bg-gray-300 text-gray-700 px-4 py-2 rounded">← 返回列表</a>
    </div>

    <c:if test="${not empty msg}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            <strong class="font-bold">提示：</strong> ${msg}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/teacherAdd" method="post" enctype="multipart/form-data"
          class="bg-white p-6 rounded shadow space-y-6">

        <!-- 姓名 -->
        <div>
            <label class="block mb-1 font-medium">姓名</label>
            <input type="text" name="name" required class="w-full border rounded px-4 py-2" />
        </div>

        <!-- 职称 -->
        <div>
            <label class="block mb-1 font-medium">职称</label>
            <input type="text" name="title" class="w-full border rounded px-4 py-2" />
        </div>

        <!-- 所属部门 -->
        <div>
            <label class="block mb-1 font-medium">所属部门</label>
            <input type="text" name="department" class="w-full border rounded px-4 py-2" />
        </div>

        <!-- 专业领域 -->
        <div>
            <label class="block mb-1 font-medium">专业领域</label>
            <textarea name="expertise" rows="3" class="w-full border rounded px-4 py-2"></textarea>
        </div>

        <!-- 个人简介 -->
        <div>
            <label class="block mb-1 font-medium">个人简介</label>
            <textarea name="profile" rows="5" class="w-full border rounded px-4 py-2"></textarea>
        </div>

        <!-- 头像上传 -->
        <div>
            <label class="block mb-1 font-medium">头像</label>
            <input type="file" name="imgage" accept="image/*" class="w-full border rounded px-4 py-2" />
        </div>

        <!-- 提交 -->
        <div class="pt-4">
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded shadow">
                添加教师
            </button>
            <a href="teacherList" class="ml-4 text-gray-600 hover:underline">取消</a>
        </div>
    </form>
</div>

