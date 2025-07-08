<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/30
  Time: 20:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="https://cdn.tailwindcss.com"></script>
<link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

<!-- sidebar.jsp -->
<div class="w-64 h-screen bg-gray-900 text-white fixed left-0 top-0 flex flex-col">
    <div class="p-6 text-2xl font-bold border-b border-gray-700">
        IP 创氪师后台
    </div>

    <!-- 管理员信息 -->
    <c:if test="${not empty loginUser}">
        <div class="flex items-center space-x-3 px-4 py-3 border-b border-gray-700">
            <img src="${pageContext.request.contextPath}${loginUser.avatar != null ? loginUser.avatar : '/image/users/defaultavatars.jpg'}"
                 alt="头像" class="w-10 h-10 rounded-full object-cover border"/>
            <div>
                <div class="font-semibold text-white text-sm">
                        ${loginUser.username}
                </div>
                <div class="text-gray-400 text-xs">管理员</div>
            </div>
        </div>
    </c:if>

    <nav class="flex-1 overflow-y-auto p-4 space-y-4 text-sm">
        <a href="adminDashboard" class="block px-3 py-2 rounded hover:bg-gray-700">🏠 管理员首页</a>
        <a href="consultationList" class="block px-3 py-2 rounded hover:bg-gray-700">📋 首页咨询申请</a>
        <a href="careerAppointments" class="block px-3 py-2 rounded hover:bg-gray-700">📅 职业规划预约</a>
        <a href="aiChatList" class="block px-3 py-2 rounded hover:bg-gray-700">🤖 AI 聊天记录管理</a>


        <div>
            <details class="group">
                <summary class="px-3 py-2 rounded cursor-pointer hover:bg-gray-700">📚 课程管理</summary>
                <div class="ml-4 mt-2 space-y-1">
                    <a href="courseOrders" class="block px-2 py-1 rounded hover:bg-gray-700">· 课程订单</a>
                    <a href="categoryList" class="block px-2 py-1 rounded hover:bg-gray-700">· 课程类别管理</a>
                    <a href="courseList" class="block px-2 py-1 rounded hover:bg-gray-700">· 课程信息管理</a>
                </div>
            </details>
        </div>

        <div>
            <details class="group">
                <summary class="px-3 py-2 rounded cursor-pointer hover:bg-gray-700">👥 用户管理</summary>
                <div class="ml-4 mt-2 space-y-1">
                    <a href="userList" class="block px-2 py-1 rounded hover:bg-gray-700">· 普通用户</a>
                    <a href="teacherList" class="block px-2 py-1 rounded hover:bg-gray-700">· 教师</a>
                    <a href="adminList" class="block px-2 py-1 rounded hover:bg-gray-700">· 管理员</a>
                </div>
            </details>
        </div>
    </nav>

    <div class="p-4 border-t border-gray-700 space-y-2">
        <!-- 去往IP师（带确认弹窗） -->
        <button onclick="confirmRedirect()"
                class="w-full px-3 py-2 bg-blue-600 text-white text-center rounded hover:bg-blue-700 transition">
            🌐 去往IP师
        </button>

        <!-- 退出登录按钮 -->
        <a href="logout" class="block px-3 py-2 bg-red-600 text-white text-center rounded hover:bg-red-700">
            🚪 退出登录
        </a>
    </div>

</div>

<!-- 弹窗模态框 -->
<div id="redirectModal" class="fixed inset-0 bg-black bg-opacity-40 hidden items-center justify-center z-50">
    <div class="bg-white rounded-lg shadow-xl p-6 w-full max-w-md animate-fade">
        <h2 class="text-lg font-bold text-gray-800 mb-4">确认跳转</h2>
        <p class="text-gray-600 mb-6">你将离开后台，前往 IP 师前台页面。是否继续？</p>
        <div class="flex justify-end space-x-4">
            <button onclick="closeRedirectModal()" class="px-4 py-2 bg-gray-300 rounded hover:bg-gray-400">
                取消
            </button>
            <a href="${pageContext.request.contextPath}/home"
               class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
                确认跳转
            </a>
        </div>
    </div>
</div>

<script>
    function confirmRedirect() {
        document.getElementById('redirectModal').classList.remove('hidden');
        document.getElementById('redirectModal').classList.add('flex');
    }

    function closeRedirectModal() {
        document.getElementById('redirectModal').classList.add('hidden');
        document.getElementById('redirectModal').classList.remove('flex');
    }
</script>

<style>
    .animate-fade {
        animation: fadeIn 0.3s ease-out;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: scale(0.95);
        }
        to {
            opacity: 1;
            transform: scale(1);
        }
    }
</style>