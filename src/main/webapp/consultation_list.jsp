<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/30
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
        <h1 class="text-2xl font-bold">首页咨询申请列表</h1>
        <p class="text-sm text-gray-500 mt-1">以下为用户提交的预约咨询申请</p>
    </div>

    <!-- 搜索框 -->
    <form method="get" action="consultationList" class="mb-6 flex flex-wrap items-center gap-2">
        <input type="text" name="keyword" value="${keyword}" placeholder="输入姓名或手机号..."
               class="w-full md:w-80 px-4 py-2 rounded-lg border border-gray-300 shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200" />

        <button type="submit"
                class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-lg shadow transition duration-200">
            🔍 搜索
        </button>
    </form>

    <!-- 表格展示 -->
    <div class="overflow-x-auto bg-white rounded-xl shadow">
        <table class="min-w-full text-sm text-left text-gray-700">
            <thead class="bg-gray-100 text-gray-600">
            <tr>
                <th class="px-6 py-3">预约编号</th>
                <th class="px-6 py-3">姓名</th>
                <th class="px-6 py-3">电话</th>
                <th class="px-6 py-3">提交时间</th>
                <th class="px-6 py-3">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="c" items="${consultList}">
                <tr class="border-b hover:bg-gray-50">
                    <td class="px-6 py-4 font-mono text-blue-700">${c.appointment_id}</td>
                    <td class="px-6 py-4">${c.name}</td>
                    <td class="px-6 py-4">${c.phone}</td>
                    <td class="px-6 py-4">${c.created_at}</td>
                    <td class="px-6 py-4 space-x-2">
                        <button class="text-sm text-blue-600 hover:underline"
                                onclick="showDetail('${fn:escapeXml(c.description)}')">查看</button>
                        <form action="consultationList" method="post" class="inline">
                            <input type="hidden" name="id" value="${c.id}">
                            <button type="submit" onclick="return confirm('确认删除该申请？')" class="text-sm text-red-600 hover:underline">删除</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty consultList}">
                <tr>
                    <td colspan="5" class="text-center text-gray-400 py-6">暂无咨询申请</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <!-- 分页 -->
    <div class="mt-6 flex justify-center gap-2">
        <c:forEach begin="1" end="${totalPages}" var="p">
            <a href="consultation-list?page=${p}&keyword=${keyword}"
               class="px-4 py-2 rounded border ${p == page ? 'bg-blue-600 text-white' : 'bg-white text-gray-700 hover:bg-gray-100'}">
                第 ${p} 页
            </a>
        </c:forEach>
    </div>


    <!-- 查看详情 Modal -->
    <div id="detailModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-xl p-6 w-full max-w-md shadow-lg relative">
            <h2 class="text-lg font-semibold mb-4">咨询内容</h2>
            <p id="detailContent" class="text-gray-700 whitespace-pre-line"></p>
            <button onclick="closeModal()" class="absolute top-3 right-3 text-gray-400 hover:text-black">&times;</button>
        </div>
    </div>

    <script>
        function showDetail(desc) {
            document.getElementById('detailContent').innerText = desc;
            document.getElementById('detailModal').classList.remove('hidden');
            document.getElementById('detailModal').classList.add('flex');
        }
        function closeModal() {
            document.getElementById('detailModal').classList.remove('flex');
            document.getElementById('detailModal').classList.add('hidden');
        }
    </script>
</div>

</html>