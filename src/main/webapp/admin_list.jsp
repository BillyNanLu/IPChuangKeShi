<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/3
  Time: 22:20
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
    <h1 class="text-2xl font-bold text-gray-800">管理员管理</h1>
    <a href="adminAdd.jsp" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded shadow">+ 添加管理员</a>
  </div>

  <!-- 搜索框 -->
  <form method="get" action="adminList" class="mb-6 flex space-x-2">
    <input type="text" name="keyword" value="${param.keyword}" placeholder="搜索用户名 / 电话 / 邮箱"
           class="w-64 px-4 py-2 border rounded"/>
    <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">搜索</button>
  </form>

  <c:if test="${not empty msg}">
    <div id="alertModal" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center z-50">
      <div class="bg-white rounded shadow-lg max-w-sm w-full p-6 text-center animate-fade">
        <h2 class="text-lg font-bold mb-2 text-red-600">操作失败</h2>
        <p class="text-gray-700 mb-4">${msg}</p>
        <button onclick="closeAlertModal()" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">确定</button>
      </div>
    </div>
  </c:if>

  <!-- 超级管理员 -->
  <div class="mb-10">
    <h2 class="text-lg font-semibold text-gray-700 mb-3">超级管理员</h2>
    <table class="w-full text-sm text-left bg-white shadow rounded overflow-hidden">
      <thead class="bg-gray-100 text-gray-600">
      <tr>
        <th class="p-3">编号</th>
        <th class="p-3">头像</th>
        <th class="p-3">用户名</th>
        <th class="p-3">性别</th>
        <th class="p-3">电话</th>
        <th class="p-3">邮箱</th>
        <th class="p-3">权限</th>
        <th class="p-3">操作</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="admin" items="${superAdmins}" varStatus="s">
        <tr class="border-b hover:bg-gray-50">
          <td class="p-3">${s.index + 1}</td>
          <td class="p-3">
            <img src="${pageContext.request.contextPath}${admin.avatar != null ? admin.avatar : '/image/users/defaultavatars.jpg'}"
                 class="w-10 h-10 rounded-full object-cover"/>
          </td>
          <td class="p-3">${admin.username}</td>
          <td class="p-3">${admin.gender == 'male' ? '男' : '女'}</td>
          <td class="p-3">${admin.phone}</td>
          <td class="p-3">${admin.email}</td>
          <td class="p-3 text-red-600 font-semibold">超级</td>
          <td class="p-3 space-x-2">
            <button type="button"
                    class="text-blue-600 hover:underline"
                    onclick="showAdminModal(
                            '${admin.username}',
                            '${admin.gender}',
                            '${admin.phone}',
                            '${admin.email}',
                            '${admin.roleId}',
                            '${admin.status}',
                            '${admin.createdAt}',
                            '${admin.updatedAt}',
                            '${admin.lastLogin}',
                            '${admin.avatar != null ? admin.avatar : "/image/users/defaultavatars.jpg"}'
                            )">查看</button>
            <a href="adminEdit?id=${admin.userId}" class="text-blue-600 hover:underline">编辑</a>
            <form action="adminDelete" method="post" style="display:inline;" onsubmit="return confirm('确定删除该管理员？');">
              <input type="hidden" name="user_id" value="${admin.userId}" />
              <button type="submit" class="text-red-600 hover:underline">删除</button>
            </form>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

  <!-- 普通管理员 -->
  <div>
    <h2 class="text-lg font-semibold text-gray-700 mb-3">普通管理员</h2>
    <table class="w-full text-sm text-left bg-white shadow rounded overflow-hidden">
      <thead class="bg-gray-100 text-gray-600">
      <tr>
        <th class="p-3">编号</th>
        <th class="p-3">头像</th>
        <th class="p-3">用户名</th>
        <th class="p-3">性别</th>
        <th class="p-3">电话</th>
        <th class="p-3">邮箱</th>
        <th class="p-3">权限</th>
        <th class="p-3">操作</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="admin" items="${normalAdmins}" varStatus="s">
        <tr class="border-b hover:bg-gray-50">
          <td class="p-3">${s.index + 1}</td>
          <td class="p-3">
            <img src="${pageContext.request.contextPath}${admin.avatar != null ? admin.avatar : '/image/users/defaultavatars.jpg'}"
                 class="w-10 h-10 rounded-full object-cover"/>
          </td>
          <td class="p-3">${admin.username}</td>
          <td class="p-3">${admin.gender == 'male' ? '男' : '女'}</td>
          <td class="p-3">${admin.phone}</td>
          <td class="p-3">${admin.email}</td>
          <td class="p-3 text-gray-700 font-semibold">普通</td>
          <td class="p-3 space-x-2">
            <button type="button"
                    class="text-blue-600 hover:underline"
                    onclick="showAdminModal(
                            '${admin.username}',
                            '${admin.gender}',
                            '${admin.phone}',
                            '${admin.email}',
                            '${admin.roleId}',
                            '${admin.status}',
                            '${admin.createdAt}',
                            '${admin.updatedAt}',
                            '${admin.lastLogin}',
                            '${admin.avatar != null ? admin.avatar : "/image/users/defaultavatars.jpg"}'
                            )">查看</button>
            <a href="adminEdit?id=${admin.userId}" class="text-blue-600 hover:underline">编辑</a>
            <form action="adminDelete" method="post" style="display:inline;" onsubmit="return confirm('确定删除该管理员？');">
              <input type="hidden" name="user_id" value="${admin.userId}" />
              <button type="submit" class="text-red-600 hover:underline">删除</button>
            </form>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

</div>

<!-- 管理员查看模态框 -->
<div id="adminModal" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center hidden z-50">
  <div class="bg-white rounded-xl shadow-lg w-full max-w-md p-6 relative">
    <!-- 关闭按钮 -->
    <button onclick="closeAdminModal()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-700 text-xl font-bold">&times;</button>

    <!-- 头像和用户名 -->
    <div class="flex flex-col items-center mb-4">
      <img id="modalAvatar" src="" class="w-24 h-24 rounded-full shadow object-cover border mb-2">
      <h2 id="modalUsername" class="text-xl font-semibold text-gray-800 hover:underline" onclick="copyToClipboard(this.textContent)"></h2>
      <p class="text-sm text-gray-500" id="modalRoleId"></p>
    </div>

    <!-- 信息展示 -->
    <div class="space-y-4 text-sm text-gray-700">
      <!-- 基本信息 -->
      <div>
        <h3 class="text-base font-semibold text-gray-600 mb-2 border-b pb-1">基本信息</h3>
        <ul class="space-y-1">
          <li><strong>性别：</strong><span id="modalGender"></span></li>
          <li><strong>手机：</strong><span id="modalPhone" class="cursor-pointer hover:underline" onclick="copyToClipboard(this.textContent)"></span></li>
          <li><strong>邮箱：</strong><span id="modalEmail" class="cursor-pointer hover:underline" onclick="copyToClipboard(this.textContent)"></span></li>
        </ul>
      </div>

      <!-- 账号信息 -->
      <div>
        <h3 class="text-base font-semibold text-gray-600 mb-2 border-b pb-1">账号信息</h3>
        <ul class="space-y-1">
          <li><strong>状态：</strong><span id="modalStatus"></span></li>
          <li><strong>创建时间：</strong><span id="modalCreatedAt"></span></li>
          <li><strong>更新时间：</strong><span id="modalUpdatedAt"></span></li>
          <li><strong>最后登录：</strong><span id="modalLastLogin"></span></li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script>
  function closeAlertModal() {
    document.getElementById('alertModal').classList.add('hidden');
  }

  const contextPath = '<%= request.getContextPath() %>';

  function showAdminModal(username, gender, phone, email, roleId, status, createdAt, updatedAt, lastLogin, avatar) {
    document.getElementById("modalUsername").innerText = username;
    document.getElementById("modalGender").innerText = gender === 'male' ? '男' : '女';
    document.getElementById("modalPhone").innerText = phone;
    document.getElementById("modalEmail").innerText = email;
    document.getElementById("modalRoleId").innerText = roleId == 1 ? "超级管理员" : "普通管理员";
    document.getElementById("modalStatus").innerText = status == 1 ? "启用" : "禁用";
    document.getElementById("modalCreatedAt").innerText = formatDateTime(createdAt);
    document.getElementById("modalUpdatedAt").innerText = formatDateTime(updatedAt);
    document.getElementById("modalLastLogin").innerText = lastLogin ? formatDateTime(lastLogin) : "从未登录";
    document.getElementById("modalAvatar").src = avatar.startsWith("/") ? contextPath + avatar : avatar;

    document.getElementById("adminModal").classList.remove("hidden");
  }

  function closeAdminModal() {
    document.getElementById("adminModal").classList.add("hidden");
  }

  function copyToClipboard(text) {
    navigator.clipboard.writeText(text).then(() => {
      alert("已复制：" + text);
    });
  }

  function formatDateTime(str) {
    return str ? str.replace("T", " ") : "";
  }
</script>

<style>
  .animate-fade {
    animation: fadeIn 0.4s ease-in-out;
  }

  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(-10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
</style>

</html>