<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/1
  Time: 23:30
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

    <div class="flex flex-col md:flex-row gap-8">
        <!-- 左侧封面图 -->
        <div class="md:w-1/3">
            <img src="${pageContext.request.contextPath}${course.image}"
                 alt="${course.name}"
                 class="w-full h-64 object-cover rounded-lg shadow-md cursor-pointer hover:scale-105 transition"
                 onclick="showImageModal('${pageContext.request.contextPath}${course.image}')" />
        </div>

        <!-- 右侧信息 -->
        <div class="md:w-2/3 space-y-4 text-gray-800 text-sm leading-relaxed">

            <div>
                <h2 class="text-2xl font-bold text-gray-900 mb-1">${course.name}</h2>
                <p class="text-gray-500 text-sm">${course.tags}</p>
            </div>

            <div class="border-t pt-2">
                <p><span class="font-medium">分类路径：</span></p>
                <ul class="list-disc list-inside text-gray-700">
                    <c:forEach var="part" items="${fn:split(course.fullCategoryPath, '/')}">
                        <li>${fn:trim(part)}</li>
                    </c:forEach>
                </ul>
            </div>

            <div class="flex items-center space-x-4 border-t pt-2">
                <span class="text-primary text-xl font-semibold">
                    ¥<fmt:formatNumber value="${course.price}" minFractionDigits="2" />
                </span>
                <c:if test="${course.discount < 1}">
                  <span class="text-sm text-gray-400 line-through">
                      ¥<fmt:formatNumber value="${course.price * course.discount}" minFractionDigits="2" />
                  </span>
                </c:if>
            </div>

            <div class="border-t pt-2">
                <p><span class="font-medium">适合人群：</span><br/>${course.targetUser}</p>
            </div>

            <div class="border-t pt-2">
                <p><span class="font-medium">推荐理由：</span><br/>${course.recommendation}</p>
            </div>

            <div class="border-t pt-2">
                <p><span class="font-medium">课程介绍：</span><br/>${course.intro}</p>
            </div>

            <div class="border-t pt-2">
                <p><span class="font-medium">讲师：</span></p>
                <ul class="list-disc list-inside text-gray-700">
                    <c:forEach var="t" items="${course.teachers}">
                        <li>${t}</li>
                    </c:forEach>
                </ul>
            </div>

            <div>
                <strong>创建时间：</strong>
                ${course.createTime != null ?
                        course.createTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) :
                        "未设置"}
                <br/>
                <strong>更新时间：</strong>
                ${course.updateTime != null ?
                        course.updateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) :
                        "未设置"}
            </div>

            <div class="pt-4">
                <a href="courseList" class="inline-block px-4 py-2 bg-gray-100 hover:bg-gray-200 rounded shadow-sm text-sm">
                    ← 返回课程列表
                </a>
            </div>
        </div>
    </div>
</div>

<!-- 模态框 -->
<div id="imageModal" class="fixed inset-0 bg-black/70 hidden items-center justify-center z-50">
    <div class="bg-white p-4 rounded shadow-lg">
        <img id="modalImage" src="" class="max-w-[80vw] max-h-[80vh] rounded" />
        <button onclick="closeImageModal()" class="mt-4 block mx-auto px-4 py-1 bg-red-500 text-white rounded">关闭</button>
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
