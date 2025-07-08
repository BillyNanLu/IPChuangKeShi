<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/23
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>IP创氪师-注册</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/register.css">
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
</head>

<body class="font-inter text-dark antialiased bg-light">
<!-- 顶部导航 -->
<header class="bg-white shadow-sm">
    <div class="container mx-auto px-8">
        <div class="flex justify-between items-center h-16">
            <!-- 品牌区 -->
            <div class="flex items-center">
                <a href="#" class="flex items-center space-x-2">
                    <div class="w-10 h-10 rounded-lg bg-primary flex items-center justify-center text-white">
                        <i class="fa fa-rocket text-xl"></i>
                    </div>
                    <div>
                        <h1 class="text-lg font-bold text-primary">IP创氪师</h1>
                        <p class="text-xs text-gray-500">成长，长成自己的样子</p>
                    </div>
                </a>
            </div>

            <!-- 右侧导航 -->
            <nav class="flex items-center space-x-6">
                <a href="#" class="text-gray-700 hover:text-primary transition-colors">首页</a>
                <a href="courses" class="text-gray-700 hover:text-primary transition-colors">课程中心</a>
                <a href="#" class="text-gray-700 hover:text-primary transition-colors">关于我们</a>
                <a href="#" class="text-primary font-medium">帮助中心</a>
            </nav>
        </div>
    </div>
</header>

<!-- 主内容区 -->
<main class="container mx-auto px-8 py-16">
    <div class="max-w-4xl mx-auto">
        <div class="flex flex-row">
            <!-- 左侧品牌介绍 -->
            <div class="w-1/2 bg-gradient-hero rounded-l-xl p-10 text-white">
                <div class="max-w-md">
                    <h2 class="text-3xl font-bold mb-6">加入IP创氪师</h2>
                    <p class="text-white/90 mb-8">
                        注册成为IP创氪师会员，开启你的职业成长之旅。
                        我们将为你提供专业的职业规划指导和丰富的学习资源。
                    </p>

                    <div class="space-y-6 mb-8">
                        <div class="flex items-start space-x-4">
                            <div class="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center flex-shrink-0">
                                <i class="fa fa-certificate text-xl"></i>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold mb-1">专业认证</h3>
                                <p class="text-white/80">获得行业认可的职业规划师认证，提升职场竞争力</p>
                            </div>
                        </div>

                        <div class="flex items-start space-x-4">
                            <div class="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center flex-shrink-0">
                                <i class="fa fa-book text-xl"></i>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold mb-1">丰富课程</h3>
                                <p class="text-white/80">从基础到进阶，全方位提升你的职业规划能力</p>
                            </div>
                        </div>

                        <div class="flex items-start space-x-4">
                            <div class="w-12 h-12 rounded-full bg-white/20 flex items-center justify-center flex-shrink-0">
                                <i class="fa fa-comments text-xl"></i>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold mb-1">社区交流</h3>
                                <p class="text-white/80">加入专业社区，与同行交流经验，共同成长</p>
                            </div>
                        </div>
                    </div>

                    <div class="flex space-x-4">
                        <a href="#"
                           class="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center hover:bg-white/30 transition-colors">
                            <i class="fa fa-weibo"></i>
                        </a>
                        <a href="#"
                           class="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center hover:bg-white/30 transition-colors">
                            <i class="fa fa-wechat"></i>
                        </a>
                        <a href="#"
                           class="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center hover:bg-white/30 transition-colors">
                            <i class="fa fa-linkedin"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- 右侧注册表单 -->
            <div class="w-1/2 bg-white rounded-r-xl shadow-lg p-10">
                <h2 class="text-2xl font-bold text-dark mb-6">创建新账号</h2>

                <c:if test="${not empty error}">
                    <div class="text-red-500 text-sm mb-4 text-center">${error}</div>
                </c:if>

                <form id="registerForm" class="space-y-6" action="register" method="post" enctype="multipart/form-data">
                    <!-- 头像上传 -->
                    <div class="text-center mb-6">
                        <div class="avatar-upload">
                            <div class="avatar-preview" id="avatarPreview">
                                <img src="image/users/defaultavatars.jpg" alt="默认头像" id="avatarImage">
                            </div>
                            <div class="avatar-edit">
                                <i class="fa fa-pencil"></i>
                                <input type="file" id="avatarUpload" name="avatar" accept="image/*">
                            </div>
                        </div>
                        <p class="text-gray-500 text-sm mt-2">点击修改头像</p>
                    </div>

                    <!-- 用户名 -->
                    <div>
                        <label for="username" class="block text-gray-700 mb-2">用户名</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <i class="fa fa-user text-gray-400"></i>
                            </div>
                            <input type="text" id="username" name="username"
                                   class="w-full pl-10 pr-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary focus:border-primary transition-colors"
                                   placeholder="请输入用户名">
                        </div>
                        <p id="usernameError" class="text-red-500 text-sm mt-1 hidden">请输入用户名</p>
                    </div>

                    <!-- 性别选择 -->
                    <div>
                        <label class="block text-gray-700 mb-2">性别</label>
                        <div class="flex space-x-4">
                            <div class="flex items-center">
                                <input type="radio" id="male" name="gender" value="male" checked
                                       class="w-4 h-4 text-primary focus:ring-primary border-gray-300">
                                <label for="male" class="ml-2 text-gray-700">男</label>
                            </div>
                            <div class="flex items-center">
                                <input type="radio" id="female" name="gender" value="female"
                                       class="w-4 h-4 text-primary focus:ring-primary border-gray-300">
                                <label for="female" class="ml-2 text-gray-700">女</label>
                            </div>
                        </div>
                    </div>

                    <!-- 手机号 -->
                    <div>
                        <label for="phone" class="block text-gray-700 mb-2">手机号</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <i class="fa fa-phone text-gray-400"></i>
                            </div>
                            <input type="tel" id="phone" name="phone"
                                   class="w-full pl-10 pr-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary focus:border-primary transition-colors"
                                   placeholder="请输入手机号">
                        </div>
                        <p id="phoneError" class="text-red-500 text-sm mt-1 hidden">请输入正确的手机号</p>
                    </div>

                    <!-- 密码 -->
                    <div>
                        <label for="password" class="block text-gray-700 mb-2">密码</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <i class="fa fa-lock text-gray-400"></i>
                            </div>
                            <input type="password" id="password" name="password"
                                   class="w-full pl-10 pr-12 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary focus:border-primary transition-colors"
                                   placeholder="请输入密码">
                            <button type="button"
                                    class="togglePassword absolute inset-y-0 right-0 flex items-center pr-3 text-gray-400 hover:text-gray-600">
                                <i class="fa fa-eye-slash"></i>
                            </button>
                        </div>
                        <p id="passwordError" class="text-red-500 text-sm mt-1 hidden">
                            密码长度至少8位，包含字母和数字</p>
                    </div>

                    <!-- 确认密码 -->
                    <div>
                        <label for="confirmPassword" class="block text-gray-700 mb-2">确认密码</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <i class="fa fa-lock text-gray-400"></i>
                            </div>
                            <input type="password" id="confirmPassword" name="confirmPassword"
                                   class="w-full pl-10 pr-12 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary focus:border-primary transition-colors"
                                   placeholder="请再次输入密码">
                            <button type="button"
                                    class="togglePassword absolute inset-y-0 right-0 flex items-center pr-3 text-gray-400 hover:text-gray-600">
                                <i class="fa fa-eye-slash"></i>
                            </button>
                        </div>
                        <p id="confirmPasswordError" class="text-red-500 text-sm mt-1 hidden">两次输入的密码不一致</p>
                    </div>

                    <!-- 邮箱 -->
                    <div>
                        <label for="email" class="block text-gray-700 mb-2">邮箱（选填）</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <i class="fa fa-envelope text-gray-400"></i>
                            </div>
                            <input type="email" id="email" name="email"
                                   class="w-full pl-10 pr-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-primary focus:border-primary transition-colors"
                                   placeholder="请输入邮箱（选填）">
                        </div>
                    </div>

                    <!-- 身份选择 -->
                    <div>
                        <label class="block text-gray-700 mb-2">您的身份</label>
                        <div class="flex space-x-4">
                            <div class="flex items-center">
                                <input type="radio" id="professional" name="identity" value="professional" checked
                                       class="w-4 h-4 text-primary focus:ring-primary border-gray-300">
                                <label for="professional" class="ml-2 text-gray-700">职场人</label>
                            </div>
                            <div class="flex items-center">
                                <input type="radio" id="student" name="identity" value="student"
                                       class="w-4 h-4 text-primary focus:ring-primary border-gray-300">
                                <label for="student" class="ml-2 text-gray-700">学生</label>
                            </div>
                        </div>
                    </div>

                    <!-- 同意条款 -->
                    <div class="flex items-start">
                        <div class="flex items-center h-5">
                            <input id="terms" name="terms" type="checkbox"
                                   class="w-4 h-4 text-primary focus:ring-primary border-gray-300 rounded">
                        </div>
                        <div class="ml-3 text-sm">
                            <label for="terms" class="text-gray-500">我已阅读并同意<a href="#"
                                                                                      class="text-primary hover:underline">《用户服务协议》</a>和<a
                                    href="#" class="text-primary hover:underline">《隐私政策》</a></label>
                        </div>
                    </div>
                    <p id="termsError" class="text-red-500 text-sm mt-1 hidden">请同意用户服务协议和隐私政策</p>

                    <!-- 注册按钮 -->
                    <button type="submit"
                            class="w-full bg-primary text-white hover:bg-primary/90 px-6 py-3 rounded-lg font-medium transition-colors shadow-md hover:shadow-lg">
                        注册账号
                    </button>

                    <!-- 已有账号 -->
                    <div class="text-center mt-4">
                        <span class="text-gray-500">已有账号？</span>
                        <a href="login.jsp" class="text-primary font-medium hover:underline">立即登录</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<!-- 页脚 -->
<footer class="bg-dark text-white py-12 mt-16">
    <div class="container mx-auto px-8">
        <div class="flex justify-between items-center">
            <div class="flex items-center space-x-2">
                <div class="w-10 h-10 rounded-lg bg-primary flex items-center justify-center text-white">
                    <i class="fa fa-rocket text-xl"></i>
                </div>
                <div>
                    <h3 class="text-lg font-bold">IP创氪师</h3>
                    <p class="text-gray-400 text-sm">成长，长成自己的样子</p>
                </div>
            </div>

            <div class="flex space-x-6">
                <a href="#" class="text-gray-400 hover:text-white transition-colors">关于我们</a>
                <a href="#" class="text-gray-400 hover:text-white transition-colors">联系我们</a>
                <a href="#" class="text-gray-400 hover:text-white transition-colors">隐私政策</a>
                <a href="#" class="text-gray-400 hover:text-white transition-colors">服务条款</a>
            </div>
        </div>

        <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-500 text-sm">
            <p>© <%= new java.util.Date().getYear() + 1900 %> IP创氪师 版权所有</p>
        </div>
    </div>
</footer>

<!-- JavaScript -->
<script src="js/register.js"></script>
</body>
</html>