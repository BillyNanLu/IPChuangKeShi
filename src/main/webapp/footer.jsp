<%--
  Created by IntelliJ IDEA.
  User: nanlu
  Date: 2025/6/26
  Time: 21:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<footer class="bg-dark text-white pt-16 pb-8">
  <div class="container mx-auto px-8">
    <div class="grid grid-cols-4 gap-8 mb-12">
      <!-- 联系信息 -->
      <div>
        <div class="flex items-center space-x-2 mb-6">
          <div class="w-10 h-10 rounded-lg bg-primary flex items-center justify-center text-white">
            <i class="fa fa-rocket text-xl"></i>
          </div>
          <div>
            <h3 class="text-lg font-bold">新精英生涯</h3>
            <p class="text-gray-400 text-sm">成长，长成自己的样子</p>
          </div>
        </div>

        <div class="space-y-4 mb-6">
          <div class="flex items-start space-x-3">
            <i class="fa fa-map-marker text-primary mt-1"></i>
            <p class="text-gray-400">中国（上海）自由贸易试验区奥纳路55号1幢607室</p>
          </div>
          <div class="flex items-center space-x-3">
            <i class="fa fa-phone text-primary"></i>
            <p class="text-gray-400">400-8898-988（24小时免费咨询）</p>
          </div>
          <div class="flex items-center space-x-3">
            <i class="fa fa-clock-o text-primary"></i>
            <p class="text-gray-400">周一至周日 9:00-21:00</p>
          </div>
        </div>

        <div class="flex space-x-4">
          <a href="#" class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-white hover:bg-primary transition-colors">
            <i class="fa fa-weibo"></i>
          </a>
          <a href="#" class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-white hover:bg-primary transition-colors">
            <i class="fa fa-wechat"></i>
          </a>
          <a href="#" class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-white hover:bg-primary transition-colors">
            <i class="fa fa-linkedin"></i>
          </a>
          <a href="#" class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-white hover:bg-primary transition-colors">
            <i class="fa fa-youtube-play"></i>
          </a>
        </div>
      </div>

      <!-- 快捷入口 -->
      <div>
        <h3 class="text-lg font-bold mb-6">快捷入口</h3>
        <ul class="space-y-3">
          <li><a href="#consult" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 咨询师预约</a></li>
          <li><a href="login.jsp" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 学员登录</a></li>
          <li><a href="#" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 生涯测评工具</a></li>
          <li><a href="chat" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> AI测评</a></li>
          <li><a href="#stories" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 学员成功故事</a></li>
          <li><a href="#news" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 生涯资讯</a></li>
        </ul>
      </div>

      <!-- 课程体系 -->
      <div>
        <h3 class="text-lg font-bold mb-6">课程体系</h3>
        <ul class="space-y-3">
          <li><a href="courseDetail?id=1" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 职业生涯规划-基石班</a></li>
          <li><a href="courseDetail?id=2" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 职业生涯咨询-实战班</a></li>
          <li><a href="#" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 一对一职业规划咨询</a></li>
          <li><a href="#" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 超级个体IP营</a></li>
          <li><a href="#" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 职业辅导「选对」平台</a></li>
          <li><a href="courseDetail?id=3" class="text-gray-400 hover:text-white transition-colors"><i class="fa fa-angle-right mr-2 text-primary"></i> 企业内训服务</a></li>
        </ul>
      </div>

      <!-- 微信公众号 -->
      <div>
        <h3 class="text-lg font-bold mb-6">关注我们</h3>
        <p class="text-gray-400 mb-4">扫描二维码，关注公众号获取更多生涯规划资讯 | IP创氪师 X nan19 studio</p>
        <div class="bg-white p-4 rounded-lg inline-block mb-4">
          <img src="image/WechatOfficialAccount.png" alt="微信公众号二维码" class="w-32 h-32">
        </div>

        <h3 class="text-lg font-bold mt-8 mb-4">下载APP</h3>
        <p class="text-gray-400 mb-2">随时随地学习，开启你的职业成长之旅</p>
        <div class="flex space-x-2">
          <a href="#" class="w-12 h-12 rounded-lg bg-white/10 flex items-center justify-center text-white hover:bg-primary transition-colors">
            <i class="fa fa-apple text-xl"></i>
          </a>
          <a href="#" class="w-12 h-12 rounded-lg bg-white/10 flex items-center justify-center text-white hover:bg-primary transition-colors">
            <i class="fa fa-android text-xl"></i>
          </a>
        </div>
      </div>
    </div>

    <div class="border-t border-gray-700 pt-8 text-center text-gray-500 text-sm">
      <p>© <%= new java.util.Date().getYear() + 1900 %> IP创氪师 版权所有</p>
    </div>
  </div>
</footer>
