package com.front.mapper;

import java.util.List;
import java.util.Map;

public interface AdminDashboardMapper {
    int countTotalUsers();
    int countTotalAdmins();
    int countActiveUsers();
    int countTodayLogins();
    List<Map<String, String>> getRecentAdmins();
    List<Map<String, String>> getRecentUsers();
}
