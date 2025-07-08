<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/23
  Time: 14:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>IP创氪师-登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Tailwind 引入 -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">

    <!-- 自定义样式 -->
    <link rel="stylesheet" href="css/login.css">
</head>

<body class="login-body">

<!-- 顶部导航 -->
<header class="login-header">
    <div class="login-header-inner">
        <div class="login-brand">
            <div class="login-brand-icon">
                <i class="fa fa-rocket text-xl"></i>
            </div>
            <div>
                <h1 class="login-brand-name">IP创氪师</h1>
                <p class="login-brand-sub">成长，长成自己的样子</p>
            </div>
        </div>

        <nav class="login-nav">
            <a href="home">首页</a>
            <a href="courses">课程中心</a>
            <a href="#">关于我们</a>
            <a href="#" class="active">帮助中心</a>
        </nav>
    </div>
</header>

<!-- 主内容区 -->
<main class="login-main">
    <div class="login-wrapper">
        <!-- 左侧介绍 -->
        <div class="login-left">
            <h2 class="login-left-title">欢迎回到IP创氪师</h2>
            <p class="login-left-desc">
                我们致力于帮助每一位学员找到自己的职业方向，实现职业理想。通过科学的职业规划方法，让你的每一次选择都更加自信。</p>

            <div class="login-features">
                <div class="login-feature">
                    <div class="login-feature-icon">
                        <i class="fa fa-graduation-cap text-xl"></i>
                    </div>
                    <div>
                        <h3 class="login-feature-title">专业课程体系</h3>
                        <p class="login-feature-desc">从基础到进阶，全方位提升你的职业规划能力</p>
                    </div>
                </div>

                <div class="login-feature">
                    <div class="login-feature-icon">
                        <i class="fa fa-users text-xl"></i>
                    </div>
                    <div>
                        <h3 class="login-feature-title">精英导师团队</h3>
                        <p class="login-feature-desc">行业顶尖专家，为你的职业发展保驾护航</p>
                    </div>
                </div>

                <div class="login-feature">
                    <div class="login-feature-icon">
                        <i class="fa fa-line-chart text-xl"></i>
                    </div>
                    <div>
                        <h3 class="login-feature-title">个性化发展路径</h3>
                        <p class="login-feature-desc">根据你的特点和需求，定制专属职业发展方案</p>
                    </div>
                </div>
            </div>

            <div class="login-socials">
                <a href="#"><i class="fa fa-weibo"></i></a>
                <a href="#"><i class="fa fa-wechat"></i></a>
                <a href="#"><i class="fa fa-linkedin"></i></a>
            </div>
        </div>

        <!-- 右侧表单 -->
        <div class="login-right">
            <h2 class="login-title">账号登录</h2>

            <c:if test="${not empty error}">
                <div class="text-red-500 text-sm mb-4 text-center">${error}</div>
            </c:if>

            <form id="loginForm" class="login-form" action="login" method="get">
                <!-- 手机号 -->
                <div class="login-form-group">
                    <label for="phone" class="login-label">手机号</label>
                    <div class="login-input-box">
                        <i class="fa fa-phone login-icon"></i>
                        <input type="tel" id="phone" name="phone" class="login-input" placeholder="请输入手机号">
                    </div>
                    <p id="phoneError" class="login-error hidden">请输入正确的手机号</p>
                </div>

                <!-- 密码 -->
                <div class="login-form-group">
                    <label for="password" class="login-label">密码</label>
                    <div class="login-input-box">
                        <i class="fa fa-lock login-icon"></i>
                        <input type="password" id="password" name="password" class="login-input"
                               placeholder="请输入密码">
                        <button type="button" id="togglePassword" class="login-password-toggle">
                            <i class="fa fa-eye-slash"></i>
                        </button>
                    </div>
                    <p id="passwordError" class="login-error hidden">请输入密码</p>
                </div>

                <!-- 验证码 -->
                <div class="login-form-group">
                    <label for="captcha" class="login-label">验证码</label>
                    <div class="login-captcha-group">
                        <div class="login-input-box">
                            <i class="fa fa-shield login-icon"></i>
                            <input type="text" id="captcha" name="captcha" class="login-input"
                                   placeholder="请输入验证码">
                        </div>
                        <div id="captchaBox" class="captcha-box">
                            <span id="captchaText" class="captcha-text">生成中</span>
                        </div>
                    </div>
                    <p id="captchaError" class="login-error hidden">请输入正确的验证码</p>
                </div>

                <!-- 记住密码 -->
                <div class="login-options">
                    <label><input type="checkbox" id="remember" name="remember"> 记住密码</label>
                    <a href="#">忘记密码？</a>
                </div>

                <input type="hidden" name="redirect" value="${param.redirect != null ? param.redirect : ''}" />

                <!-- 登录按钮 -->
                <button type="submit" class="login-button">登录</button>

                <!-- 注册引导 -->
                <div class="login-register">
                    <span>还没有账号？</span>
                    <a href="register.jsp">立即注册</a>
                </div>
            </form>
        </div>
    </div>
</main>

<!-- 页脚 -->
<footer class="login-footer">
    <div class="login-footer-container">
        <div class="login-footer-brand">
            <div class="login-footer-icon">
                <i class="fa fa-rocket"></i>
            </div>
            <div>
                <h3 class="login-footer-title">IP创氪师</h3>
                <p class="login-footer-subtitle">成长，长成自己的样子</p>
            </div>
        </div>

        <div class="login-footer-links">
            <a href="#">关于我们</a>
            <a href="#">联系我们</a>
            <a href="#">隐私政策</a>
            <a href="#">服务条款</a>
        </div>
    </div>

    <div class="login-footer-bottom">
        <p>© <%= new java.util.Date().getYear() + 1900 %> IP创氪师 版权所有</p>
    </div>
</footer>

<!-- 表单逻辑 -->
<script src="js/login.js"></script>
</body>
</html>
