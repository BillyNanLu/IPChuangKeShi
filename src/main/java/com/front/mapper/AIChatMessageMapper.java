package com.front.mapper;

import com.front.pojo.AIChatMessage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AIChatMessageMapper {
    List<AIChatMessage> getMessagesByUserId(@Param("userId") int userId);

    int insertMessage(AIChatMessage msg);

    List<AIChatMessage> getRecentMessages(@Param("userId") int userId, @Param("limit") int limit);
}
