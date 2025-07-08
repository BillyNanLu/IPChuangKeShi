<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>个人主页</title>
  <!-- 引入与home.jsp一致的资源 -->
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
  <style>
    /* 页面整体样式 */
    body {
      margin: 0;
      padding: 0;
      font-family: "Microsoft YaHei", sans-serif;
      background-color: #f5f5f5;
    }
    /* 主页容器 */
    .container {
      width: 900px;
      margin: 50px auto;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }
    /* 标题样式 */
    .title {
      padding: 20px;
      font-size: 24px;
      font-weight: bold;
      border-bottom: 1px solid #eee;
    }
    /* 模块通用样式 */
    .card {
      padding: 20px;
      margin: 20px;
      background-color: #fafafa;
      border-radius: 8px;
      box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
    }
    .card h2 {
      margin: 0 0 15px 0;
      font-size: 18px;
      font-weight: bold;
    }
    /* 基本信息 - 头像与资料布局 */
    .info-row {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
    }
    .info-row img {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      margin-right: 15px;
    }
    .info-row .name {
      font-size: 16px;
      font-weight: bold;
    }
    .info-item {
      margin-bottom: 10px;
      color: #666;
    }
    /* 订单表格样式 */
    .order-table {
      width: 100%;
      border-collapse: collapse;
    }
    .order-table th, .order-table td {
      padding: 12px 8px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }
    .order-table th {
      background-color: #f5f5f5;
      font-weight: bold;
    }
    .order-table td {
      color: #555;
    }
    /* 响应式适配（可选） */
    @media (max-width: 900px) {
      .container {
        width: 100%;
        margin: 0;
        border-radius: 0;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <!-- 标题 -->
  <div class="title">个人主页</div>

  <!-- 基本信息模块 -->
  <div class="card">
    <h2>基本信息</h2>
    <div class="info-row">
      <!-- 头像（可替换为真实用户头像） -->
      <img src="${pageContext.request.contextPath}/${person.avatar}" alt="头像">
    </div>
    <form action="${pageContext.request.contextPath}/updateProfile" method="post">
      <div>
        <input type="hidden" name="user_id" value="${person.userId}">
        <label for="username">用户名：</label>
        <input type="text" id="username" name="username" value="${person.username}">
      </div>
      <div>
        <label for="gender">性别：</label>
        <select id="gender" name="gender">
          <option name="gender" value="male" <c:if test="${person.gender == 'male'}"> selected </c:if> >男</option>
          <option name="gender" value="female" <c:if test="${person.gender == 'female'}"> selected </c:if> >女</option>
        </select>
      </div>
      <div>
        <label for="email">邮箱：</label>
        <input type="email" id="email" name="email" value="${person.email}">
      </div>
      <div>
        <label for="phone">电话：</label>
        <input type="tel" id="phone" name="phone" value="${person.phone}">
      </div>
      <button type="submit">保存</button>
    </form>
  </div>

  <!-- 订单详情模块 -->
  <div class="card">
    <h2>订单详情</h2>
    <table class="order-table">
      <thead>
      <tr>
        <th>订单编号</th>
        <th>课程名称</th>
        <th>用户</th>
        <th>支付方式</th>
        <th>订单状态</th>
        <th>订单时间</th>
      </tr>
      </thead>
      <tbody>
      <!-- 用 JSTL 遍历订单列表 -->
      <c:forEach var="order" items="${orderList}">
        <tr>
          <td>${order.orderNo}</td>
          <td>${order.courseName}</td>
          <td>${order.userName}</td>
          <td>${order.payMethod}</td>
          <td>${order.status}</td>
          <!-- 格式化时间显示 -->
          <td>${order.createdAt}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>