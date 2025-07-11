# IP创氪师

本项目为“IP创氪师”职业规划平台，基于 Java Web 技术开发，支持课程展示、用户注册与登录、AI 聊天咨询、课程报名支付、后台管理等功能模块。

## 📁 项目结构

IPChuangKeShi/

├── src/

│  ├── main/

│  │  ├── java/      # Java 业务代码（Servlet、DAO、POJO 等）

│  │  ├── resources/

│  │  │  └── sql/

│  │  │    └── init.sql  # 数据库初始化脚本

│  │  └── webapp/

│  │    ├── jsp/    # JSP 页面

│  │    └── image/   # 图片资源

│  │    └── CSS/    # 页面样式

│  │    └── JS/    # 页面动态样式

│  └── test/        # 单元测试（如有）

├── pom.xml         # Maven 依赖配置文件

├── sql/

│  └── init.sql      # 建库建表与初始数据脚本（备份/说明用）

└── README.md        # 项目说明文档

## 🧩 技术栈

\- Java 8+

\- JSP + Servlet

\- MySQL 8.0

\- JDBC / MyBatis

\- Tailwind CSS / 原生 JS

\- Apache Tomcat 9

\- Maven 管理依赖

## ⚙️ 快速启动

### 1. 导入项目

以下两种方式二选一：

1. 打开IntelliJ IDEA（推荐，开发也是用的IntelliJ IDEA）直接打开IPChuangKeShi项目文件夹

2. 或者拉取远程仓库代码（GitHub仓库地址：https://github.com/BillyNanLu/IPChuangKeShi.git）

   ```bash
   git clone https://github.com/BillyNanLu/IPChuangKeShi.git
   cd IPChuangKeShi
   ```

### **2. 数据库初始化**

使用以下 SQL 文件初始化数据库：

- 路径：sql/init.sql 或 src/main/resources/sql/init.sql

执行方式：

> 💡 请先创建数据库（也可使用图形化工具Navicate），命令行操作如下

```bash
mysql -u root -p

CREATE DATABASE IP DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

source sql/init.sql
```

> ⚠️  注意：命令行方式确保在IPChuangKeShi目录下

### 3. **配置数据库连接**

修改 /src/main/resources/db.properties 文件，配置如下：

```properties
mysql.driver=com.mysql.cj.jdbc.Driver
mysql.url=jdbc:mysql://localhost:3306/IP?serverTimeZone=UTC&characterEncoding=utf8&useUnicode=true&useSSL=false
jdbc.username=root
jdbc.password=your_password
```

>  ⚠️  注意：启动时报错 Can't connect to database？大概率就是MySQL的端口号、账号和密码问题，请仔细修改

### **4. 构建并运行**

以下两种方式二选一：

1. 在 IDEA 中配置 Tomcat 后即可启动项目。

2. 或使用命令行构建：

   ```bash
   mvn clean package
   ```

   将生成的 .war 文件部署至 Tomcat webapps 目录。

## 👤 初始账号信息（用于测试登录）

> 以下账号信息已在 init.sql 中配置，供本地测试与课程展示使用：

1. 普通用户

   账号：15012345678

   密码：lunan998998

2. 管理员

   账号：13912345678

   密码：lunan998998

## **🧪 功能模块一览**

1. 用户注册 / 登录（含验证码、头像上传）
2. AI 咨询聊天（Markdown 支持、时间戳、Ctrl+Enter 发送）
3. 课程展示与搜索（支持分类、关键词标签）
4. 课程详情页（主讲老师 / FAQ / 推荐理由）
5. 报名与支付（支持支付方式选择与二维码展示）
6. 后台管理（课程、用户、教师、预约管理等）

## **📦 数据库说明**

数据库结构涵盖以下主要表：

- users：用户信息
- course：课程主表
- course_category：课程分类表
- teacher：讲师信息
- appoint_consult：首页咨询申请
- appointment_course：课程报名记录
- pay_method：支付方式定义
- 更多请参考：sql/init.sql

---

##  📎 附录（Appendix）

### A. 页面路由清单

| 页面         | 路径                     |
| ------------ | ------------------------ |
| 登录页       | `/login.jsp`             |
| 用户注册     | `/register.jsp`          |
| 用户管理     | `/user_list.jsp`         |
| 课程管理     | `/course_list.jsp`       |
| 咨询申请管理 | `/consultation_list.jsp` |

### B. 示例账号密码（详见上文）

\- 管理员：15012345678 / lunan998998

\- 普通用户：13912345678 / lunan998998

### C. 关键建表语句（节选）

```sql
CREATE TABLE users (
     user_id INT AUTO_INCREMENT PRIMARY KEY,
     username VARCHAR(50),
     phone VARCHAR(20),
     password VARCHAR(100),
     email VARCHAR(100),
     avatar VARCHAR(255),
     status INT DEFAULT 1,
     role_id INT DEFAULT 3,
     created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

更多内容请参考完整文件：sql/init.sql

