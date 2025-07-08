<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/25
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.name} - 课程详情</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/line-clamp"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">

    <!-- Tailwind 配置 -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#165DFF',
                        secondary: '#FF7D00',
                        dark: '#1D2129',
                        light: '#F7F8FA',
                    },
                    fontFamily: {
                        inter: ['Inter', 'system-ui', 'sans-serif'],
                    },
                },
            }
        }
    </script>

    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto {
                content-visibility: auto;
            }

            .text-shadow {
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .transition-navbar {
                transition: background-color 0.3s, box-shadow 0.3s, padding 0.3s;
            }

            .card-hover {
                transition: transform 0.3s, box-shadow 0.3s, border-color 0.3s;
            }

            .card-hover:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.06);
                border-color: theme('colors.primary');
            }

            .category-item {
                @apply relative cursor-pointer px-4 py-2 text-gray-700 hover:text-primary transition-colors;
            }

            .category-item.active {
                @apply text-primary border-b-2 border-primary;
            }

            .subcategory-item {
                @apply px-4 py-2 text-gray-600 hover:text-primary transition-colors cursor-pointer;
            }

            .subcategory-item.active {
                @apply text-primary;
            }

            .nav-link {
                @apply relative inline-block font-medium text-gray-700 hover:text-primary transition-colors;
            }

            .nav-link::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: -4px;
                height: 2px;
                width: 0%;
                background-color: theme('colors.primary');
                transition: width 0.3s;
            }

            .nav-link:hover::after {
                width: 100%;
            }

            .tag-hover {
                @apply px-3 py-1 text-sm rounded-full cursor-pointer transition-all bg-gray-100 text-gray-600;
            }

            .tag-hover:hover {
                @apply bg-primary text-white;
            }

            #back-to-top:hover {
                transform: scale(1.1) translateY(-2px);
                box-shadow: 0 8px 16px rgba(22, 93, 255, 0.3);
            }

            .social-icon {
                @apply w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-white transition-transform;
            }

            .social-icon:hover {
                @apply bg-primary scale-110;
            }

            .search-input {
                @apply w-full px-6 py-4 rounded-full border border-gray-300 shadow-sm backdrop-blur-md bg-white/70 focus:ring-2 focus:ring-primary focus:border-primary transition-all pl-12 pr-40;
            }

            .course-card {
                @apply bg-white rounded-xl border border-gray-100 p-6 shadow-sm hover:shadow-lg transition-transform hover:-translate-y-1 hover:border-primary;
            }

            .tab-btn {
                @apply px-6 py-2 rounded-full border border-gray-300 text-gray-700 hover:bg-gray-100 transition duration-300;
            }

            .active-tab {
                @apply bg-primary text-white border-primary;
            }

            .tab-section {
                @apply transition-opacity duration-300;
            }

            .content-fade {
                animation: fadeIn 0.5s ease-in-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        }
    </style>
</head>
<body class="font-inter text-dark antialiased bg-light">
<header id="navbar" class="fixed top-0 left-0 w-full z-50 transition-navbar bg-white/95 backdrop-blur-md shadow-sm">
    <div class="container mx-auto px-8">
        <div class="flex justify-between items-center h-16 md:h-20">
            <div class="flex items-center">
                <a href="home" class="flex items-center space-x-2">
                    <div class="w-10 h-10 rounded-lg bg-primary flex items-center justify-center text-white">
                        <i class="fa fa-rocket text-xl"></i>
                    </div>
                    <div>
                        <h1 class="text-lg md:text-xl font-bold text-primary">IP创氪师</h1>
                        <p class="text-xs text-gray-500">成长，长成自己的样子</p>
                    </div>
                </a>
            </div>

            <nav class="flex items-center space-x-8">
                <a href="home" class="text-gray-700 hover:text-primary transition-colors font-medium">首页</a>
                <a href="courses" class="text-gray-700 hover:text-primary transition-colors font-medium border-b-2 border-primary">课程培训</a>
                <a href="consult.jsp" class="text-gray-700 hover:text-primary transition-colors font-medium">一对一职业规划咨询</a>
                <a href="chat" class="text-gray-700 hover:text-primary transition-colors font-medium">AI职业规划咨询</a>
                <c:choose>
                    <c:when test="${loginUser.roleId == 1 || loginUser.roleId == 2}">
                        <a href="adminDashboard" class="text-gray-700 hover:text-primary transition-colors font-medium">工作台</a>
                    </c:when>
                    <c:otherwise>
                        <a href="myProfile" class="text-gray-700 hover:text-primary transition-colors font-medium">个人中心</a>
                    </c:otherwise>
                </c:choose>
            </nav>

            <div class="flex items-center space-x-4">
                <div class="flex items-center space-x-4">
                    <c:choose>
                        <c:when test="${not empty loginUser}">
                            <div class="flex items-center space-x-2">
                                <c:choose>
                                    <c:when test="${not empty loginUser.avatar}">
                                        <img src="${pageContext.request.contextPath}${loginUser.avatar}" alt="头像"
                                             class="w-8 h-8 rounded-full object-cover border border-gray-300">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="image/users/defaultavatars.jpg" alt="默认头像"
                                             class="w-8 h-8 rounded-full object-cover border border-gray-300">
                                    </c:otherwise>
                                </c:choose>
                                <span class="text-gray-700 font-medium">${loginUser.username}</span>
                                <a href="logout" class="text-sm text-red-500 hover:underline">退出</a>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <a href="login.jsp" class="text-gray-700 hover:text-primary transition-colors font-medium">登录</a>
                            <a href="register.jsp"
                               class="text-gray-700 hover:text-primary transition-colors font-medium">注册</a>
                        </c:otherwise>
                    </c:choose>

                    <a href="#consult"
                       class="online-consult-btn bg-secondary hover:bg-secondary/90 text-white px-5 py-2 rounded-full font-medium transition-all shadow-md hover:shadow-lg transform hover:-translate-y-0.5">
                        课程咨询
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- ✅ 主内容区：课程详情 -->
<main class="container mx-auto px-6 py-20 space-y-16">
    <c:if test="${not empty param.msg}">
        <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 mb-6 rounded">
            <p>${param.msg}</p>
        </div>
    </c:if>

    <!-- 返回按钮 -->
    <div class="max-w-6xl mx-auto mb-6">
        <a href="courses" class="text-sm text-primary hover:underline inline-flex items-center">
            <i class="fa fa-angle-left mr-1"></i> 返回课程列表
        </a>
    </div>

    <!-- 封面区：课程标题 + 封面图 + 简介 -->
    <div class="max-w-6xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
        <!-- 课程封面图 -->
        <img src="${pageContext.request.contextPath}${courseMore.image}" alt="课程封面图"
             class="w-full rounded-2xl shadow-md object-cover h-64 lg:h-96">

        <!-- 文本信息 -->
        <div>
            <h1 class="text-4xl font-bold text-dark mb-4">${course.name}</h1>
            <p class="text-gray-600 text-lg mb-4 leading-relaxed">${course.intro}</p>

            <c:if test="${not empty course.tags}">
                <div class="flex flex-wrap gap-2">
                    <c:forEach var="tag" items="${fn:split(course.tags, ',')}">
                        <span class="px-3 py-1 bg-primary/10 text-primary text-sm rounded-full">${tag}</span>
                    </c:forEach>
                </div>
            </c:if>

            <!-- 价格信息 -->
            <div class="mt-2">
                <!-- 显示折后价 -->
                <span class="text-2xl font-bold text-secondary">
                    ¥<fmt:formatNumber value="${courseMore.price * courseMore.discount}" pattern="#0.00" />
                </span>

                <!-- 显示原价（划线） -->
                <span class="text-sm text-gray-400 ml-2 line-through">
                    ¥<fmt:formatNumber value="${courseMore.price}" pattern="#.##" />
                </span>

                <span class="ml-2 text-sm bg-secondary/10 text-secondary px-2 py-0.5 rounded-full">
                    限时优惠
                </span>
            </div>

        </div>
    </div>

    <!-- 详情与推荐分栏 -->
    <div class="max-w-6xl mx-auto grid grid-cols-1 lg:grid-cols-3 gap-12">
        <!-- 主内容：适合人群、推荐理由、讲师 -->
        <div class="lg:col-span-2 space-y-12">
            <!-- 适合人群 -->
            <div>
                <h2 class="text-2xl font-bold text-primary mb-4"><i class="fa fa-user mr-2"></i> 适合人群</h2>
                <p class="text-gray-700 leading-relaxed">${course.targetUser}</p>
            </div>

            <!-- 推荐理由 -->
            <div>
                <h2 class="text-2xl font-bold text-primary mb-4"><i class="fa fa-star mr-2"></i> 推荐理由</h2>
                <p class="text-gray-700 leading-relaxed">${course.recommendation}</p>
            </div>

            <!-- 多位讲师信息展示 -->
            <div class="space-y-6">
                <c:forEach var="teacher" items="${teachers}">
                    <div class="flex items-start space-x-6">
                        <img src="${pageContext.request.contextPath}${teacher.imgage}" alt="讲师头像"
                             class="w-20 h-20 rounded-full border-2 border-primary shadow">
                        <div>
                            <h3 class="text-lg font-semibold text-dark">${teacher.name}</h3>
                            <p class="text-sm text-gray-600">${teacher.expertise}</p>
                            <p class="text-sm text-gray-600 mt-1">${teacher.profile}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>

        </div>

        <!-- 咨询报名 CTA（双按钮美化） -->
        <div class="bg-primary/5 rounded-2xl p-8 shadow-md text-center flex flex-col items-center justify-center space-y-6 h-full">
            <h3 class="text-2xl font-bold text-dark">立即开启职业成长之旅</h3>
            <p class="text-sm text-gray-600">如有疑问，欢迎咨询我们的课程顾问</p>

            <!-- 按钮区域：响应式排列 -->
            <div class="flex flex-col sm:flex-row gap-4 justify-center w-full">
                <a href="#consult"
                   class="online-consult-btn bg-secondary hover:bg-secondary/90 text-white text-base font-semibold px-6 py-3 rounded-full shadow transition-all flex-1">
                    课程咨询
                </a>
                <a href="enroll?courseId=${course.id}"
                   class="bg-primary hover:bg-primary/90 text-white text-base font-semibold px-6 py-3 rounded-full shadow transition-all flex-1">
                    立即报名
                </a>
            </div>
        </div>

    </div>

    <!-- 常见问答 FAQ -->
    <div class="max-w-6xl mx-auto bg-white rounded-2xl shadow-lg p-10">
        <h2 class="text-2xl font-bold text-primary mb-6 flex items-center">
            <i class="fa fa-question-circle mr-2"></i> 常见问答
        </h2>

        <div class="divide-y divide-gray-200" id="faq-list">
            <c:forEach var="faq" items="${[
              {'q':'这门课程是线上还是线下？', 'a':'本课程为线上授课，含直播 + 回放，支持移动端随时学习。'},
              {'q':'适合没有基础的学员吗？', 'a':'完全可以，从零开始讲解，适合初次接触职业规划的同学。'},
              {'q':'课程是否提供录播回放？', 'a':'是的，每节课结束后提供 7 天内不限次回看。'},
              {'q':'课程支持手机学习吗？', 'a':'支持微信小程序/网页端登录，无需下载 App。'},
              {'q':'报名后多久能上课？', 'a':'报名成功后，24 小时内开通课程权限，随时开始学习。'},
              {'q':'是否有课程证书？', 'a':'部分课程提供平台认证证书，具体请咨询课程顾问。'}
            ]}">
                <div class="py-4 cursor-pointer group" onclick="toggleAnswer(this)">
                    <div class="flex justify-between items-center">
                        <p class="text-base font-medium text-dark group-hover:text-primary transition-all">${faq.q}</p>
                        <i class="fa fa-chevron-down text-sm text-gray-400 group-hover:text-primary transition-transform"></i>
                    </div>
                    <div class="answer mt-2 text-sm text-gray-600 hidden">
                            ${faq.a}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</main>


<!-- 底部信息区 -->
<jsp:include page="footer.jsp"/>


<!-- 返回顶部按钮 -->
<button id="back-to-top"
        class="fixed bottom-6 right-6 w-12 h-12 rounded-full bg-primary text-white shadow-lg flex items-center justify-center opacity-0 invisible transition-all z-50">
    <i class="fa fa-chevron-up"></i>
</button>


<!-- 在线咨询弹窗 -->
<div id="online-consult-modal" class="fixed inset-0 bg-black/50 z-50 flex items-center justify-center opacity-0 invisible transition-all duration-300">
    <div class="bg-white rounded-xl shadow-2xl w-full max-w-md mx-4 transform transition-all duration-300 scale-95 h-[80vh] flex flex-col">
        <div class="p-4 bg-primary text-white flex justify-between items-center">
            <h3 class="text-lg font-bold">在线咨询</h3>
            <button id="close-consult-modal" class="text-white hover:text-gray-200"><i class="fa fa-times text-xl"></i></button>
        </div>

        <div id="chat-messages" class="p-4 overflow-y-auto flex-1">
            <div class="flex items-start">
                <img src="image/ai/ai_avatar.png" alt="客服头像" class="w-10 h-10 rounded-full object-cover mr-3">
                <div class="bg-gray-100 rounded-lg p-3 max-w-[80%]">
                    <p class="text-gray-700">您好！我是职业规划咨询客服，很高兴为您服务。请问有什么可以帮到您的吗？</p>
                </div>
            </div>
        </div>

        <div class="p-4 border-t">
            <div class="space-y-3">
                <div class="flex gap-2">
                    <input type="text" id="chat-input" class="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary/50 focus:border-primary" placeholder="输入您的问题...">
                    <button id="send-message" class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg transition-colors"><i class="fa fa-paper-plane"></i></button>
                </div>

                <div class="space-y-2">
                    <button class="quick-reply bg-gray-100 hover:bg-gray-200 text-gray-700 px-3 py-1 rounded-full text-sm transition-colors w-full text-left">我该如何选择咨询师？</button>
                    <button class="quick-reply bg-gray-100 hover:bg-gray-200 text-gray-700 px-3 py-1 rounded-full text-sm transition-colors w-full text-left">线上咨询有效果吗？</button>
                    <button class="quick-reply bg-gray-100 hover:bg-gray-200 text-gray-700 px-3 py-1 rounded-full text-sm transition-colors w-full text-left">咨询费用是多少？</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 补充CSS样式 -->
<style>
    #online-consult-modal {
        align-items: flex-start;
        padding-top: 10vh;
    }
    #chat-messages {
        max-height: 100%;
    }
</style>


<!-- JS 脚本 -->
<script>
    // 返回顶部按钮逻辑
    const backToTopButton = document.getElementById('back-to-top');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 300) {
            backToTopButton.classList.remove('opacity-0', 'invisible');
            backToTopButton.classList.add('opacity-100', 'visible');
        } else {
            backToTopButton.classList.add('opacity-0', 'invisible');
            backToTopButton.classList.remove('opacity-100', 'visible');
        }
    });
    backToTopButton.addEventListener('click', () => {
        window.scrollTo({top: 0, behavior: 'smooth'});
    });


    document.addEventListener('DOMContentLoaded', function() {
        const onlineConsultModal = document.getElementById('online-consult-modal');
        // 选择所有带有online-consult-btn类的在线咨询按钮
        const onlineConsultBtns = document.querySelectorAll('.online-consult-btn');
        const closeConsultModalBtn = document.getElementById('close-consult-modal');
        const chatInput = document.getElementById('chat-input');
        const sendMessageBtn = document.getElementById('send-message');
        const quickReplies = document.querySelectorAll('.quick-reply');
        const chatMessages = document.getElementById('chat-messages');

        // 为每个在线咨询按钮添加点击事件
        onlineConsultBtns.forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                onlineConsultModal.classList.remove('opacity-0', 'invisible');
                onlineConsultModal.querySelector('div').classList.remove('scale-95');
                onlineConsultModal.querySelector('div').classList.add('scale-100');
                chatMessages.scrollTop = chatMessages.scrollHeight;
            });
        });

        closeConsultModalBtn.addEventListener('click', () => {
            onlineConsultModal.classList.add('opacity-0', 'invisible');
            onlineConsultModal.querySelector('div').classList.remove('scale-100');
            onlineConsultModal.querySelector('div').classList.add('scale-95');
        });

        onlineConsultModal.addEventListener('click', (e) => {
            if (e.target === onlineConsultModal) {
                onlineConsultModal.classList.add('opacity-0', 'invisible');
                onlineConsultModal.querySelector('div').classList.remove('scale-100');
                onlineConsultModal.querySelector('div').classList.add('scale-95');
            }
        });

        function sendMessage() {
            const message = chatInput.value.trim();
            if (message) {
                // 创建用户消息元素
                const userMessage = document.createElement('div');
                userMessage.className = 'flex items-start justify-end mb-4';
                // 使用textContent避免HTML注入，同时确保内容正确显示
                const messageDiv = document.createElement('div');
                messageDiv.className = 'bg-primary text-white rounded-lg p-3 max-w-[80%]';
                messageDiv.textContent = message;

                const avatarImg = document.createElement('img');
                avatarImg.src = 'image/users/defaultavatars.jpg';
                avatarImg.alt = '用户头像';
                avatarImg.className = 'w-10 h-10 rounded-full object-cover ml-3';

                userMessage.appendChild(messageDiv);
                userMessage.appendChild(avatarImg);
                chatMessages.appendChild(userMessage);

                // 强制触发DOM重绘后滚动
                chatMessages.scrollTop = chatMessages.scrollHeight;
                // 双重确保滚动（处理浏览器渲染延迟）
                setTimeout(() => {
                    chatMessages.scrollTop = chatMessages.scrollHeight;
                }, 100);

                // 模拟客服回复
                setTimeout(() => {
                    const botMessage = document.createElement('div');
                    botMessage.className = 'flex items-start mb-4';

                    const botAvatar = document.createElement('img');
                    botAvatar.src = 'image/ai/ai_avatar.png';
                    botAvatar.alt = '客服头像';
                    botAvatar.className = 'w-10 h-10 rounded-full object-cover mr-3';

                    const botMsgDiv = document.createElement('div');
                    botMsgDiv.className = 'bg-gray-100 rounded-lg p-3 max-w-[80%]';
                    botMsgDiv.textContent = '感谢您的咨询！我们的专业顾问将尽快为您解答。请问您还有其他问题吗？';

                    botMessage.appendChild(botAvatar);
                    botMessage.appendChild(botMsgDiv);
                    chatMessages.appendChild(botMessage);

                    // 客服回复后滚动
                    chatMessages.scrollTop = chatMessages.scrollHeight;
                    setTimeout(() => {
                        chatMessages.scrollTop = chatMessages.scrollHeight;
                    }, 100);
                }, 1000);

                chatInput.value = '';
            }
        }

        sendMessageBtn.addEventListener('click', sendMessage);
        chatInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });

        quickReplies.forEach(reply => {
            reply.addEventListener('click', () => {
                chatInput.value = reply.textContent;
                sendMessage();
            });
        });
    });


    // FAQ 展开与合并
    function toggleAnswer(el) {
        const answer = el.querySelector('.answer');
        const icon = el.querySelector('i');

        const isHidden = answer.classList.contains('hidden');
        document.querySelectorAll('#faq-list .answer').forEach(a => a.classList.add('hidden'));
        document.querySelectorAll('#faq-list i').forEach(i => i.classList.remove('rotate-180'));

        if (isHidden) {
            answer.classList.remove('hidden');
            icon.classList.add('rotate-180');
        }
    }
</script>

</body>
</html>
