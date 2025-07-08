<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/1
  Time: 00:09
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
    <div class="mb-6">
        <h1 class="text-2xl font-bold">课程订单管理</h1>
        <p class="text-sm text-gray-500 mt-1">以下为用户的课程订单详情</p>
    </div>

    <c:if test="${not empty sessionScope.msg}">
        <div class="mb-4 p-3 bg-green-200 text-green-700 rounded">
                ${sessionScope.msg}
        </div>
        <c:remove var="msg" scope="session" />
    </c:if>

    <!-- 搜索和筛选 -->
    <form method="get" action="courseOrders" class="mb-4 flex items-center gap-2">
        <input type="text" name="keyword" value="${keyword}" placeholder="搜索订单号、课程名、用户名"
               class="w-full md:w-80 px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500" />

        <select name="status" class="border border-gray-300 rounded px-3 py-2 focus:ring-2 focus:ring-blue-500">
            <option value="" ${status == '' ? 'selected' : ''}>全部状态</option>
            <option value="未支付" ${status == '未支付' ? 'selected' : ''}>未支付</option>
            <option value="已支付" ${status == '已支付' ? 'selected' : ''}>已支付</option>
        </select>

        <button type="submit"
                class="bg-blue-600 text-white px-5 py-2 rounded hover:bg-blue-700 transition">搜索 / 筛选</button>
    </form>


    <div class="overflow-x-auto bg-white rounded-xl shadow">
        <table class="min-w-full text-left text-sm text-gray-700">
            <thead class="bg-gray-100 text-gray-600">
            <tr>
                <th class="px-6 py-3 max-w-xs">订单号</th>
                <th class="px-6 py-3">课程名称</th>
                <th class="px-6 py-3">用户名</th>
                <th class="px-6 py-3">支付方式</th>
                <th class="px-6 py-3 whitespace-nowrap">支付状态</th>
                <th class="px-6 py-3">下单时间</th>
                <th class="px-6 py-3">支付时间</th>
                <th class="px-6 py-3 w-24">操作</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orderList}">
                    <tr class="border-b hover:bg-gray-50">
                        <td class="px-6 py-4 max-w-xs truncate font-mono text-blue-700 whitespace-nowrap" title="${order.orderNo}">
                                ${order.orderNo}
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">${order.courseName}</td>
                        <td class="px-6 py-4 whitespace-nowrap">${order.userName}</td>
                        <td class="px-6 py-4 whitespace-nowrap">${order.payMethod}</td>
                        <td class="px-6 py-4 whitespace-nowrap">${order.status}</td>
                        <td class="px-6 py-4 whitespace-nowrap">${order.createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))}</td>
                        <td class="px-6 py-4 whitespace-nowrap">${order.paidAt != null ? order.paidAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : '-'}</td>
                        <td class="px-6 py-4 space-x-2 whitespace-nowrap">
                            <button onclick="showDetails(${order.id})" class="text-blue-600 hover:underline">详情</button>
                            <form method="post" action="courseOrdersDelete" class="inline" onsubmit="return confirm('确定删除该订单吗？');">
                                <input type="hidden" name="id" value="${order.id}"/>
                                <button type="submit" class="text-red-600 hover:underline">删除</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orderList}">
                    <tr>
                        <td colspan="8" class="text-center text-gray-400 py-6">暂无订单</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 分页控件 -->
    <div class="mt-6 flex justify-center gap-2">
        <c:forEach begin="1" end="${totalPages}" var="p">
            <a href="courseOrders?page=${p}"
               class="px-4 py-2 rounded border
                      ${p == page ? 'bg-blue-600 text-white' : 'bg-white text-gray-700 hover:bg-gray-100'}">
                第 ${p} 页
            </a>
        </c:forEach>
    </div>
</div>

<!-- 订单详情弹窗 -->
<div id="detailModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
    <div class="bg-white rounded-lg max-w-lg w-full p-6 relative shadow-lg">
        <button onclick="closeDetails()"
                class="absolute top-3 right-3 text-gray-500 hover:text-gray-800 text-2xl font-bold leading-none">&times;</button>
        <h2 class="text-xl font-bold mb-4">订单详情</h2>
        <div id="detailContent">加载中...</div>
    </div>
</div>


<script>
    function showDetails(orderId) {
        fetch('courseOrders?id=' + orderId)
            .then(res => res.json())
            .then(data => {
                let content = `
                    <p><strong>订单号:</strong> ${data.orderNo}</p>
                    <p><strong>课程名:</strong> ${data.courseName}</p>
                    <p><strong>用户名:</strong> ${data.userName}</p>
                    <p><strong>支付方式:</strong> ${data.payMethod}</p>
                    <p><strong>支付状态:</strong> ${data.status}</p>
                    <p><strong>下单时间:</strong> ${data.createdAt}</p>
                    <p><strong>支付时间:</strong> ${data.paidAt || '-'}</p>
                    <p><strong>备注:</strong> ${data.more_info || '无'}</p>
                `;
                document.getElementById('detailContent').innerHTML = content;
                document.getElementById('detailModal').classList.remove('hidden');
                document.getElementById('detailModal').classList.add('flex');
            })
            .catch(() => {
                console.error('Fetch error:', error); // 添加错误日志
                document.getElementById('detailContent').innerHTML = '加载失败，请稍后重试';
            });
    }
    function closeDetails() {
        document.getElementById('detailModal').classList.add('hidden');
        document.getElementById('detailModal').classList.remove('flex');
    }
</script>

</html>