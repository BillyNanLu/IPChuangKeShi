<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/3
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
    <h1 class="text-2xl font-bold mb-6">添加用户</h1>

    <form action="${pageContext.request.contextPath}/userAdd" method="post" enctype="multipart/form-data" class="bg-white p-6 rounded shadow space-y-6">

        <!-- 用户名 -->
        <div>
            <label class="block mb-1 font-medium">用户名</label>
            <input type="text" name="username" required class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 性别 -->
        <div>
            <label class="block mb-1 font-medium">性别</label>
            <select name="gender" class="w-full border rounded px-4 py-2">
                <option value="male">男</option>
                <option value="female">女</option>
            </select>
        </div>

        <!-- 手机号 -->
        <div>
            <label class="block mb-1 font-medium">手机号</label>
            <input type="text" name="phone" required class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 密码 -->
        <div>
            <label class="block mb-1 font-medium">密码</label>
            <input type="password" name="password" required class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 邮箱 -->
        <div>
            <label class="block mb-1 font-medium">邮箱</label>
            <input type="email" name="email" required class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 头像 -->
        <div>
            <label class="block mb-1 font-medium">头像</label>
            <input type="file" name="avatar" accept="image/*" class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 角色 -->
        <div>
            <label class="block mb-1 font-medium">角色</label>
            <select name="role_id" class="w-full border rounded px-4 py-2">
                <option value="3">学生</option>
                <option value="4">职场</option>
            </select>
        </div>

        <div class="pt-4">
            <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded shadow">
                添加用户
            </button>
            <a href="userList" class="ml-4 text-gray-600 hover:underline">取消</a>
        </div>
    </form>
</div>

