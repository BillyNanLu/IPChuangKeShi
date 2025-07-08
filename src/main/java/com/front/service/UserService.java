package com.front.service;

import com.front.mapper.UserMapper;
import com.front.pojo.User;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.time.LocalDateTime;

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

}
