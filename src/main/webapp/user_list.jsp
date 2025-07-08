<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/3
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IP创氪师-管理后台</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
</head>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
  <div class="flex justify-between items-center mb-6">
    <h1 class="text-2xl font-bold text-gray-800">普通用户管理</h1>
    <a href="userAdd" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
      + 添加用户
    </a>
  </div>


  <c:if test="${not empty msg}">
    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4 animate-fade">
      <strong class="font-bold">提示：</strong>
      <span>${msg}</span>
    </div>
  </c:if>

  <!-- 搜索框 -->
  <form method="get" action="userList" class="mb-6 flex items-center space-x-2">
    <input type="text" name="keyword" placeholder="搜索用户名/电话/邮箱"
           value="${param.keyword}"
           class="border px-4 py-2 rounded w-64"/>
    <button class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">搜索</button>
  </form>

  <table class="w-full bg-white shadow rounded">
    <thead>
    <tr class="bg-gray-100 text-left">
      <th class="p-3">编号</th>
      <th class="p-3">头像</th>
      <th class="p-3">用户名</th>
      <th class="p-3">性别</th>
      <th class="p-3">电话</th>
      <th class="p-3">邮箱</th>
      <th class="p-3">状态</th>
      <th class="p-3">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="u" items="${userList}" varStatus="s">
      <tr class="border-b hover:bg-gray-50">
        <td class="p-3">${s.index + 1}</td>
        <td class="p-3">
          <img src="${pageContext.request.contextPath}${u.avatar != null ? u.avatar : '/image/users/defaultavatars.jpg'}" class="w-10 h-10 rounded-full"/>
        </td>
        <td class="p-3">${u.username}</td>
        <td class="p-3">${u.gender == 'male' ? '男' : '女'}</td>
        <td class="p-3">${u.phone}</td>
        <td class="p-3">${u.email}</td>
        <td class="p-3">
          <form action="userToggleStatus" method="post" style="display:inline;">
            <input type="hidden" name="user_id" value="${u.user_id}" />
            <button class="px-2 py-1 rounded text-white ${u.status == 1 ? 'bg-green-500' : 'bg-gray-400'} hover:opacity-80">
                ${u.status == 1 ? '启用' : '禁用'}
            </button>
          </form>
        </td>
        <td class="p-3 space-x-2">
          <button type="button" class="text-indigo-600 hover:underline"
                  onclick="showUserDetail(
                    ${u.user_id},
                          '${fn:escapeXml(u.username)}',
                          '${u.gender}',
                          '${u.phone}',
                          '${u.email}',
                    ${u.status},
                    ${u.role_id},
                          '${u.created_at}',
                          '${u.updated_at}',
                          '${u.last_login}',
                          '${u.avatar}'
                          )">
            查看
          </button>
          <a href="userEdit?id=${u.user_id}" class="text-blue-600 hover:underline">编辑</a>
          <form action="userDelete" method="post" style="display:inline;" onsubmit="return confirm('确定删除该用户？');">
            <input type="hidden" name="user_id" value="${u.user_id}" />
            <button type="submit" class="text-red-600 hover:underline">删除</button>
          </form>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <!-- 分页 -->
  <div class="mt-6 flex justify-between items-center">
    <div class="text-sm text-gray-500">共 ${totalCount} 条记录，页数 ${page} / ${totalPage}</div>
    <div class="space-x-2">
      <c:if test="${page > 1}">
        <a href="userList?page=${page - 1}&keyword=${param.keyword}" class="px-3 py-1 bg-gray-200 rounded hover:bg-gray-300">上一页</a>
      </c:if>
      <c:if test="${page < totalPage}">
        <a href="userList?page=${page + 1}&keyword=${param.keyword}" class="px-3 py-1 bg-gray-200 rounded hover:bg-gray-300">下一页</a>
      </c:if>
    </div>
  </div>

</div>

<!-- ✨查看用户模态框 -->
<div id="userModal" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center hidden z-50">
  <div class="bg-white rounded-xl shadow-lg w-full max-w-md p-6 relative">
    <!-- 关闭按钮 -->
    <button onclick="closeModal()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-700 text-xl font-bold">&times;</button>

    <!-- 用户头像 -->
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
          <li>
            <strong>手机：</strong>
            <span id="modalPhone" class="cursor-pointer hover:underline" onclick="copyToClipboard(this.textContent)"></span>
          </li>
          <li>
            <strong>邮箱：</strong>
            <span id="modalEmail" class="cursor-pointer hover:underline" onclick="copyToClipboard(this.textContent)"></span>
          </li>
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

      <div class="text-center mt-4">
        <button onclick="exportPDF()" class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700">
          导出为 PDF
        </button>
      </div>

    </div>
  </div>
</div>


<script>
  function showUserDetail(id, username, gender, phone, email, status, roleId, createdAt, updatedAt, lastLogin, avatar) {
    document.getElementById('modalUsername').textContent = username;
    document.getElementById('modalGender').textContent = gender === 'male' ? '男' : '女';
    document.getElementById('modalPhone').textContent = phone;
    document.getElementById('modalEmail').textContent = email;
    document.getElementById('modalStatus').textContent = status === 1 ? '启用' : '禁用';
    document.getElementById('modalRoleId').textContent = roleId === 3 ? '学生用户' : '职场用户';
    document.getElementById('modalCreatedAt').textContent = createdAt.replace('T', ' ') || '—';
    document.getElementById('modalUpdatedAt').textContent = updatedAt.replace('T', ' ') || '—';
    document.getElementById('modalLastLogin').textContent = lastLogin.replace('T', ' ') || 'null';

    // 头像判断
    const base = '${pageContext.request.contextPath}';
    const finalAvatar = avatar && avatar !== 'null' ? base + avatar : base + '/image/users/defaultavatars.jpg';
    document.getElementById('modalAvatar').src = finalAvatar;

    document.getElementById('userModal').classList.remove('hidden');
  }

  function closeModal() {
    document.getElementById('userModal').classList.add('hidden');
  }

  function copyToClipboard(text) {
    navigator.clipboard.writeText(text).then(() => {
      alert('已复制：' + text);
    }).catch(err => {
      alert('复制失败');
      console.error(err);
    });
  }

  function exportPDF() {
    const modal = document.querySelector('#userModal .bg-white');
    const opt = {
      margin: 0.5,
      filename: '用户信息.pdf',
      image: {type: 'jpeg', quality: 0.98},
      html2canvas: {scale: 2},
      jsPDF: {unit: 'in', format: 'a4', orientation: 'portrait'}
    };
    html2pdf().from(modal).set(opt).save();
  }
</script>

</html>