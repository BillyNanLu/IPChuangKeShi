<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IP创氪师-专业职业生涯规划咨询与培训平台</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">

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
                text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .transition-navbar {
                transition: background-color 0.3s, box-shadow 0.3s, padding 0.3s;
            }
            .card-hover {
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .card-hover:hover {
                transform: translateY(-5px);
            }
            .animate-number {
                animation: number-grow 2s ease-out forwards;
                opacity: 0;
            }
            @keyframes number-grow {
                0% { opacity: 0; transform: scale(0.8); }
                100% { opacity: 1; transform: scale(1); }
            }
            .bg-gradient-hero {
                background: linear-gradient(to right, rgba(22, 93, 255, 0.9), rgba(22, 93, 255, 0.7)), url('./image/home/bigbackground.jpg') center/cover no-repeat;
            }
        }
    </style>
</head>

<body class="font-inter text-dark antialiased w-1200 mx-auto">

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
                <a href="home" class="text-gray-700 hover:text-primary transition-colors font-medium border-b-2 border-primary">首页</a>
                <a href="courses" class="text-gray-700 hover:text-primary transition-colors font-medium">课程培训</a>
                <a href="consult.jsp" class="text-gray-700 hover:text-primary transition-colors font-medium">一对一职业规划咨询</a>
                <a href="chat" class="text-gray-700 hover:text-primary transition-colors font-medium">AI职业规划咨询</a>
                <c:choose>
                    <c:when test="${loginUser.roleId == 1 || loginUser.roleId == 2}">
                        <a href="adminDashboard" class="text-gray-700 hover:text-primary transition-colors font-medium">工作台</a>
                    </c:when>
                    <c:otherwise>
                        <a href="personCenter" class="text-gray-700 hover:text-primary transition-colors font-medium">个人中心</a>
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

                    <a href="#consult"
                       class="bg-secondary hover:bg-secondary/90 text-white px-5 py-2 rounded-full font-medium transition-all shadow-md hover:shadow-lg transform hover:-translate-y-0.5">
                        立即咨询
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>


<section class="pt-24 bg-gradient-hero min-h-screen flex items-center">
    <div class="container mx-auto px-8 relative z-10">
        <div class="max-w-3xl">
            <h2 class="text-[clamp(2rem,5vw,2.8rem)] font-bold text-white leading-tight text-shadow mb-4">
                打破职业迷茫，设计属于你的人生路径
            </h2>
            <p class="text-[clamp(1rem,2vw,1.25rem)] text-white/90 mb-8 max-w-2xl">
                从0基础到职业规划专家，新精英陪你解锁生涯无限可能，让每一次选择都成为未来的基石
            </p>

            <div class="flex flex-row gap-4 mb-10">
                <a href="#course-free" class="bg-white text-primary hover:bg-gray-100 px-8 py-3 rounded-full font-medium transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-1 text-center">
                    免费领取3天阅读写作特训营
                </a>
                <a href="#consult" class="bg-secondary hover:bg-secondary/90 text-white px-8 py-3 rounded-full font-medium transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-1 text-center">
                    预约1对1职业咨询
                </a>
            </div>
        </div>
    </div>
</section>

<!-- 核心服务模块 - 固定3列布局 -->
<section id="services" class="py-16 bg-light">
    <div class="container mx-auto px-8">
        <div class="text-center mb-12">
            <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-dark mb-4">我们的核心服务</h2>
            <p class="text-gray-500 max-w-2xl mx-auto">从职业规划到个人成长，全方位助力你的职业生涯发展，让每一步选择都充满信心</p>
        </div>

        <div class="grid grid-cols-3 gap-8">
            <c:forEach var="course" items="${plannerCourses}">
                <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                    <div class="p-6">
                        <h3 class="text-xl font-bold text-dark mb-2">${course.name}</h3>
                        <p class="text-gray-500 mb-4">${course.intro}</p>
                        <div class="flex flex-wrap gap-2 mb-6">
                            <c:forEach var="tag" items="${fn:split(course.tags, ',')}">
                                <span class="px-3 py-1 bg-primary/10 text-primary text-sm rounded-full">${tag}</span>
                            </c:forEach>
                        </div>
                        <a href="courseDetail?id=${course.id}" class="inline-flex items-center text-primary font-medium hover:underline">
                            了解详情 <i class="fa fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 特色服务 - 固定2列布局 -->
        <div class="grid grid-cols-2 gap-8 mt-16">
            <div class="flex items-start space-x-6">
                <div class="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center text-primary flex-shrink-0">
                    <i class="fa fa-compass text-xl"></i>
                </div>
                <div>
                    <h3 class="text-xl font-bold text-dark mb-2">职业辅导「选对」平台</h3>
                    <p class="text-gray-500">帮助职场新人摆脱选择迷茫，导师1对1分析职业路径，提供科学的职业选择建议</p>
                </div>
            </div>

            <div class="flex items-start space-x-6">
                <div class="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center text-primary flex-shrink-0">
                    <i class="fa fa-microphone text-xl"></i>
                </div>
                <div>
                    <h3 class="text-xl font-bold text-dark mb-2">超级个体IP营</h3>
                    <p class="text-gray-500">打造个人品牌，从职场人到自由咨询师的进阶之路，掌握个人IP打造核心技能</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 师资与实力展示区 -->
<section id="teachers" class="py-16 bg-white">
    <div class="container mx-auto px-8">
        <div class="text-center mb-12">
            <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-dark mb-4">专业师资团队</h2>
            <p class="text-gray-500 max-w-2xl mx-auto">我们拥有行业顶尖的师资力量，每位讲师都具备丰富的实战经验和专业知识</p>
        </div>

        <!-- 明星讲师 -->
        <div class="grid grid-cols-3 gap-8">
            <c:forEach var="teacher" items="${departmentTeachers}">
                <div class="bg-light rounded-xl overflow-hidden card-hover">
                    <img src="${pageContext.request.contextPath}${teacher.imgage}" alt="${teacher.name}" class="w-full h-64 object-cover">
                    <div class="p-6">
                        <h3 class="text-xl font-bold text-dark mb-1">${teacher.name}</h3>
                        <p class="text-primary mb-3">${teacher.expertise}</p>
                        <p class="text-gray-500 mb-4">${teacher.profile}</p>
                        <div class="flex space-x-3">
                            <a class="inline-flex items-center text-primary font-medium hover:underline">
                                了解详情 <i class="fa fa-arrow-right ml-2"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 企业实力数据 - 固定4列布局 -->
        <div class="mt-20 grid grid-cols-4 gap-8 text-center">
            <div class="p-6">
                <div class="text-4xl md:text-5xl font-bold text-primary mb-2 animate-number" data-target="128">0</div>
                <p class="text-gray-500">专业教师</p>
            </div>
            <div class="p-6">
                <div class="text-4xl md:text-5xl font-bold text-primary mb-2 animate-number" data-target="100000">0</div>
                <p class="text-gray-500">服务学员</p>
            </div>
            <div class="p-6">
                <div class="text-4xl md:text-5xl font-bold text-primary mb-2 animate-number" data-target="145">0</div>
                <p class="text-gray-500">遍及城市</p>
            </div>
            <div class="p-6">
                <div class="text-4xl md:text-5xl font-bold text-primary mb-2 animate-number" data-target="85">0</div>
                <p class="text-gray-500">客户满意度(%)</p>
            </div>
        </div>
    </div>
</section>

<!-- 社会证明模块 -->
<section id="stories" class="py-16 bg-light">
    <div class="container mx-auto px-8">
        <div class="text-center mb-12">
            <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-dark mb-4">学员成功故事</h2>
            <p class="text-gray-500 max-w-2xl mx-auto">听听他们如何通过新精英的帮助，实现职业转型和个人成长的故事</p>
        </div>

        <!-- 学员故事 - 固定2列布局 -->
        <div class="grid grid-cols-2 gap-8">
            <!-- 故事1 -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                <div class="flex flex-row">
                    <div class="w-1/3">
                        <img src="https://picsum.photos/id/1062/600/800" alt="CiCi" class="w-full h-full object-cover">
                    </div>
                    <div class="p-6 w-2/3">
                        <div class="flex items-center mb-4">
                            <img src="https://picsum.photos/id/1027/60/60" alt="CiCi" class="w-12 h-12 rounded-full object-cover">
                            <div class="ml-3">
                                <h3 class="text-lg font-bold text-dark">CiCi</h3>
                                <p class="text-gray-500 text-sm">大学教师</p>
                            </div>
                        </div>
                        <h4 class="text-xl font-bold text-dark mb-3">"在隧道里看到光"</h4>
                        <p class="text-gray-500 mb-4">通过咨询破开内心纠结，清晰职业目标，从迷茫的大学教师到自信的职业规划师，找到了真正热爱的事业。</p>
                        <a href="#story-details" class="inline-flex items-center text-primary font-medium hover:underline">
                            阅读完整故事 <i class="fa fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- 故事2 -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                <div class="flex flex-row">
                    <div class="w-1/3">
                        <img src="https://picsum.photos/id/1074/600/800" alt="张心悦" class="w-full h-full object-cover">
                    </div>
                    <div class="p-6 w-2/3">
                        <div class="flex items-center mb-4">
                            <img src="https://picsum.photos/id/1066/60/60" alt="张心悦" class="w-12 h-12 rounded-full object-cover">
                            <div class="ml-3">
                                <h3 class="text-lg font-bold text-dark">张心悦</h3>
                                <p class="text-gray-500 text-sm">情商专家</p>
                            </div>
                        </div>
                        <h4 class="text-xl font-bold text-dark mb-3">"从前台到自由咨询师的逆袭"</h4>
                        <p class="text-gray-500 mb-4">摆脱传统职场路径，通过系统学习和实践，从普通前台转变为专业的情商咨询师，实现了职业的华丽转身。</p>
                        <a href="#story-details" class="inline-flex items-center text-primary font-medium hover:underline">
                            阅读完整故事 <i class="fa fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 故事3 - 单独一行 -->
        <div class="mt-8 bg-white rounded-xl shadow-md overflow-hidden card-hover">
            <div class="flex flex-col md:flex-row gap-6">
                <div class="w-full md:w-1/3 max-h-[400px] overflow-hidden rounded-xl">
                    <img src="https://picsum.photos/id/1011/600/800" alt="孙天一" class="w-full h-full object-cover">
                </div>
                <div class="p-6 md:w-2/3 flex flex-col justify-between">
                    <div>
                        <div class="flex items-center mb-4">
                            <img src="https://picsum.photos/id/1025/60/60" alt="孙天一" class="w-12 h-12 rounded-full object-cover border-2 border-primary shadow-sm">
                            <div class="ml-3">
                                <h3 class="text-lg font-bold text-dark">孙天一</h3>
                                <p class="text-gray-500 text-sm">90后自由职业者</p>
                            </div>
                        </div>
                        <h4 class="text-xl font-bold text-dark mb-3">"三天找到梦想入口"</h4>
                        <p class="text-gray-500 mb-4">突破专业与工作的迷茫，通过三天的密集咨询和指导，发现了自己真正的职业兴趣，开启了新的职业篇章。</p>
                        <div class="flex flex-wrap gap-3 mb-4">
                            <span class="bg-primary/10 text-primary px-3 py-1 rounded-full text-sm font-semibold">3天密集辅导</span>
                            <span class="bg-secondary/10 text-secondary px-3 py-1 rounded-full text-sm font-semibold">100% 满意率</span>
                            <span class="bg-primary/10 text-primary px-3 py-1 rounded-full text-sm font-semibold">转型成功</span>
                        </div>
                        <p class="italic text-gray-400 mb-6">“这段经历彻底改变了我的职业观和未来规划。”</p>
                    </div>
                    <a href="#story-details" class="inline-flex items-center text-primary font-medium hover:underline self-start">
                        阅读完整故事 <i class="fa fa-arrow-right ml-2"></i>
                    </a>
                </div>
            </div>
        </div>


        <!-- 媒体动态 - 固定3列布局 -->
        <div class="mt-20">
            <h3 class="text-2xl font-bold text-dark mb-8 text-center">最新动态</h3>
            <div class="grid grid-cols-3 gap-8">
                <!-- 动态1 -->
                <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                    <div class="p-6">
                        <div class="flex items-start space-x-4 mb-4">
                            <div class="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary flex-shrink-0">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <div>
                                <h4 class="text-lg font-bold text-dark">斯坦福人生设计创始人见面会</h4>
                                <p class="text-gray-500 text-sm mt-1">国际大咖面对面，揭秘人生设计方法论</p>
                            </div>
                        </div>
                        <p class="text-gray-500 mb-4">6月28日，我们邀请到斯坦福大学人生设计项目创始人Bill Burnett教授，与大家分享人生设计的核心理念和实践方法...</p>
                        <a href="#news-details" class="inline-flex items-center text-primary font-medium hover:underline">
                            查看详情 <i class="fa fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>

                <!-- 动态2 -->
                <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                    <div class="p-6">
                        <div class="flex items-start space-x-4 mb-4">
                            <div class="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary flex-shrink-0">
                                <i class="fa fa-coffee"></i>
                            </div>
                            <div>
                                <h4 class="text-lg font-bold text-dark">生涯咖啡日第2期</h4>
                                <p class="text-gray-500 text-sm mt-1">全天开放公益咨询，助力30位学生冲破春招困境</p>
                            </div>
                        </div>
                        <p class="text-gray-500 mb-4">5月20日，新精英生涯咖啡日第2期成功举办，30位面临春招的大学生通过1对1咨询，明确了职业方向，提升了求职竞争力...</p>
                        <a href="#news-details" class="inline-flex items-center text-primary font-medium hover:underline">
                            查看详情 <i class="fa fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>

                <!-- 动态3 -->
                <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                    <div class="p-6">
                        <div class="flex items-start space-x-4 mb-4">
                            <div class="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary flex-shrink-0">
                                <i class="fa fa-gift"></i>
                            </div>
                            <div>
                                <h4 class="text-lg font-bold text-dark">618十二重礼包</h4>
                                <p class="text-gray-500 text-sm mt-1">年中特惠，为未来发展投资最高省800元</p>
                            </div>
                        </div>
                        <p class="text-gray-500 mb-4">618年中促销活动火热进行中，报名任意课程即可享受十二重福利，包括免费咨询、学习资料、工具包等，最高可省800元...</p>
                        <a href="#promotion" class="inline-flex items-center text-primary font-medium hover:underline">
                            查看详情 <i class="fa fa-arrow-right ml-2"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 咨询预约模块 -->
<section id="consult" class="py-16 bg-primary">
    <div class="container mx-auto px-8">
        <div class="max-w-3xl mx-auto text-center text-white">
            <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold mb-4">还在为职业选择感到迷茫？</h2>
            <p class="text-white/80 mb-8">我们的专业咨询师团队随时准备为你提供帮助，让我们一起规划你的职业未来</p>

            <c:if test="${not empty error}">
                <div class="text-red-500 text-sm mb-4 text-center">${error}</div>
            </c:if>

            <!-- 成功提示 -->
            <c:if test="${param.success eq 'true'}">
                <div class="bg-green-100 border border-green-400 text-green-800 px-4 py-3 rounded mb-6" role="alert">
                    <strong class="font-bold">提交成功！</strong>
                    <span class="block sm:inline">我们将在24小时内与你联系。</span>
                </div>
            </c:if>

            <form class="bg-white/10 backdrop-blur-sm p-8 rounded-xl" action="home" method="post">
                <div class="grid grid-cols-2 gap-6 mb-6">
                    <div>
                        <label for="name" class="block text-white/80 mb-2 text-sm">姓名</label>
                        <input type="text" name="appoint_name" id="name" class="w-full px-4 py-3 rounded-lg bg-white/20 border border-white/30 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-white/50" placeholder="请输入你的姓名">
                    </div>
                    <div>
                        <label for="phone" class="block text-white/80 mb-2 text-sm">电话</label>
                        <input type="tel" name="appoint_phone" id="phone" class="w-full px-4 py-3 rounded-lg bg-white/20 border border-white/30 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-white/50" placeholder="请输入你的电话">
                    </div>
                </div>

                <div class="mb-6">
                    <label for="problem" class="block text-white/80 mb-2 text-sm">你的职业困惑</label>
                    <textarea name="appoint_description" id="problem" rows="3" class="w-full px-4 py-3 rounded-lg bg-white/20 border border-white/30 text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-white/50" placeholder="请简要描述你的职业困惑..."></textarea>
                </div>

                <button type="submit" class="w-full bg-white text-primary hover:bg-gray-100 px-6 py-3 rounded-lg font-medium transition-colors">
                    提交咨询申请
                </button>
                <p class="text-white/60 text-sm mt-4">我们将在24小时内与你联系，保护你的隐私信息</p>
            </form>
        </div>
    </div>
</section>

<!-- 底部信息区 -->
<jsp:include page="footer.jsp"/>

<!-- 返回顶部按钮 -->
<button id="back-to-top" class="fixed bottom-6 right-6 w-12 h-12 rounded-full bg-primary text-white shadow-lg flex items-center justify-center opacity-0 invisible transition-all z-50">
    <i class="fa fa-chevron-up"></i>
</button>

<!-- JavaScript -->
<script src="js/home.js"></script>
</body>
</html>