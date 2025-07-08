<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/26
  Time: 01:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IP创氪师 -AI职业规划咨询</title>
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
<body class="font-inter text-dark antialiased bg-light">
<header id="navbar" class="fixed top-0 left-0 w-full z-50 transition-navbar bg-white/95 backdrop-blur-md shadow-sm">
  <div class="container mx-auto px-8">
    <div class="flex justify-between items-center h-16 md:h-20">
      <div class="flex items-center">
        <a href="#" class="flex items-center space-x-2">
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
        <a href="courses" class="text-gray-700 hover:text-primary transition-colors font-medium">课程培训</a>
        <a href="consult.jsp" class="text-gray-700 hover:text-primary transition-colors font-medium">一对一职业规划咨询</a>
        <a href="chat" class="text-gray-700 hover:text-primary transition-colors font-medium  border-b-2 border-primary">AI职业规划咨询</a>
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


<main class="max-w-5xl mx-auto px-4 py-32">
  <h2 class="text-3xl font-bold text-center text-primary mb-8">与 IP 创氪师 AI 对话</h2>

  <!-- 聊天主框架 -->
  <div class="bg-white border border-gray-200 rounded-lg shadow-sm flex flex-col h-[600px]">

    <!-- 聊天记录滚动区 -->
    <div id="chatBox" class="flex-1 overflow-y-auto px-6 py-6 space-y-6">
      <c:forEach var="msg" items="${history}">
        <c:choose>
          <c:when test="${msg.role eq 'user'}">
            <div class="flex justify-end items-end gap-3">
              <div class="max-w-[75%] bg-primary text-white text-sm rounded-2xl rounded-br-none px-5 py-3 leading-relaxed">
                  ${fn:escapeXml(msg.message)}
                    <div class="text-xs text-gray-400 text-right mt-1">
                        ${msg.timestamp}
                    </div>
              </div>
              <c:choose>
                <c:when test="${not empty loginUser.avatar}">
                  <img src="${pageContext.request.contextPath}${loginUser.avatar}" alt="头像" class="w-8 h-8 rounded-full object-cover border border-gray-300">
                </c:when>
                <c:otherwise>
                  <img src="image/users/defaultavatars.jpg" alt="默认头像" class="w-8 h-8 rounded-full object-cover border border-gray-300">
                </c:otherwise>
              </c:choose>
            </div>
          </c:when>
          <c:otherwise>
            <div class="flex justify-start items-end gap-3">
              <img src="image/ai/ai_avatar.png" class="w-9 h-9 rounded-full border object-cover" alt="AI头像"/>
              <div class="max-w-[75%] bg-gray-100 text-gray-800 text-sm rounded-2xl rounded-bl-none px-5 py-3 leading-relaxed">
               ${fn:escapeXml(msg.message)}
                 <div class="text-xs text-gray-400 text-right mt-1">
                     ${msg.timestamp}
                 </div>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </c:forEach>

      <!-- 正在输入 -->
      <div id="typingIndicator" class="flex items-center gap-3 justify-start opacity-0 transition-opacity duration-300">
        <img src="image/ai_avatar.png" class="w-9 h-9 rounded-full border object-cover" alt="AI头像"/>
        <span class="text-gray-500 text-sm italic">IP创氪师 正在输入...</span>
      </div>
    </div>

    <!-- 输入框固定在底部 -->
    <form action="chat" method="post" onsubmit="showTyping()"
          class="border-t border-gray-200 px-6 py-4 flex items-center gap-4">
      <input type="text" name="message" id="messageInput"
             placeholder="请输入你的问题..." required autocomplete="off"
             class="flex-1 px-5 py-3 rounded-full border border-gray-300 shadow-sm focus:ring-2 focus:ring-primary focus:outline-none focus:border-primary text-sm">
      <button type="submit"
              class="bg-primary hover:bg-primary/90 text-white px-6 py-2 rounded-full font-medium shadow-sm transition-all">
        发送
      </button>
    </form>
  </div>


  <!-- 快速提问区域 -->
  <div class="flex flex-wrap justify-center gap-4 mt-8 max-w-3xl mx-auto">
    <button type="button" onclick="quickAsk('我适合什么职业？')"
            class="px-5 py-2 rounded-full bg-white border-2 border-primary text-primary font-semibold hover:bg-primary hover:text-white transition-shadow shadow-md hover:shadow-lg">
      我适合什么职业？
    </button>
    <button type="button" onclick="quickAsk('如何提升职业竞争力？')"
            class="px-5 py-2 rounded-full bg-white border-2 border-primary text-primary font-semibold hover:bg-primary hover:text-white transition-shadow shadow-md hover:shadow-lg">
      如何提升职业竞争力？
    </button>
    <button type="button" onclick="quickAsk('什么是IP创氪师？')"
            class="px-5 py-2 rounded-full bg-white border-2 border-primary text-primary font-semibold hover:bg-primary hover:text-white transition-shadow shadow-md hover:shadow-lg">
      什么是IP创氪师？
    </button>
    <button type="button" onclick="quickAsk('怎样规划我的职业路径？')"
            class="px-5 py-2 rounded-full bg-white border-2 border-primary text-primary font-semibold hover:bg-primary hover:text-white transition-shadow shadow-md hover:shadow-lg">
      怎样规划我的职业路径？
    </button>
    <button type="button" onclick="quickAsk('怎样提高面试成功率？')"
            class="px-5 py-2 rounded-full bg-white border-2 border-primary text-primary font-semibold hover:bg-primary hover:text-white transition-shadow shadow-md hover:shadow-lg">
      怎样提高面试成功率？
    </button>
    <button type="button" onclick="quickAsk('如何打造个人品牌？')"
            class="px-5 py-2 rounded-full bg-white border-2 border-primary text-primary font-semibold hover:bg-primary hover:text-white transition-shadow shadow-md hover:shadow-lg">
      如何打造个人品牌？
    </button>
  </div>

</main>

<!-- 底部信息区 -->
<jsp:include page="footer.jsp"/>


<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
<script>
  const chatBox = document.getElementById('chatBox');
  const typingIndicator = document.getElementById('typingIndicator');
  const form = document.querySelector('form');
  const input = document.getElementById('messageInput');

  marked.setOptions({ breaks: true });

  function scrollToBottom() {
    setTimeout(() => {
      chatBox.scrollTop = chatBox.scrollHeight;
    }, 150);
  }


  window.addEventListener('DOMContentLoaded', () => {
    scrollToBottom();
  });

  function scrollToBottom() {
    setTimeout(() => {
      chatBox.scrollTop = chatBox.scrollHeight;
    }, 150);
  }

  function showTyping() {
    typingIndicator.style.opacity = '1';
    scrollToBottom();
  }

  function quickAsk(text) {
    const input = document.getElementById('messageInput');
    input.value = text;
    input.focus();
  }

  form.addEventListener('submit', () => {
    const message = input.value.trim();
    if (!message) return;

    // 创建用户气泡
    const wrapper = document.createElement('div');
    wrapper.className = 'flex justify-end items-end gap-3';
    wrapper.innerHTML = `
    <div class="max-w-[75%] bg-primary text-white text-sm rounded-2xl rounded-br-none px-5 py-3 leading-relaxed">
      \${escapeHtml(message)}
    </div>
    <img src="image/users/defaultavatars.jpg" class="w-9 h-9 rounded-full border object-cover" />
  `;
    chatBox.appendChild(wrapper);

    // 显示正在输入
    showTyping();

    // 滚动到底部
    scrollToBottom();
  });

  // 可选：防止 XSS
  function escapeHtml(text) {
    const div = document.createElement('div');
    div.innerText = text;
    return div.innerHTML;
  }

  // 支持 Ctrl + Enter 快捷发送
  input.addEventListener('keydown', function (e) {
    if (e.ctrlKey && e.key === 'Enter') {
      form.requestSubmit(); // 等效触发表单提交
    }
  });

  // Markdown 转换函数（前端气泡生成时用）
  function escapeHtml(text) {
    return marked.parseInline(text);
  }

  window.addEventListener('DOMContentLoaded', scrollToBottom);
</script>



</body>
</html>