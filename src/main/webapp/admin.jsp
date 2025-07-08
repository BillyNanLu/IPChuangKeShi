<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/30
  Time: 20:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IP创氪师-管理后台</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
</head>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
  <!-- 欢迎信息 -->
  <div class="mb-8">
    <h1 class="text-2xl font-bold">欢迎回来，${loginUser.username}！</h1>
    <p class="text-gray-600 text-sm mt-1">
      当前角色：
      <c:choose>
        <c:when test="${loginUser.roleId == 1}">超级管理员</c:when>
        <c:otherwise>普通管理员</c:otherwise>
      </c:choose>
    </p>
  </div>

  <!-- 平台统计数据 -->
  <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-10">
    <div class="bg-white rounded-xl shadow p-6">
      <h2 class="text-gray-500 text-sm">总用户数</h2>
      <p class="text-3xl font-bold text-primary">${totalUsers}</p>
    </div>
    <div class="bg-white rounded-xl shadow p-6">
      <h2 class="text-gray-500 text-sm">总管理员数</h2>
      <p class="text-3xl font-bold text-primary">${totalAdmins}</p>
    </div>
    <div class="bg-white rounded-xl shadow p-6">
      <h2 class="text-gray-500 text-sm">活跃用户数</h2>
      <p class="text-3xl font-bold text-green-500">${activeUsers}</p>
    </div>
    <div class="bg-white rounded-xl shadow p-6">
      <h2 class="text-gray-500 text-sm">今日登录用户</h2>
      <p class="text-3xl font-bold text-blue-500">${todayLogins}</p>
    </div>
  </div>

  <c:choose>
    <c:when test="${loginUser.roleId == 1}">
      <!-- 最近登录的管理员 -->
      <div class="bg-white rounded-xl shadow p-6 mb-10">
        <h2 class="text-lg font-semibold mb-4">最近登录的管理员</h2>
        <table class="w-full text-sm">
          <thead>
          <tr class="text-left text-gray-600 border-b">
            <th class="py-2">用户名</th>
            <th class="py-2">手机号</th>
            <th class="py-2">邮箱</th>
            <th class="py-2">最后登录时间</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="admin" items="${recentAdmins}">
            <tr class="border-b">
              <td class="py-2">${admin.username}</td>
              <td class="py-2">${admin.phone}</td>
              <td class="py-2 text-gray-600">${admin.email}</td>
              <td class="py-2 text-gray-500">
                <c:choose>
                  <c:when test="${empty admin.last_login}">从未登录</c:when>
                  <c:otherwise>${admin.last_login.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))}</c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>

      <!-- 最近登录的普通用员 -->
      <div class="bg-white rounded-xl shadow p-6 mb-10">
        <h2 class="text-lg font-semibold mb-4">最近登录的用户</h2>
        <table class="w-full text-sm">
          <thead>
          <tr class="text-left text-gray-600 border-b">
            <th class="py-2">用户名</th>
            <th class="py-2">手机号</th>
            <th class="py-2">邮箱</th>
            <th class="py-2">最后登录时间</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="users" items="${recentUsers}">
            <tr class="border-b">
              <td class="py-2">${users.username}</td>
              <td class="py-2">${users.phone}</td>
              <td class="py-2 text-gray-600">${users.email}</td>
              <td class="py-2 text-gray-500">
                <c:choose>
                  <c:when test="${empty users.last_login}">从未登录</c:when>
                  <c:otherwise>${users.last_login.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))}</c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:when>
    <c:otherwise>
      <!-- 最近登录的普通用员 -->
      <div class="bg-white rounded-xl shadow p-6 mb-10">
        <h2 class="text-lg font-semibold mb-4">最近登录的用户</h2>
        <table class="w-full text-sm">
          <thead>
          <tr class="text-left text-gray-600 border-b">
            <th class="py-2">用户名</th>
            <th class="py-2">手机号</th>
            <th class="py-2">邮箱</th>
            <th class="py-2">最后登录时间</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="users" items="${recentUsers}">
            <tr class="border-b">
              <td class="py-2">${users.username}</td>
              <td class="py-2">${users.phone}</td>
              <td class="py-2 text-gray-600">${users.email}</td>
              <td class="py-2 text-gray-500">
                <c:choose>
                  <c:when test="${empty users.last_login}">从未登录</c:when>
                  <c:otherwise>${users.last_login}</c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:otherwise>
  </c:choose>


  <!-- 快捷入口模块 -->
  <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
    <a href="courseList" class="bg-blue-600 hover:bg-blue-700 text-white rounded-xl shadow p-6 text-center font-semibold">
      📚 课程信息管理
    </a>
    <a href="userList" class="bg-green-600 hover:bg-green-700 text-white rounded-xl shadow p-6 text-center font-semibold">
      👥 用户管理
    </a>
    <a href="consultationList" class="bg-yellow-500 hover:bg-yellow-600 text-white rounded-xl shadow p-6 text-center font-semibold">
      📋 首页咨询申请
    </a>
  </div>
</div>

</html>