<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/3
  Time: 23:09
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
    <h1 class="text-2xl font-bold text-gray-800">编辑管理员</h1>
    <a href="adminList" class="bg-gray-300 hover:bg-gray-400 text-gray-800 px-4 py-2 rounded">← 返回</a>
  </div>

  <c:if test="${not empty msg}">
    <div class="bg-red-100 text-red-700 border border-red-400 px-4 py-2 rounded mb-4">
      <strong>提示：</strong> ${msg}
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/adminEdit" method="post" enctype="multipart/form-data" class="bg-white p-6 rounded shadow space-y-6">
    <input type="hidden" name="user_id" value="${admin.userId}" />

    <div>
      <label class="block font-medium">用户名</label>
      <input type="text" name="username" value="${admin.username}" required class="w-full border rounded px-4 py-2"/>
    </div>

    <div>
      <label class="block font-medium">新密码（留空不修改）</label>
      <input type="password" name="password" class="w-full border rounded px-4 py-2"/>
    </div>

    <div>
      <label class="block font-medium">性别</label>
      <select name="gender" class="w-full border rounded px-4 py-2">
        <option value="male" ${admin.gender == 'male' ? 'selected' : ''}>男</option>
        <option value="female" ${admin.gender == 'female' ? 'selected' : ''}>女</option>
      </select>
    </div>

    <div>
      <label class="block font-medium">手机号</label>
      <input type="text" name="phone" value="${admin.phone}" required class="w-full border rounded px-4 py-2"/>
    </div>

    <div>
      <label class="block font-medium">邮箱</label>
      <input type="email" name="email" value="${admin.email}" required class="w-full border rounded px-4 py-2"/>
    </div>

    <div>
      <label class="block font-medium">角色</label>
      <select name="role_id" class="w-full border rounded px-4 py-2">
        <option value="1" ${admin.role_id == 1 ? 'selected' : ''}>超级管理员</option>
        <option value="2" ${admin.role_id == 2 ? 'selected' : ''}>普通管理员</option>
      </select>
    </div>

    <div>
      <label class="block font-medium">当前头像</label><br/>
      <img src="${pageContext.request.contextPath}${admin.avatar != null ? admin.avatar : '/image/users/defaultavatars.jpg'}"
           class="h-24 w-24 rounded-full object-cover mb-2"/>
      <input type="file" name="avatar" accept="image/*" class="w-full border rounded px-4 py-2"/>
    </div>

    <div>
      <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded shadow">保存修改</button>
    </div>
  </form>
</div>

</html>