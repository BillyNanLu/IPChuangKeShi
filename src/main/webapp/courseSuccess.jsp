<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/28
  Time: 14:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <title>报名成功 - 虚拟支付</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .bg-primary { background-color: #6366f1; }
        .text-primary { color: #6366f1; }
        .pay-btn:hover { transform: translateY(-2px); box-shadow: 0 6px 12px rgba(0,0,0,0.1); }
        .fade-enter {
            opacity: 0;
            transform: scale(0.95);
        }
        .fade-enter-active {
            opacity: 1;
            transform: scale(1);
            transition: all 0.3s ease-in-out;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center py-12 px-4">

<div class="bg-white shadow-xl rounded-2xl p-8 w-full max-w-2xl space-y-6">
    <h2 class="text-3xl font-bold text-center text-primary">报名确认</h2>

    <div class="flex flex-col md:flex-row md:items-center md:space-x-6">
        <img src="${pageContext.request.contextPath}${courseMore.image}" alt="课程图"
             class="w-full md:w-32 h-32 object-cover rounded-xl border mb-4 md:mb-0" />
        <div class="flex-1 space-y-2">
            <h3 class="text-lg font-semibold">${course.name}</h3>
            <p class="text-sm text-gray-600">${course.intro}</p>
            <p class="text-xl font-bold text-primary">
                ¥ <fmt:formatNumber value="${courseMore.price * courseMore.discount}" type="number" minFractionDigits="2" />
            </p>
        </div>
    </div>

    <div>
        <p class="mb-2 font-medium">请选择支付方式：</p>
        <div class="grid grid-cols-3 gap-4">
            <button onclick="selectMethod('微信')" class="pay-btn bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg shadow transition-all">微信</button>
            <button onclick="selectMethod('支付宝')" class="pay-btn bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded-lg shadow transition-all">支付宝</button>
            <button onclick="selectMethod('其它')" class="pay-btn bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 rounded-lg shadow transition-all">其它</button>
        </div>
    </div>

    <div id="qrBox" class="hidden text-center mt-4 space-y-3 transition-all">
        <p class="text-sm text-gray-600">请使用手机扫描以下二维码完成支付</p>
        <img id="qrImg" src="" alt="支付二维码" class="w-44 h-44 mx-auto border rounded-xl shadow" />
    </div>

    <div class="text-center">
        <button onclick="confirmPayment()" class="bg-primary hover:bg-indigo-600 text-white px-8 py-3 rounded-xl shadow-lg text-lg font-semibold transition-all">
            我已完成支付
        </button>
    </div>
</div>

<!-- 支付成功弹窗 -->
<div id="successModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-50">
    <div class="bg-white rounded-2xl p-8 w-96 text-center shadow-xl space-y-4 animate-fade-in">
        <h3 class="text-green-600 text-2xl font-bold">报名成功！</h3>
        <p class="text-sm text-gray-600">订单号：</p>
        <p class="text-base font-mono text-gray-800" id="orderNoText">${orderNo}</p>
        <button onclick="location.href='courses'" class="mt-4 bg-primary hover:bg-indigo-600 text-white px-6 py-2 rounded-full transition">
            返回课程页
        </button>
    </div>
</div>

<script>
    let orderNo = "${orderNo}";
    let selectedMethod = null;

    function selectMethod(method) {
        selectedMethod = method;
        document.getElementById("qrBox").classList.remove("hidden");

        const qrImg = document.getElementById("qrImg");
        const text = encodeURIComponent(method + "支付 - 订单号：" + orderNo);
        qrImg.src = `https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${text}`;
    }

    function confirmPayment() {
        if (!selectedMethod) {
            alert("请先选择支付方式！");
            return;
        }

        fetch("confirmPayment", {
            method: "POST",
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: "orderNo=" + encodeURIComponent(orderNo) + "&method=" + encodeURIComponent(selectedMethod)
        }).then(res => {
            if (res.ok) {
                document.getElementById("successModal").classList.remove("hidden");
                document.getElementById("successModal").classList.add("flex");
            } else {
                alert("支付失败，请重试！");
            }
        }).catch(() => {
            alert("请求出错，请稍后重试！");
        });
    }
</script>

</body>
</html>
