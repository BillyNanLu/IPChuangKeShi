package com.front.mapper;

import com.front.pojo.AIChatMessage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AiChatMapper {
    List<AIChatMessage> findChats(@Param("keyword") String keyword,
                                  @Param("role") String role,
                                  @Param("offset") int offset,
                                  @Param("limit") int limit);

    int countChats(@Param("keyword") String keyword,
                   @Param("role") String role);
}
