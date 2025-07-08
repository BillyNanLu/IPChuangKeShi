<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/3
  Time: 22:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IP创氪师-管理后台</title>
</head>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-gray-800">添加管理员</h1>
        <a href="adminList" class="bg-gray-300 hover:bg-gray-400 text-gray-800 px-4 py-2 rounded">← 返回</a>
    </div>

    <c:if test="${not empty msg}">
        <div class="bg-red-100 text-red-700 border border-red-400 px-4 py-2 rounded mb-4">
            <strong>错误：</strong> ${msg}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/adminAdd" method="post" enctype="multipart/form-data" class="bg-white p-6 rounded shadow space-y-6">

        <div>
            <label class="block font-medium">用户名</label>
            <input type="text" name="username" required class="w-full border rounded px-4 py-2"/>
        </div>

        <div>
            <label class="block font-medium">密码</label>
            <input type="password" name="password" required class="w-full border rounded px-4 py-2"/>
        </div>

        <div>
            <label class="block font-medium">性别</label>
            <select name="gender" class="w-full border rounded px-4 py-2">
                <option value="male">男</option>
                <option value="female">女</option>
            </select>
        </div>

        <div>
            <label class="block font-medium">手机号</label>
            <input type="text" name="phone" required class="w-full border rounded px-4 py-2"/>
        </div>

        <div>
            <label class="block font-medium">邮箱</label>
            <input type="email" name="email" required class="w-full border rounded px-4 py-2"/>
        </div>

        <div>
            <label class="block font-medium">角色</label>
            <select name="role_id" class="w-full border rounded px-4 py-2">
                <option value="1">超级管理员</option>
                <option value="2">普通管理员</option>
            </select>
        </div>

        <div>
            <label class="block font-medium">头像上传</label>
            <input type="file" name="avatar" accept="image/*" class="w-full border rounded px-4 py-2"/>
        </div>

        <div>
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded shadow">提交</button>
        </div>

    </form>
</div>

</html>