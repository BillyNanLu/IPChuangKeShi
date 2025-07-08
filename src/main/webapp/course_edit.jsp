<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/2
  Time: 00:01
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

    <h1 class="text-2xl font-bold mb-6">编辑课程信息</h1>
    <p class="text-sm text-gray-400">调试：id = ${course.id}</p>

    <c:if test="${not empty msg}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            <strong class="font-bold">错误：</strong>
            <span>${msg}</span>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/courseEdit" method="post" enctype="multipart/form-data"
          class="space-y-6">
        <c:if test="${not empty course}">
            <input type="hidden" name="id" value="${course.id}" />
        </c:if>


        <!-- 名称 -->
        <div>
            <label class="block mb-1 font-medium">课程名称</label>
            <input type="text" name="name" value="${course.name}" required class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 分类选择 -->
        <div>
            <label class="block mb-1 font-medium">课程分类</label>
            <select name="category_id" class="w-full border rounded px-4 py-2" required>
                <option value="">-- 请选择分类 --</option>
                <c:forEach var="cat" items="${allCategories}">
                    <option value="${cat.id}" <c:if test="${not empty course && cat.id == course.categoryId}">selected</c:if>>
                            ${cat.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- 标签 -->
        <div>
            <label class="block mb-1 font-medium">标签（英文逗号分隔）</label>
            <input type="text" name="tags" value="${course.tags}" class="w-full border rounded px-4 py-2"/>
        </div>

        <!-- 图片展示与上传 -->
        <div>
            <label class="block mb-1 font-medium">当前封面图片</label>
            <img src="${pageContext.request.contextPath}${course.image}" class="h-32 rounded shadow mb-2"/>
            <input type="file" name="image" accept="image/*" class="w-full border px-2 py-1 rounded"/>
        </div>

        <!-- 价格 & 折扣 -->
        <div class="grid grid-cols-2 gap-4">
            <div>
                <label class="block mb-1 font-medium">价格</label>
                <input type="number" step="0.01" name="price" value="${course.price}"
                       class="w-full border rounded px-4 py-2"/>
            </div>
            <div>
                <label class="block mb-1 font-medium">折扣（0~1）</label>
                <input type="number" step="0.01" name="discount" value="${course.discount}"
                       class="w-full border rounded px-4 py-2"/>
            </div>
        </div>

        <!-- 适合人群 -->
        <div>
            <label class="block mb-1 font-medium">适合人群</label>
            <textarea name="target_user" rows="3"
                      class="w-full border rounded px-4 py-2">${course.targetUser}</textarea>
        </div>

        <!-- 推荐理由 -->
        <div>
            <label class="block mb-1 font-medium">推荐理由</label>
            <textarea name="recommendation" rows="3"
                      class="w-full border rounded px-4 py-2">${course.recommendation}</textarea>
        </div>

        <!-- 多讲师选择 -->
        <div>
            <label class="block mb-2 font-medium">讲师（可多选）</label>
            <div class="grid grid-cols-2 gap-4 max-h-64 overflow-y-auto border p-3 rounded">
                <c:forEach var="t" items="${allTeachers}">
                    <div class="flex items-center space-x-3">
                        <input type="checkbox" name="teacher_ids" value="${t.id}"
                            <%--                        <c:if test="${fn:contains(teacherIdStr, ',' + t.id + ',')}">checked</c:if> />--%>
                        <c:if test="${not empty teacherIdStr && fn:contains(',' + teacherIdStr + ',', ',' + t.id + ',')}">
                               checked
                        </c:if>
                        <img src="${pageContext.request.contextPath}${t.imgage}" class="w-10 h-10 rounded-full"/>
                        <div>
                            <div class="font-semibold">${t.name}</div>
                            <div class="text-sm text-gray-500">${t.title}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- 提交按钮 -->
        <div>
            <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700">保存修改</button>
            <a href="courseList" class="ml-4 text-gray-600 hover:underline">取消</a>
        </div>
    </form>

</div>

</html>