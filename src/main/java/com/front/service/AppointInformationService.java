package com.front.service;

import com.front.mapper.AppointInformationMapper;
import com.front.pojo.AppointInformation;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.time.LocalDateTime;
import java.util.List;

public class AppointInformationService {
    public boolean addAppointInformation(AppointInformation appointInfo) {
        SqlSession session = MybatisUtil.getSession();
        try {
            appointInfo.setAppointmentId(MybatisUtil.getAppointInfoId());
            appointInfo.setStatus(0);
            appointInfo.setCreatedAt(LocalDateTime.now());
            appointInfo.setUpdatedAt(LocalDateTime.now());
            AppointInformationMapper mapper = session.getMapper(AppointInformationMapper.class);
            // 调用存储过程，生成的appointment_id会通过OUT参数赋值给pojo
            mapper.insertAppointInformation(appointInfo);
            // 验证预约ID是否生成
            return appointInfo.getAppointmentId() != null && !appointInfo.getAppointmentId().isEmpty();
        } finally {
            MybatisUtil.closeSession(session);
        }
    }

    public int countByKeyword(String keyword) {
        try (SqlSession session = MybatisUtil.getSession()) {
            AppointInformationMapper mapper = session.getMapper(AppointInformationMapper.class);
            return mapper.countByKeyword(keyword);
        }
    }

    public List<AppointInformation> getByKeywordWithPage(String keyword, int offset, int limit) {
        try (SqlSession session = MybatisUtil.getSession()) {
            AppointInformationMapper mapper = session.getMapper(AppointInformationMapper.class);
            return mapper.getByKeywordWithPage(keyword, offset, limit);
        }
    }

}