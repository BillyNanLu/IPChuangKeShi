package com.front.service;

import com.front.mapper.UserMapper;
import com.front.pojo.User;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.time.LocalDateTime;
import java.util.List;

public class UserService {
    public User findByPhoneAndPassword(String phone, String encryptedPassword) {
        SqlSession session = MybatisUtil.getSession();
        User user = null;
        System.out.println("查询 phone：" + phone);
        System.out.println("查询 encryptedPassword：" + encryptedPassword);
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            user = mapper.findByPhoneAndPassword(phone, encryptedPassword);
            System.out.println("查询结果：" + user);
        } finally {
            session.close();
        }
        return user;
    }

    public void updateLoginTime(int userId, LocalDateTime loginTime) {
        SqlSession session = MybatisUtil.getSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            mapper.updateLastLogin(userId, loginTime);
            session.commit();
        } finally {
            session.close();
        }
    }

    public List<User> searchUsers(String keyword, int offset, int limit) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.searchUsers(keyword != null ? "%" + keyword + "%" : null, offset, limit);
        }
    }

    public int countUsers(String keyword) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.countUsers(keyword != null ? "%" + keyword + "%" : null);
        }
    }

    public void toggleUserStatus(int userId) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            mapper.toggleUserStatus(userId);
            session.commit();
        }
    }

    public User getUserById(int id) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.getUserById(id);
        }
    }

    public boolean updateUser(User user) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            int result = mapper.updateUser(user);
            session.commit();
            return result > 0;
        }
    }

    public boolean insertUser(User user) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            int result = mapper.insertUser(user);
            session.commit();
            return result > 0;
        }
    }

    public boolean deleteUserById(int userId) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            int result = mapper.deleteById(userId);
            session.commit();
            return result > 0;
        }
    }

    public List<User> findByRoleId(int roleId) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.findByRoleId(roleId);
        }
    }

    public List<User> findAdminsByRoleAndKeyword(int roleId, String keyword) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.findAdminsByRoleAndKeyword(roleId, "%" + keyword + "%");
        }
    }

    public User get(Integer userId) {
        try (SqlSession sqlSession = MybatisUtil.getSession()) {
            UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
            return userMapper.get(userId);
        }
    }

    public int updateProfile(User usersBean) {
        try (SqlSession session = MybatisUtil.getSession()) {
            UserMapper usersMapper = session.getMapper(UserMapper.class);
            return usersMapper.updateProfile(usersBean);
        }
    }

    public boolean addUser(String username, String password, String gender, String phone, String email, String avatar, Integer role_id) {
        User usersBean = new User();
        usersBean.setUsername(username);
        usersBean.setPassword(password);
        usersBean.setGender(gender);
        usersBean.setPhone(phone);
        usersBean.setEmail(email);
        usersBean.setAvatar(avatar);
        usersBean.setRoleId(role_id);
        SqlSession session = MybatisUtil.getSession();
        try (session) {
            UserMapper usersMapper = session.getMapper(UserMapper.class);
            int result = usersMapper.insert(usersBean);
            session.commit(); // 显式提交事务
            return result > 0;
        } catch (Exception e) {
            session.rollback(); // 发生异常时回滚
            e.printStackTrace();
            return false;
        }
    }

}
