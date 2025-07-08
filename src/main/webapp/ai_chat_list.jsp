<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/7/4
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IP创氪师-管理后台</title>
</head>

<%@ include file="sidebar.jsp" %>

<div class="ml-64 p-6 bg-gray-100 min-h-screen">
  <!-- 标题 -->
  <div class="mb-6 flex justify-between items-center">
    <h1 class="text-2xl font-bold text-gray-800">AI 聊天记录管理</h1>
    <div class="mt-4 text-right">
      <button onclick="exportSelectedChatsToPDF()" class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700">
        导出选中为 PDF
      </button>
      <!-- 添加一个隐藏的 div 用于生成 PDF -->
      <div id="pdfContent" class="hidden"></div>
      <button onclick="localStorage.removeItem('selectedChatRecords'); location.reload();" class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700">
        清空选择
      </button>
    </div>
  </div>
  
  <!-- 搜索栏 -->
  <form method="get" action="aiChatList" class="bg-white p-4 rounded shadow mb-4 flex items-center space-x-4">
    <input type="text" name="keyword" value="${param.keyword}" placeholder="关键词搜索"
           class="border px-3 py-2 rounded w-64" />
    <select name="role" class="border px-3 py-2 rounded">
      <option value="">全部角色</option>
      <option value="user" ${param.role == 'user' ? 'selected' : ''}>用户</option>
      <option value="assistant" ${param.role == 'assistant' ? 'selected' : ''}>AI助手</option>
    </select>
    <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">搜索</button>
  </form>

  <!-- 聊天记录表格 -->
  <div class="overflow-x-auto bg-white rounded-lg shadow-md">
    <table class="min-w-full text-sm text-gray-700">
      <thead class="bg-gray-50 text-xs uppercase text-gray-500">
      <tr>
        <th class="px-4 py-3 w-12 text-left"> <!-- 修改为左对齐 -->
          <input type="checkbox" id="selectAll" onclick="toggleAll(this)" class="rounded text-blue-600 focus:ring-blue-500">
        </th>
        <th class="px-4 py-3 w-20 text-left">编号</th>
        <th class="px-4 py-3 w-32 text-left">用户名</th>
        <th class="px-4 py-3 w-24 text-left">角色</th>
        <th class="px-4 py-3 w-[300px] text-left">内容</th>
        <th class="px-4 py-3 w-48 text-left">时间</th>
        <th class="px-4 py-3 w-20 text-left">操作</th>
      </tr>
      </thead>
      <tbody class="divide-y divide-gray-200">
      <c:forEach var="chat" items="${chatList}" varStatus="s">
        <tr class="hover:bg-gray-50 transition-colors duration-150">
          <td class="px-4 py-3 text-left"> <!-- 修改为左对齐 -->
            <input type="checkbox"
                   class="chat-checkbox rounded text-blue-600 focus:ring-blue-500"
                   value="${chat.id}"
                   data-idx="${s.index + 1 + (page - 1) * 10}"
                   data-username="${chat.username}"
                   data-role="${chat.role}"
                   data-message="${fn:escapeXml(chat.message)}"
                   data-timestamp="${chat.timestamp}">
          </td>
          <td class="px-4 py-3">${s.index + 1 + (page - 1) * 10}</td>
          <td class="px-4 py-3 font-medium">${chat.username}</td>
          <td class="px-4 py-3">
            <span class="px-2 py-1 text-xs font-medium rounded-full ${chat.role == 'user' ? 'bg-blue-100 text-blue-800' : 'bg-purple-100 text-purple-800'}">
                ${chat.role == 'user' ? '用户' : 'AI助手'}
            </span>
          </td>
          <td class="px-4 py-3 truncate max-w-xs">${chat.message}</td>
          <td class="px-4 py-3 text-sm text-gray-500">
              ${fn:replace(chat.timestamp, 'T', ' ')}
          </td>
          <td class="px-4 py-3">
            <button class="inline-flex items-center px-2 py-1 text-sm font-medium text-blue-600 bg-blue-50 rounded hover:bg-blue-100 transition-colors duration-150"
                    onclick="showChatModal('${fn:escapeXml(chat.username)}', '${chat.role}', '${chat.timestamp}', '${fn:escapeXml(chat.message)}')">
              <i class="fa fa-eye mr-1"></i> 查看
            </button>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

  <!-- 分页导航 -->
  <div class="mt-6 flex justify-between items-center">
    <div class="text-sm text-gray-500">共 ${totalCount} 条记录，页数 ${page} / ${totalPage}</div>
    <div class="space-x-2">
      <c:if test="${page > 1}">
        <a href="aiChatList?page=${page - 1}&keyword=${param.keyword}&role=${param.role}"
           class="px-3 py-1 bg-gray-200 rounded hover:bg-gray-300">上一页</a>
      </c:if>
      <c:if test="${page < totalPage}">
        <a href="aiChatList?page=${page + 1}&keyword=${param.keyword}&role=${param.role}"
           class="px-3 py-1 bg-gray-200 rounded hover:bg-gray-300">下一页</a>
      </c:if>
    </div>
  </div>

</div>


<!-- 聊天详情模态框 -->
<div id="chatModal" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center hidden z-50">
  <div class="bg-white rounded-xl shadow-lg w-full max-w-lg p-6 relative">
    <!-- 关闭按钮 -->
    <button onclick="closeChatModal()" class="absolute top-3 right-3 text-gray-400 hover:text-gray-700 text-xl font-bold">&times;</button>

    <!-- 用户信息 -->
    <div class="mb-4 text-center">
      <h2 class="text-xl font-semibold text-gray-800 mb-1">
        聊天详情
      </h2>
      <p class="text-sm text-gray-500">查看用户与 AI 的对话内容</p>
    </div>

    <!-- 内容区 -->
    <div class="space-y-4 text-sm text-gray-700">
      <div>
        <h3 class="text-base font-semibold text-gray-600 mb-1 border-b pb-1">基本信息</h3>
        <ul class="space-y-1">
          <li><strong>用户名：</strong><span id="modalUsername"></span></li>
          <li><strong>角色：</strong><span id="modalRole"></span></li>
          <li><strong>时间：</strong><span id="modalTimestamp"></span></li>
        </ul>
      </div>

      <div>
        <h3 class="text-base font-semibold text-gray-600 mb-1 border-b pb-1">聊天内容</h3>
        <div id="modalMessage" class="whitespace-pre-wrap p-3 bg-gray-50 border rounded"></div>
      </div>
    </div>
  </div>
</div>


<!-- 其他HTML内容保持不变，仅修改脚本部分 -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<script>
  // 模态框相关函数（保持不变）
  function showChatModal(username, role, timestamp, message) {
    document.getElementById("modalUsername").innerText = username;
    document.getElementById("modalRole").innerText = role === 'user' ? '用户' : 'AI助手';
    document.getElementById("modalTimestamp").innerText = formatDate(timestamp);
    document.getElementById("modalMessage").innerText = message;
    document.getElementById("chatModal").classList.remove("hidden");
  }

  function closeChatModal() {
    document.getElementById("chatModal").classList.add("hidden");
  }

  // 新增：确保formatDate在全局作用域
  function formatDate(str) {
    return str ? str.replace('T', ' ') : '';
  }

  // PDF导出函数（关键修改部分）
  function exportSelectedChatsToPDF() {
    const selected = getSelectedRecords();
    const values = Object.values(selected);

    if (values.length === 0) {
      alert("请至少选择一条聊天记录！");
      return;
    }

    // 【关键】分批次处理（每50条一批）
    const batchSize = 50;
    const totalBatches = Math.ceil(values.length / batchSize);
    let currentBatch = 0;
    let allHtml = "";

    // 显示加载提示（增强用户体验）
    const loadingEl = document.createElement('div');
    loadingEl.id = "pdf-loading";
    loadingEl.style.cssText = `
    position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
    background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    z-index: 9999; text-align: center;
    display: flex; flex-direction: column; align-items: center;
  `;
    loadingEl.innerHTML = `
    <i class="fa fa-spinner fa-spin fa-2x mb-3"></i>
    <p>正在生成PDF：<span id="batch-progress">0</span>/${totalBatches}批</p>
    <p class="text-sm text-gray-500" id="record-count">共 ${values.length} 条记录</p>
  `;
    document.body.appendChild(loadingEl);

    // 【核心】分批次拼接HTML并渲染
    function processBatch() {
      if (currentBatch >= totalBatches) {
        // 所有批次处理完成，生成PDF
        generatePDF();
        return;
      }

      const startIdx = currentBatch * batchSize;
      const endIdx = Math.min(startIdx + batchSize, values.length);
      const batchRecords = values.slice(startIdx, endIdx);
      let batchHtml = "";

      batchRecords.forEach(record => {
        const idx = record.idx || '';
        const username = escapeHtml(record.username || '未命名用户');
        const roleText = record.role === 'user' ? '用户' : 'AI助手';
        const message = escapeHtml(record.message || '无内容').replace(/\n/g, '<br>');
        const timestamp = formatDate(record.timestamp || '未知时间');

        batchHtml += `
        <tr>
          <td style="text-align:center;">${idx}</td>
          <td>${username}</td>
          <td style="text-align:center;">${roleText}</td>
          <td>${message}</td>
          <td>${timestamp}</td>
        </tr>
      `;
      });

      allHtml += batchHtml;
      currentBatch++;

      // 更新进度提示
      document.getElementById("batch-progress").textContent = currentBatch;

      // 【关键】使用requestAnimationFrame优化渲染时机
      requestAnimationFrame(() => {
        processBatch();
      });
    }

    function generatePDF() {
      if (!allHtml) {
        alert("生成PDF内容失败，请重试");
        document.getElementById("pdf-loading").remove();
        return;
      }

      // 构建完整HTML
      const finalHtml = `
      <h2 style="text-align:center;margin-bottom:20px;">AI 聊天记录导出</h2>
      <table border="1" cellspacing="0" cellpadding="8"
             style="width:100%; border-collapse:collapse; font-size:11px; word-break:break-all; table-layout:fixed;">
        <thead style="background:#f5f5f5; font-weight:bold;">
          <tr>
            <th style="width:5%;">编号</th>
            <th style="width:15%;">用户名</th>
            <th style="width:10%;">角色</th>
            <th style="width:45%;">内容</th>
            <th style="width:25%;">时间</th>
          </tr>
        </thead>
        <tbody>${allHtml}</tbody>
      </table>
    `;

      const container = document.getElementById("pdfContent");
      container.innerHTML = finalHtml;
      container.classList.remove("hidden");

      // 【关键】增加超时时间并分阶段渲染
      setTimeout(() => {
        const opt = {
          margin: 10,
          filename: 'ai_chat_records.pdf',
          image: { type: 'jpeg', quality: 0.95 }, // 降低图片质量提升性能
          html2canvas: {
            scale: 1.5,                // 降低渲染比例
            useCORS: true,
            logging: false,            // 关闭日志提升性能
            allowTaint: true           // 允许跨域资源
          },
          jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' }
        };

        html2pdf().from(container).set(opt).save().then(() => {
          document.getElementById("pdf-loading").remove();
          container.innerHTML = '';
          container.classList.add("hidden");
        }).catch(err => {
          document.getElementById("pdf-loading").remove();
          console.error('PDF生成失败:', err);
          alert('PDF生成失败，请检查记录数量是否过多');
        });
      }, 800); // 延长至800毫秒
    }

    // 开始分批次处理
    processBatch();
  }

  // 转义HTML特殊字符（确保内容安全）
  function escapeHtml(str) {
    return str ? str
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;") : '';
  }

  // 本地存储相关函数（保持不变）
  const SELECTED_KEY = 'selectedChatRecords';

  function getSelectedRecords() {
    const saved = localStorage.getItem(SELECTED_KEY);
    return saved ? JSON.parse(saved) : {};
  }

  function saveSelectedRecords(data) {
    localStorage.setItem(SELECTED_KEY, JSON.stringify(data));
  }

  function toggleCheckbox(checkbox) {
    const id = checkbox.value;
    const selected = getSelectedRecords();

    if (checkbox.checked) {
      selected[id] = {
        idx: checkbox.dataset.idx,
        username: checkbox.dataset.username,
        role: checkbox.dataset.role,
        message: checkbox.dataset.message,
        timestamp: checkbox.dataset.timestamp
      };
    } else {
      delete selected[id];
    }

    saveSelectedRecords(selected);
  }

  function toggleAll(source) {
    document.querySelectorAll('.chat-checkbox').forEach(cb => {
      cb.checked = source.checked;
      toggleCheckbox(cb);
    });
  }

  window.addEventListener("DOMContentLoaded", () => {
    const selected = getSelectedRecords();
    document.querySelectorAll(".chat-checkbox").forEach(cb => {
      const id = cb.value;
      if (selected[id]) {
        cb.checked = true;
      }
      cb.addEventListener("change", () => toggleCheckbox(cb));
    });
  });
</script>


</html>