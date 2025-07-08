<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/3
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IP创氪师-管理后台</title>
</head>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
  <div class="flex justify-between items-center mb-6">
    <h1 class="text-2xl font-bold text-gray-800">编辑教师信息</h1>
    <a href="teacherList" class="text-sm bg-gray-200 hover:bg-gray-300 text-gray-700 px-4 py-2 rounded">← 返回列表</a>
  </div>

  <c:if test="${not empty msg}">
    <div class="bg-red-100 text-red-700 border border-red-400 px-4 py-2 rounded mb-4">
        ${msg}
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/teacherEdit" method="post" enctype="multipart/form-data" class="bg-white p-6 rounded shadow space-y-6">
    <input type="hidden" name="id" value="${teacher.id}" />

    <div>
      <label class="block mb-1 font-medium">教师姓名</label>
      <input type="text" name="name" value="${teacher.name}" required class="w-full border px-4 py-2 rounded"/>
    </div>

    <div>
      <label class="block mb-1 font-medium">职称/头衔</label>
      <input type="text" name="title" value="${teacher.title}" class="w-full border px-4 py-2 rounded"/>
    </div>

    <div>
      <label class="block mb-1 font-medium">所属部门</label>
      <input type="text" name="department" value="${teacher.department}" class="w-full border px-4 py-2 rounded"/>
    </div>

    <div>
      <label class="block mb-1 font-medium">专业领域</label>
      <textarea name="expertise" rows="3" class="w-full border px-4 py-2 rounded">${teacher.expertise}</textarea>
    </div>

    <div>
      <label class="block mb-1 font-medium">个人简介</label>
      <textarea name="profile" rows="4" class="w-full border px-4 py-2 rounded">${teacher.profile}</textarea>
    </div>

    <div>
      <label class="block mb-1 font-medium">当前头像</label><br/>
      <img src="${pageContext.request.contextPath}${teacher.imgage}" class="w-24 h-24 rounded-full mb-2 object-cover border"/>
      <input type="file" name="imgage" accept="image/*" class="w-full border px-4 py-2 rounded"/>
    </div>

    <div>
      <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700">保存修改</button>
      <a href="teacherList" class="ml-4 text-gray-600 hover:underline">取消</a>
    </div>
  </form>
</div>

</html>