<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/3
  Time: 20:50
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
    <script src="https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
</head>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-8 bg-gray-100 min-h-screen">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-gray-800">教师管理</h1>
        <a href="teacherAdd.jsp" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">+ 添加教师</a>
    </div>

    <c:if test="${not empty param.msg}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-2 rounded mb-4">
                ${param.msg}
        </div>
    </c:if>


    <!-- 搜索表单 -->
    <form method="get" action="teacherList" class="mb-6 flex space-x-2">
        <input type="text" name="keyword" value="${keyword}" placeholder="搜索教师姓名或职称"
               class="w-64 px-4 py-2 border rounded"/>
        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">搜索</button>
    </form>

    <!-- 教师列表表格 -->
    <div class="bg-white shadow rounded">
        <table class="w-full text-sm text-left">
            <thead class="bg-gray-100 text-gray-700">
            <tr>
                <th class="p-3">#</th>
                <th class="p-3">头像</th>
                <th class="p-3">姓名</th>
                <th class="p-3">职称</th>
                <th class="p-3">部门</th>
                <th class="p-3">专业领域</th>
                <th class="p-3">简介</th>
                <th class="p-3">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="t" items="${teacherList}" varStatus="s">
                <tr class="border-b hover:bg-gray-50">
                    <td class="p-3">${(page - 1) * 10 + s.index + 1}</td>
                    <td class="p-3">
                        <img src="${pageContext.request.contextPath}${t.imgage != null ? t.imgage : '/image/users/defaultavatars.jpg'}"
                             class="w-10 h-10 rounded-full object-cover border"/>
                    </td>
                    <td class="p-3">${t.name}</td>
                    <td class="p-3">${t.title}</td>
                    <td class="p-3">${t.department}</td>
                    <td class="p-3 text-ellipsis overflow-hidden max-w-[200px]">${t.expertise}</td>
                    <td class="p-3 text-ellipsis overflow-hidden max-w-[200px]">${t.profile}</td>
                    <td class="p-3 space-x-2">
                        <button type="button" class="text-green-600 hover:underline"
                                onclick="showTeacherModal(${t.id}, '${fn:escapeXml(t.name)}', '${fn:escapeXml(t.title)}',
                                        '${fn:escapeXml(t.department)}', '${fn:escapeXml(t.expertise)}',
                                        '${fn:escapeXml(t.profile)}', '${t.imgage}', '${t.createdTime}', '${t.updatedTime}')">
                            查看
                        </button>
                        <a href="teacherEdit?id=${t.id}" class="text-green-600 hover:underline">编辑</a>
                        <form action="teacherDelete" method="post" style="display:inline;" onsubmit="return confirm('确定删除该教师？');">
                            <input type="hidden" name="id" value="${t.id}" />
                            <button type="submit" class="text-red-600 hover:underline">删除</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- 分页导航 -->
    <div class="mt-6 flex justify-between items-center">
        <!-- 总数 & 当前页 -->
        <div class="text-sm text-gray-500">
            共 ${total} 条记录，页数 ${page} / ${totalPages}
        </div>

        <!-- 上一页 / 下一页 -->
        <div class="space-x-2">
            <c:if test="${page > 1}">
                <a href="teacherList?page=${page - 1}&keyword=${param.keyword}" class="px-3 py-1 bg-gray-200 rounded hover:bg-gray-300">
                    上一页
                </a>
            </c:if>

            <c:if test="${page < totalPages}">
                <a href="teacherList?page=${page + 1}&keyword=${param.keyword}" class="px-3 py-1 bg-gray-200 rounded hover:bg-gray-300">
                    下一页
                </a>
            </c:if>
        </div>
    </div>

</div>

<!-- 查看教师模态框 -->
<div id="teacherModal" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center hidden z-50">
    <div class="bg-white p-6 rounded-lg shadow-lg max-w-lg w-full relative animate-fade">
        <button onclick="closeTeacherModal()"
                class="absolute top-3 right-3 text-gray-400 hover:text-gray-700 text-2xl font-bold leading-none">&times;</button>

        <h2 class="text-2xl font-semibold text-gray-800 mb-6 text-center">教师详情</h2>

        <div class="flex flex-col items-center mb-6">
            <img id="modalImage" src="" alt="教师头像" class="w-28 h-28 rounded-full border object-cover shadow-sm"/>
        </div>

        <div class="text-gray-700 text-sm space-y-4">
            <div>
                <strong>姓名：</strong>
                <span id="modalName" class="cursor-pointer hover:underline" onclick="copyToClipboard(this.textContent)"></span>
            </div>
            <div class="grid grid-cols-2 gap-x-6 gap-y-2">
                <div>
                    <strong>职称：</strong>
                    <span id="modalTitle" class="cursor-pointer hover:underline" onclick="copyToClipboard(this.textContent)"></span>
                </div>
                <div>
                    <strong>部门：</strong>
                    <span id="modalDept" class="cursor-pointer hover:underline" onclick="copyToClipboard(this.textContent)"></span>
                </div>
            </div>

            <div>
                <strong>专业领域：</strong>
                <p><span id="modalExpertise" class="cursor-pointer hover:underline" onclick="copyToClipboard(this.textContent)"></span></p>
            </div>

            <div>
                <strong>个人简介：</strong>
                <p><span id="modalProfile" class="cursor-pointer hover:underline" onclick="copyToClipboard(this.textContent)"></span></p>
            </div>

            <div><strong>创建时间：</strong> <span id="modalCreated"></span></div>
            <div><strong>更新时间：</strong> <span id="modalUpdated"></span></div>
        </div>

        <div class="mt-6 text-right">
            <button onclick="exportTeacherToPDF()"
                    class="bg-red-600 hover:bg-red-700 text-white px-5 py-2 rounded shadow transition duration-200">
                导出为 PDF
            </button>
        </div>
    </div>
</div>

<style>
    .animate-fade {
        animation: fadeIn 0.3s ease-in-out;
    }
    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(-10px);}
        to {opacity: 1; transform: translateY(0);}
    }
</style>



<script>
    function showTeacherModal(id, name, title, department, expertise, profile, image, created, updated) {
        const contextPath = '${pageContext.request.contextPath}';
        document.getElementById("modalName").innerText = name;
        document.getElementById("modalTitle").innerText = title;
        document.getElementById("modalDept").innerText = department;
        document.getElementById("modalExpertise").innerText = expertise;
        document.getElementById("modalProfile").innerText = profile;
        document.getElementById("modalCreated").innerText = formatDate(created);
        document.getElementById("modalUpdated").innerText = formatDate(updated);
        document.getElementById("modalImage").src = image ? contextPath + image : contextPath + "/image/teachers/defaultavatars.jpg";
        document.getElementById("teacherModal").classList.remove("hidden");
    }

    function closeTeacherModal() {
        document.getElementById("teacherModal").classList.add("hidden");
    }

    function formatDate(dateStr) {
        return dateStr ? dateStr.replace("T", " ") : "null";
    }

    function copyToClipboard(text) {
        navigator.clipboard.writeText(text).then(() => {
            alert('已复制：' + text);
        }).catch(err => {
            alert('复制失败');
            console.error(err);
        });
    }

    async function exportTeacherToPDF() {
        const modalContent = document.querySelector('#teacherModal .bg-white'); // 只导出卡片内容
        const canvas = await html2canvas(modalContent, {
            scale: 2,
            useCORS: true
        });

        const imgData = canvas.toDataURL('image/png');
        const { jsPDF } = window.jspdf;
        const pdf = new jsPDF({
            orientation: 'portrait',
            unit: 'mm',
            format: 'a4'
        });

        const pageWidth = pdf.internal.pageSize.getWidth();
        const pageHeight = pdf.internal.pageSize.getHeight();

        const imgWidth = pageWidth - 20;
        const imgHeight = canvas.height * imgWidth / canvas.width;

        pdf.addImage(imgData, 'PNG', 10, 10, imgWidth, imgHeight);
        const fileName = document.getElementById("modalName").innerText + "_教师信息.pdf";
        pdf.save(fileName);
    }
</script>

<style>
    .animate-fade {
        animation: fadeIn 0.3s ease-in-out;
    }
    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(-10px);}
        to {opacity: 1; transform: translateY(0);}
    }
</style>

</html>