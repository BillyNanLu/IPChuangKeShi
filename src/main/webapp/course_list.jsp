<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/1
  Time: 17:15
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
</head>
<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
    <div class="flex justify-between items-center">
        <h1 class="text-2xl font-bold mb-6">课程信息管理</h1>
        <a href="${pageContext.request.contextPath}/courseEdit"
           class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded">
            添加课程
        </a>
    </div>


    <div class="bg-white p-6 rounded shadow overflow-x-auto">
        <c:if test="${not empty msg}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <strong class="font-bold">错误：</strong>
                <span>${msg}</span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/courseList" method="get" class="mb-6 flex">
            <input
                    type="text"
                    name="keyword"
                    value="${fn:escapeXml(keyword)}"
                    placeholder="搜索课程名称、标签、简介"
                    class="flex-grow border border-gray-300 rounded-l px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
            <button type="submit" class="bg-blue-600 text-white px-6 rounded-r hover:bg-blue-700">搜索</button>
        </form>


        <table class="min-w-full text-sm text-left border">
            <thead>
            <tr class="bg-gray-100 text-gray-600 uppercase">
                <th class="px-4 py-3">课程图片｜课程名称</th>
                <th class="px-4 py-3">分类</th>
                <th class="px-4 py-3">标签</th>
                <th class="px-4 py-3">讲师</th>
                <th class="px-4 py-3">价格</th>
                <th class="px-4 py-3">创建时间</th>
                <th class="px-4 py-3 text-right">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="course" items="${courseList}">
                <tr class="border-t">
                    <td class="px-4 py-2 min-w-[200px]"> <!-- 增加最小宽度 -->
                      <div class="flex items-center gap-3"> <!-- 使用 flex 让内容水平排列 -->
                        <img src="${pageContext.request.contextPath}${course.image}" alt="${course.name}"
                             class="w-14 h-14 object-cover rounded border cursor-pointer"
                             onclick="showImageModal('${pageContext.request.contextPath}${course.image}')"/>
                        <span class="truncate max-w-[120px]" title="${course.name}">${course.name}</span> <!-- 添加文本截断 -->
                      </div>
                    </td>
                    <td class="px-4 py-2 leading-snug text-sm text-gray-800">
                        <c:forEach var="part" items="${fn:split(course.fullCategoryPath, '/')}">
                            <div>${fn:trim(part)}</div>
                        </c:forEach>
                    </td>

                    <td class="px-4 py-2">${course.tags}</td>
                    <td class="px-4 py-2">
                        <div class="flex flex-col gap-1">
                            <c:forEach var="t" items="${course.teachers}">
                                <span class="bg-gray-100 text-gray-800 px-2 py-1 rounded">${t}</span>
                            </c:forEach>
                        </div>
                    </td>
                    <td class="px-4 py-2 leading-snug">
                        <div class="text-primary font-bold">
                            ¥<fmt:formatNumber value="${course.price}" type="number" minFractionDigits="2"/>
                        </div>
                        <c:if test="${course.discount < 1}">
                            <div class="text-sm text-gray-400 line-through">
                                ¥<fmt:formatNumber value="${course.price * course.discount}" type="number"
                                                   minFractionDigits="2"/>
                            </div>
                        </c:if>
                    </td>
                    <td class="px-4 py-2 min-w-[160px] whitespace-nowrap">
                        <c:choose>
                            <c:when test="${not empty course.createTime}">
                                ${course.createTimeStr}
                            </c:when>
                            <c:otherwise>未设置</c:otherwise>
                        </c:choose>
                    </td>
                    <td class="px-4 py-2 text-right whitespace-nowrap">
                        <a href="courseView?id=${course.id}" class="text-blue-600 hover:underline mr-2">查看</a>
                        <a href="courseEdit?id=${course.id}" class="text-green-600 hover:underline mr-2">编辑</a>
                        <a href="courseDelete?id=${course.id}" class="text-red-600 hover:underline"
                           onclick="return confirm('确认删除该课程？删除后不可恢复！')">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="mt-6 flex justify-center space-x-3">
            <c:if test="${page > 1}">
                <a href="?page=${page - 1}&keyword=${fn:escapeXml(keyword)}"
                   class="px-3 py-1 border rounded hover:bg-gray-200">上一页</a>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="?page=${i}&keyword=${fn:escapeXml(keyword)}"
                   class="px-3 py-1 border rounded
           ${i == page ? 'bg-blue-600 text-white' : 'hover:bg-gray-200'}">${i}</a>
            </c:forEach>
            <c:if test="${page < totalPages}">
                <a href="?page=${page + 1}&keyword=${fn:escapeXml(keyword)}"
                   class="px-3 py-1 border rounded hover:bg-gray-200">下一页</a>
            </c:if>
        </div>


    </div>
</div>

<!-- 模态框 -->
<div id="imageModal" class="fixed inset-0 bg-black/70 hidden items-center justify-center z-50">
    <div class="bg-white p-4 rounded shadow-lg">
        <img id="modalImage" src="" class="max-w-[80vw] max-h-[80vh] rounded"/>
        <button onclick="closeImageModal()" class="mt-4 block mx-auto px-4 py-1 bg-red-500 text-white rounded">关闭
        </button>
    </div>
</div>


<script>
    function showImageModal(src) {
        document.getElementById("modalImage").src = src;
        document.getElementById("imageModal").classList.remove("hidden");
        document.getElementById("imageModal").classList.add("flex");
    }

    function closeImageModal() {
        document.getElementById("imageModal").classList.add("hidden");
        document.getElementById("imageModal").classList.remove("flex");
    }
</script>

</html>
