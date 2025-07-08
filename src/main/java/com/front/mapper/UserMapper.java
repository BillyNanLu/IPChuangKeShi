package com.front.mapper;

import com.front.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface UserMapper {
    User findByPhoneAndPassword(@Param("phone") String phone,
                                @Param("encryptedPassword") String encryptedPassword);

    int updateLastLogin(@Param("userId") int userId,
                        @Param("loginTime") LocalDateTime loginTime);

    List<User> searchUsers(@Param("keyword") String keyword,
                           @Param("offset") int offset,
                           @Param("limit") int limit);

    int countUsers(@Param("keyword") String keyword);

    void toggleUserStatus(@Param("userId") int userId);

    User getUserById(int id);

    int updateUser(User user);

    int insertUser(User user);

    int deleteById(int userId);

    List<User> findByRoleId(@Param("roleId") int roleId);

    List<User> findAdminsByRoleAndKeyword(@Param("roleId") int roleId, @Param("keyword") String keyword);

    User get(@Param("userId") Integer userId);

    int updateProfile(User usersBean);

    int insert(User usersBean);
}
