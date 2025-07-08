<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/3
  Time: 14:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IP创氪师-管理后台</title>
</head>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-gray-800">编辑用户（user_id = ${user.userId}）</h1>
        <a href="userList" class="text-sm bg-gray-200 hover:bg-gray-300 text-gray-700 px-4 py-2 rounded">← 返回列表</a>
    </div>

    <c:if test="${not empty msg}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4 animate-fade">
            <strong class="font-bold">提示：</strong>
            <span>${msg}</span>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/userEdit" method="post" enctype="multipart/form-data" class="bg-white p-6 rounded shadow space-y-6">
        <input type="hidden" name="user_id" value="${user.userId}" />

        <!-- 用户名 -->
        <div>
            <label class="block mb-1 font-medium">用户名</label>
            <input type="text" name="username" value="${user.username}" required class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 性别 -->
        <div>
            <label class="block mb-1 font-medium">性别</label>
            <select name="gender" class="w-full border rounded px-4 py-2">
                <option value="male" ${user.gender == 'male' ? 'selected' : ''}>男</option>
                <option value="female" ${user.gender == 'female' ? 'selected' : ''}>女</option>
            </select>
        </div>

        <!-- 手机号 -->
        <div>
            <label class="block mb-1 font-medium">手机号</label>
            <input type="text" name="phone" value="${user.phone}" required class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 密码 -->
        <div>
            <label class="block mb-1 font-medium">新密码（留空则不变）</label>
            <input type="password" name="password" class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 邮箱 -->
        <div>
            <label class="block mb-1 font-medium">邮箱</label>
            <input type="email" name="email" value="${user.email}" required class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 头像 -->
        <div>
            <label class="block mb-1 font-medium">当前头像</label><br/>
            <img src="${pageContext.request.contextPath}${user.avatar != null ? user.avatar : '/image/users/defaultavatars.jpg'}"
                 class="h-24 w-24 rounded-full object-cover mb-2 border" id="avatarPreview"/>
            <input type="file" name="avatar" accept="image/*" class="w-full border rounded px-4 py-2" onchange="previewAvatar(event)"/>
        </div>

        <!-- 角色 -->
        <div>
            <label class="block mb-1 font-medium">角色</label>
            <select name="role_id" class="w-full border rounded px-4 py-2">
                <option value="3" ${user.roleId == 3 ? 'selected' : ''}>学生</option>
                <option value="4" ${user.roleId == 4 ? 'selected' : ''}>职场</option>
            </select>
        </div>

        <!-- 提交 -->
        <div class="pt-4">
            <button type="submit"
                    class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded shadow">
                保存修改
            </button>
            <a href="userList" class="ml-4 text-gray-600 hover:underline">取消</a>
        </div>
    </form>

</div>

<!-- avatar 预览逻辑 -->
<script>
    function previewAvatar(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = e => {
                document.getElementById('avatarPreview').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }
</script>

<!-- 动画样式 -->
<style>
    .animate-fade {
        animation: fadeIn 0.6s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

</html>