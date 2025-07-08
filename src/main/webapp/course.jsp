<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/24
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IP创氪师 - 课程培训</title>
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
            .content-auto { content-visibility: auto; }
            .text-shadow { text-shadow: 0 2px 4px rgba(0,0,0,0.1); }
            .transition-navbar { transition: background-color 0.3s, box-shadow 0.3s, padding 0.3s; }

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
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
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
                    <c:when test="${not empty loginUser && (loginUser.roleId == 1 || loginUser.roleId == 2)}">
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
                            <a href="register.jsp" class="text-gray-700 hover:text-primary transition-colors font-medium">注册</a>
                        </c:otherwise>
                    </c:choose>

                    <a href="#" id="recommendBtn"
                       class="bg-secondary hover:bg-secondary/90 text-white px-5 py-2 rounded-full font-medium transition-all shadow-md hover:shadow-lg transform hover:-translate-y-0.5">
                        课程推荐
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<section class="pt-20 md:pt-24 bg-gradient-to-r from-primary/5 to-primary/10 py-12">
    <div class="container mx-auto px-8">
        <div class="max-w-3xl">
            <h1 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-dark mb-2">探索职业成长课程</h1>
            <p class="text-gray-500">从生涯规划到个人IP打造，全方位提升职业竞争力，找到属于你的成长路径</p>
        </div>
    </div>
</section>

<main class="container mx-auto px-8 py-12">
    <!-- 搜索框 -->
    <div class="max-w-3xl mx-auto mb-16">
        <!-- 搜索表单，提交到 /courses -->
        <form action="courses" method="get" class="max-w-3xl mx-auto mb-16">
            <div class="relative">
                <input type="text" name="keyword" id="courseSearch" placeholder="搜索课程名称、标签或介绍..."
                       class="search-input w-full px-6 py-4 rounded-full border border-gray-300 focus:ring-2 focus:ring-primary focus:border-primary transition-colors pl-12 pr-40"
                       value="${param.keyword}">

                <button type="submit" class="absolute right-4 top-1/2 -translate-y-1/2 bg-primary text-white w-10 h-10 rounded-full flex items-center justify-center hover:bg-primary/90 transition-colors">
                    <i class="fa fa-search"></i>
                </button>

                <div class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400">
                    <i class="fa fa-search"></i>
                </div>
            </div>

            <!-- 快捷标签 -->
            <div class="mt-4 flex flex-wrap gap-2">
                <c:forEach var="tag" items="${['职业生涯规划','职业咨询实战','IP个体打造','职场技能提升','留学考研规划']}">
                    <a href="courses?keyword=${tag}" class="tag-hover">${tag}</a>
                </c:forEach>
            </div>
        </form>
    </div>

    <c:choose>
        <c:when test="${not empty searchKeyword}">
            <h2 class="text-2xl font-bold text-dark mb-6">搜索结果：${searchKeyword}</h2>
            <c:if test="${empty searchResult}">
                <p class="text-gray-400 text-sm mb-6">未找到相关课程，换个关键词试试吧。</p>
            </c:if>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
                <c:forEach var="course" items="${searchResult}">
                    <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                        <div class="p-6">
                            <h3 class="text-xl font-bold text-dark mb-2">${course.name}</h3>
                            <p class="text-gray-500 mb-4">${course.intro}</p>
                            <c:if test="${not empty course.tags}">
                                <div class="flex flex-wrap gap-2 mb-6">
                                    <c:forEach var="tag" items="${fn:split(course.tags, ',')}">
                                        <span class="px-3 py-1 bg-primary/10 text-primary text-sm rounded-full">${tag}</span>
                                    </c:forEach>
                                </div>
                            </c:if>
                            <a href="courseDetail?id=${course.id}" class="inline-flex items-center text-primary font-medium hover:underline">
                                了解详情 <i class="fa fa-arrow-right ml-2"></i>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="flex items-center justify-center my-12">
                <hr class="flex-grow border-t border-gray-300">
                <span class="mx-4 text-gray-400 text-sm uppercase tracking-wider">✦ IP 创氪师 ✦</span>
                <hr class="flex-grow border-t border-gray-300">
            </div>

        </c:when>
    </c:choose>


    <h2 class="text-2xl font-bold text-dark mb-6">生涯规划师</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
        <c:forEach var="course" items="${plannerCourses}">
            <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                <div class="p-6">
                    <h3 class="text-xl font-bold text-dark mb-2">${course.name}</h3>
                    <p class="text-gray-500 mb-4">${course.intro}</p>

                    <c:if test="${not empty course.tags}">
                        <div class="flex flex-wrap gap-2 mb-6">
                            <c:forEach var="tag" items="${fn:split(course.tags, ',')}">
                                <span class="px-3 py-1 bg-primary/10 text-primary text-sm rounded-full">${tag}</span>
                            </c:forEach>
                        </div>
                    </c:if>

                    <a href="courseDetail?id=${course.id}" class="inline-flex items-center text-primary font-medium hover:underline">
                        了解详情 <i class="fa fa-arrow-right ml-2"></i>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
    <hr class="border-0 h-1 rounded-full bg-gradient-to-r from-primary/30 via-primary to-primary/30 mb-12">


    <h2 class="text-2xl font-bold text-dark mb-6">IP个体</h2>
    <!-- 切换按钮 -->
    <div class="flex justify-center mb-8 space-x-4">
        <button id="btn-campus" class="tab-btn active-tab">校园版</button>
        <button id="btn-career" class="tab-btn">职场版</button>
    </div>

    <!-- 内容区域划分 -->
    <div id="ip-edition" class="ip-section">
        <!-- 校园版内容区域 -->
        <div id="campus-section" class="tab-section content-fade">
            <h2 class="text-2xl font-semibold text-blue-700 mb-4">校园版</h2>
            <c:forEach var="entry" items="${campusCourses}">
                <h3 class="text-xl font-bold text-gray-800 mt-6 mb-4">${entry.key.name}</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
                    <c:forEach var="course" items="${entry.value}">
                        <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                            <div class="p-6">
                                <h3 class="text-xl font-bold text-dark mb-2">${course.name}</h3>
                                <p class="text-gray-500 mb-4">${course.intro}</p>

                                <c:if test="${not empty course.tags}">
                                    <div class="flex flex-wrap gap-2 mb-6">
                                        <c:forEach var="tag" items="${fn:split(course.tags, ',')}">
                                            <span class="px-3 py-1 bg-primary/10 text-primary text-sm rounded-full">${tag}</span>
                                        </c:forEach>
                                    </div>
                                </c:if>

                                <a href="courseDetail?id=${course.id}"
                                   class="inline-flex items-center text-primary font-medium hover:underline">
                                    了解详情 <i class="fa fa-arrow-right ml-2"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>

        <!-- 职场版内容区域 -->
        <div id="career-section" class="tab-section content-fade hidden">
            <h2 class="text-2xl font-semibold text-blue-700 mb-4">职场版</h2>
            <c:forEach var="entry" items="${careerCourses}">
                <h3 class="text-xl font-bold text-gray-800 mt-6 mb-4">${entry.key.name}</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-12">
                    <c:forEach var="course" items="${entry.value}">
                        <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                            <div class="p-6">
                                <h3 class="text-xl font-bold text-dark mb-2">${course.name}</h3>
                                <p class="text-gray-500 mb-4">${course.intro}</p>

                                <c:if test="${not empty course.tags}">
                                    <div class="flex flex-wrap gap-2 mb-6">
                                        <c:forEach var="tag" items="${fn:split(course.tags, ',')}">
                                            <span class="px-3 py-1 bg-primary/10 text-primary text-sm rounded-full">${tag}</span>
                                        </c:forEach>
                                    </div>
                                </c:if>

                                <a href="courseDetail?id=${course.id}"
                                   class="inline-flex items-center text-primary font-medium hover:underline">
                                    了解详情 <i class="fa fa-arrow-right ml-2"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>
    </div>

</main>

<!-- 底部信息区 -->
<jsp:include page="footer.jsp"/>


<!-- 返回顶部按钮 -->
<button id="back-to-top" class="fixed bottom-6 right-6 w-12 h-12 rounded-full bg-primary text-white shadow-lg flex items-center justify-center opacity-0 invisible transition-all z-50">
    <i class="fa fa-chevron-up"></i>
</button>

<!-- 课程推荐模态框 -->
<div id="recommendModal" class="fixed inset-0 z-50 hidden bg-black/50 backdrop-blur-sm flex items-center justify-center">
    <div class="bg-white w-full max-w-xl rounded-2xl shadow-lg p-8 relative">
        <button id="closeModal" class="absolute top-4 right-4 text-gray-500 hover:text-primary text-xl">
            &times;
        </button>

        <h2 class="text-2xl font-bold text-dark mb-6">课程推荐问答</h2>

        <form id="recommendForm" class="space-y-6">
            <!-- 问题 1 -->
            <div>
                <p class="font-semibold mb-2">1. 你的当前状态是？</p>
                <label class="block"><input type="radio" name="q1" value="学生" class="mr-2">学生</label>
                <label class="block"><input type="radio" name="q1" value="职场人" class="mr-2">职场人</label>
                <label class="block"><input type="radio" name="q1" value="其他" class="mr-2">其他</label>
            </div>

            <!-- 问题 2 -->
            <div>
                <p class="font-semibold mb-2">2. 你更关注哪类能力提升？</p>
                <label class="block"><input type="radio" name="q2" value="表达沟通" class="mr-2">表达沟通</label>
                <label class="block"><input type="radio" name="q2" value="职业规划" class="mr-2">职业规划</label>
                <label class="block"><input type="radio" name="q2" value="考试/认证" class="mr-2">考试/认证</label>
            </div>

            <!-- 问题 3 -->
            <div>
                <p class="font-semibold mb-2">3. 你偏好哪种学习方式？</p>
                <label class="block"><input type="radio" name="q3" value="直播互动" class="mr-2">直播互动</label>
                <label class="block"><input type="radio" name="q3" value="自主录播" class="mr-2">自主录播</label>
                <label class="block"><input type="radio" name="q3" value="线下培训" class="mr-2">线下培训</label>
            </div>

            <!-- 提交按钮 -->
            <button type="submit"
                    class="mt-6 bg-primary hover:bg-primary/90 text-white px-6 py-2 rounded-full font-semibold transition">
                查看推荐结果
            </button>
        </form>

        <!-- 推荐结果区域：初始隐藏 -->
        <div id="recommendResult" class="hidden space-y-4">
            <h3 class="text-xl font-bold text-primary">🎉 为你推荐的课程</h3>
            <p id="resultText" class="text-gray-700"></p>

            <div class="bg-white border rounded-lg p-4 shadow space-y-2">
                <h4 class="text-lg font-semibold text-dark">职业生涯规划基石班</h4>
                <p class="text-sm text-gray-600">系统建立生涯规划基础认知与工具方法。</p>
                <div class="flex gap-4 pt-2">
                    <a href="courseDetail?id=1"
                       class="bg-primary text-white px-4 py-2 rounded-full text-sm font-medium hover:bg-primary/90 transition">
                        查看详情
                    </a>
                    <a href="#consult"
                       class="bg-secondary text-white px-4 py-2 rounded-full text-sm font-medium hover:bg-secondary/90 transition">
                        马上报名
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Toast -->
<div id="toast"
     class="fixed bottom-6 right-6 bg-secondary text-white px-6 py-3 rounded-lg shadow-lg opacity-0 pointer-events-none transition-opacity duration-500 z-50">
    推荐完成！我们已为你匹配了适合的课程～
</div>



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
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });


    // 打开模态框
    document.getElementById("recommendBtn").addEventListener("click", function (e) {
        e.preventDefault();
        document.getElementById("recommendModal").classList.remove("hidden");
        // 重置状态（如果之前看过一次）
        document.getElementById("recommendForm").classList.remove("hidden");
        document.getElementById("recommendResult").classList.add("hidden");
    });

    // 关闭模态框
    document.getElementById("closeModal").addEventListener("click", function () {
        document.getElementById("recommendModal").classList.add("hidden");
    });

    // Toast 封装函数
    function showToast(message) {
        const toast = document.getElementById("toast");
        toast.innerText = message;
        toast.classList.remove("opacity-0", "pointer-events-none");
        toast.classList.add("opacity-100");

        setTimeout(() => {
            toast.classList.add("opacity-0", "pointer-events-none");
            toast.classList.remove("opacity-100");
        }, 3000);
    }

    // 表单提交处理逻辑
    document.getElementById("recommendForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const q1 = document.querySelector('input[name="q1"]:checked');
        const q2 = document.querySelector('input[name="q2"]:checked');
        const q3 = document.querySelector('input[name="q3"]:checked');

        if (!q1 || !q2 || !q3) {
            showToast("请完成所有问题哦！");
            return;
        }

        // 显示推荐内容区域
        document.getElementById("recommendForm").classList.add("hidden");
        document.getElementById("recommendResult").classList.remove("hidden");

        // 设置推荐文字
        const text = `🎯 适合你这样的 <strong>${q1.value}</strong><br>
                  🧠 建议关注 <strong>${q2.value}</strong> 课程<br>
                  💻 推荐学习方式：<strong>${q3.value}</strong>`;
        document.getElementById("resultText").innerHTML = text;

        showToast("推荐完成！为你匹配了合适的课程～");
    });


    // 校园版与职场版切换逻辑
    const campusButton = document.getElementById("btn-campus");
    const careerButton = document.getElementById("btn-career");
    const campusSection = document.getElementById("campus-section");
    const careerSection = document.getElementById("career-section");

    campusButton.addEventListener("click", function () {
        // 显示校园版内容，隐藏职场版内容
        campusSection.classList.remove("hidden");
        careerSection.classList.add("hidden");

        // 更新按钮状态
        this.classList.add("active-tab");
        careerButton.classList.remove("active-tab");

        // 滚动到内容区域（可选）
        campusSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });

    careerButton.addEventListener("click", function () {
        // 显示职场版内容，隐藏校园版内容
        careerSection.classList.remove("hidden");
        campusSection.classList.add("hidden");

        // 更新按钮状态
        this.classList.add("active-tab");
        campusButton.classList.remove("active-tab");

        // 滚动到内容区域（可选）
        careerSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
</script>
</body>
</html>