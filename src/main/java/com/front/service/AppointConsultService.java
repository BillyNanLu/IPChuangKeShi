package com.front.service;

import com.front.mapper.AppointConsultMapper;
import com.front.pojo.AppointConsult;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class AppointConsultService {
    public boolean addAppointConsult(AppointConsult bean) {
        SqlSession session = MybatisUtil.getSession();
        try {
            AppointConsultMapper mapper = session.getMapper(AppointConsultMapper.class);
            mapper.insert(bean);
            return true;
        } finally {
            MybatisUtil.closeSession(session);
        }
    }

    public int count(String keyword) {
        try (SqlSession session = MybatisUtil.getSession()) {
            AppointConsultMapper mapper = session.getMapper(AppointConsultMapper.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                return mapper.countByKeyword(keyword.trim());
            } else {
                return mapper.countAll();
            }
        }
    }

    public List<AppointConsult> getByPage(String keyword, int page, int pageSize) {
        int start = (page - 1) * pageSize;
        try (SqlSession session = MybatisUtil.getSession()) {
            AppointConsultMapper mapper = session.getMapper(AppointConsultMapper.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                return mapper.findByPageAndKeyword(keyword.trim(), start, pageSize);
            } else {
                return mapper.findByPage(start, pageSize);
            }
        }
    }

    public void deleteById(int id) {
        try (SqlSession session = MybatisUtil.getSession()) {
            AppointConsultMapper mapper = session.getMapper(AppointConsultMapper.class);
            mapper.deleteById(id);
            session.commit();
        }
    }

}