package com.front.service;

import com.front.mapper.AdminDashboardMapper;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class AdminDashboardService {
    public int getTotalUsers() {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(AdminDashboardMapper.class).countTotalUsers();
        }
    }

    public int getTotalAdmins() {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(AdminDashboardMapper.class).countTotalAdmins();
        }
    }

    public int getActiveUsers() {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(AdminDashboardMapper.class).countActiveUsers();
        }
    }

    public int getTodayLogins() {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(AdminDashboardMapper.class).countTodayLogins();
        }
    }

    public List<Map<String, String>> getRecentAdmins() {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(AdminDashboardMapper.class).getRecentAdmins();
        }
    }

    public List<Map<String, String>> getRecentUsers() {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(AdminDashboardMapper.class).getRecentUsers();
        }
    }
}
