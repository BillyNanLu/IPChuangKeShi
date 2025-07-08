package com.front.service;

import com.front.mapper.AIChatMessageMapper;
import com.front.pojo.AIChatMessage;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class AIChatMessageService {
    public List<AIChatMessage> getMessagesByUserId(int userId) {
            SqlSession session = MybatisUtil.getSession();
            AIChatMessageMapper mapper = session.getMapper(AIChatMessageMapper.class);
            return mapper.getMessagesByUserId(userId);
    }

    /**
     * 保存一条聊天记录
     */
    public void insertMessage(AIChatMessage msg) {
        SqlSession session = MybatisUtil.getSession();
        AIChatMessageMapper mapper = session.getMapper(AIChatMessageMapper.class);
        mapper.insertMessage(msg);
        session.commit();
    }

    /**
     * 获取最近聊天记录（按时间倒序）
     */
    public List<AIChatMessage> getRecentMessages(int userId, int limit) {
        SqlSession session = MybatisUtil.getSession();
        try {
            AIChatMessageMapper chatMapper = session.getMapper(AIChatMessageMapper.class);
            return chatMapper.getRecentMessages(userId, limit);
        } finally {
            session.close();
        }
    }

}
