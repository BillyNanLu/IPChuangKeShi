package com.front.service;

import com.front.mapper.AiChatMapper;
import com.front.pojo.AIChatMessage;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class AiChatService {
    public List<AIChatMessage> findChats(String keyword, String role, int offset, int limit) {
        SqlSession session = MybatisUtil.getSession();
        AiChatMapper mapper = session.getMapper(AiChatMapper.class);
        List<AIChatMessage> list = mapper.findChats(keyword, role, offset, limit);
        session.close();
        return list;
    }

    public int countChats(String keyword, String role) {
        SqlSession session = MybatisUtil.getSession();
        AiChatMapper mapper = session.getMapper(AiChatMapper.class);
        int count = mapper.countChats(keyword, role);
        session.close();
        return count;
    }
}
