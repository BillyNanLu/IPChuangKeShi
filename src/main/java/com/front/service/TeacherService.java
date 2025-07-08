package com.front.service;

import com.front.mapper.TeacherMapper;
import com.front.pojo.Teacher;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class TeacherService {
    public List<Teacher> findByDepartment(String department) {
        SqlSession session = MybatisUtil.getSession();
        try {
            TeacherMapper mapper = session.getMapper(TeacherMapper.class);
            return mapper.findByDepartment(department);
        } finally {
            MybatisUtil.closeSession(session);
        }
    }

    // 其他方法（findByCourseId、findAll、findById 类似，略）
}