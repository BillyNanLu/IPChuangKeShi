package com.front.mapper;

import com.front.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;

public interface UserMapper {
    User findByPhoneAndPassword(@Param("phone") String phone,
                                @Param("encryptedPassword") String encryptedPassword);

    int updateLastLogin(@Param("userId") int userId,
                        @Param("loginTime") LocalDateTime loginTime);

}
