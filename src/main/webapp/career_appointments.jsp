<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/1
  Time: 00:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IP创氪师-管理后台</title>
</head>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
    <div class="mb-6">
        <h1 class="text-2xl font-bold">职业规划咨询预约信息表</h1>
        <p class="text-sm text-gray-500 mt-1">以下为用户提交的职业规划咨询预约信息</p>
    </div>


    <!-- 搜索框 -->
    <form action="careerAppointments" method="get" class="mb-6 flex items-center space-x-2">
        <input type="text" name="keyword" value="${keyword}" placeholder="搜索预约ID / 姓名 / 电话 / 城市 / 行业"
               class="border px-4 py-2 rounded w-64" />
        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">搜索</button>
    </form>


    <!-- 表格 -->
    <table class="min-w-full bg-white border">
        <thead class="bg-gray-200 text-gray-700">
        <tr>
            <th class="p-3 border">编号</th>
            <th class="p-3 border">预约ID</th>
            <th class="p-3 border">姓名</th>
            <th class="p-3 border">电话</th>
            <th class="p-3 border">预约时间</th>
            <th class="p-3 border">城市</th>
            <th class="p-3 border">行业</th>
            <th class="p-3 border">经验</th>
            <th class="p-3 border">付费咨询</th>
            <th class="p-3 border">状态</th>
            <th class="p-3 border">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="appt" items="${appointmentList}" varStatus="status">
            <tr class="hover:bg-gray-50 border-b">
                <td class="p-2 border text-center">${(page - 1) * 10 + status.index + 1}</td>
                <td class="p-2 border">${appt.appointmentId}</td>
                <td class="p-2 border">${appt.name}</td>
                <td class="p-2 border">${appt.phone}</td>
                <td class="p-2 border">${appt.time}</td>
                <td class="p-2 border">${appt.city}</td>
                <td class="p-2 border">${appt.industry}</td>
                <td class="p-2 border">${appt.experience}</td>
                <td class="p-2 border">${appt.paidConsult}</td>
                <td class="p-2 border">
                    <c:choose>
                        <c:when test="${appt.status == 0}">待处理</c:when>
                        <c:when test="${appt.status == 1}">已处理</c:when>
                        <c:when test="${appt.status == 2}">已取消</c:when>
                    </c:choose>
                </td>
                <td class="p-2 border space-x-2 text-center">
                    <button type="button"
                            class="text-blue-600 hover:underline"
                            onclick="showAppointmentModal(
                                    '${appt.appointmentId}',
                                    '${appt.name}',
                                    '${appt.phone}',
                                    '${appt.time}',
                                    '${appt.city}',
                                    '${appt.industry}',
                                    '${appt.experience}',
                                    '${appt.paidConsult}',
                                    '${appt.description}',
                                    '${appt.status}'
                                    )">查看</button>

                    <form action="careerAppointmentDelete" method="post" style="display:inline;" onsubmit="return confirm('确定删除该预约？');">
                        <input type="hidden" name="id" value="${appt.id}" />
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
                <a href="careerAppointments?page=${page - 1}&keyword=${keyword}" class="px-3 py-1 bg-gray-200 rounded hover:bg-gray-300">上一页</a>
            </c:if>
            <c:if test="${page < totalPage}">
                <a href="careerAppointments?page=${page + 1}&keyword=${keyword}" class="px-3 py-1 bg-gray-200 rounded hover:bg-gray-300">下一页</a>
            </c:if>
        </div>
    </div>


</div>

<div id="appointmentModal" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center hidden z-50">
    <div class="bg-white rounded shadow-lg max-w-lg w-full p-6 relative animate-fade">
        <button onclick="closeAppointmentModal()" class="absolute top-2 right-2 text-gray-500 hover:text-gray-700 text-xl">×</button>
        <h2 class="text-xl font-bold mb-4 text-gray-800">预约详情</h2>
        <div class="text-sm text-gray-700 space-y-2">
            <div><strong>预约ID：</strong><span id="modalAppointmentId"></span></div>
            <div><strong>姓名：</strong><span id="modalName"></span></div>
            <div><strong>电话：</strong><span id="modalPhone"></span></div>
            <div><strong>预约时间：</strong><span id="modalTime"></span></div>
            <div><strong>城市：</strong><span id="modalCity"></span></div>
            <div><strong>行业：</strong><span id="modalIndustry"></span></div>
            <div><strong>经验：</strong><span id="modalExperience"></span></div>
            <div><strong>付费咨询：</strong><span id="modalPaidConsult"></span></div>
            <div><strong>备注说明：</strong><p id="modalDescription" class="whitespace-pre-wrap border p-2 rounded bg-gray-50"></p></div>
            <div><strong>状态：</strong><span id="modalStatus"></span></div>
        </div>
    </div>
</div>


<script>
    function showAppointmentModal(appointmentId, name, phone, time, city, industry, experience, paidConsult, description, status) {
        document.getElementById('modalAppointmentId').innerText = appointmentId;
        document.getElementById('modalName').innerText = name;
        document.getElementById('modalPhone').innerText = phone;
        document.getElementById('modalTime').innerText = time;
        document.getElementById('modalCity').innerText = city;
        document.getElementById('modalIndustry').innerText = industry;
        document.getElementById('modalExperience').innerText = experience;
        document.getElementById('modalPaidConsult').innerText = paidConsult;
        document.getElementById('modalDescription').innerText = description;

        let statusText = "";
        switch (status) {
            case "0": statusText = "待处理"; break;
            case "1": statusText = "已处理"; break;
            case "2": statusText = "已取消"; break;
            default: statusText = "未知";
        }
        document.getElementById('modalStatus').innerText = statusText;

        document.getElementById('appointmentModal').classList.remove('hidden');
    }

    function closeAppointmentModal() {
        document.getElementById('appointmentModal').classList.add('hidden');
    }
</script>




</html>
