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

    /**
     * 获取教师总数
     */
    public int getTeacherCount(String keyword) {
        try (SqlSession session = MybatisUtil.getSession()) {
            TeacherMapper mapper = session.getMapper(TeacherMapper.class);
            return mapper.getTeacherCount(keyword);
        }
    }

    /**
     * 分页查询教师列表
     */
    public List<Teacher> getTeachers(String keyword, int offset, int limit) {
        try (SqlSession session = MybatisUtil.getSession()) {
            TeacherMapper mapper = session.getMapper(TeacherMapper.class);
            return mapper.getTeachers(keyword, offset, limit);
        }
    }

    public Teacher getTeacherById(int id) {
        try (SqlSession session = MybatisUtil.getSession()) {
            TeacherMapper mapper = session.getMapper(TeacherMapper.class);
            return mapper.selectById(id);
        }
    }

    public boolean updateTeacher(Teacher teacher) {
        try (SqlSession session = MybatisUtil.getSession()) {
            TeacherMapper mapper = session.getMapper(TeacherMapper.class);
            int rows = mapper.update(teacher);
            session.commit();
            return rows > 0;
        }
    }

    public boolean addTeacher(Teacher teacher) {
        try (SqlSession session = MybatisUtil.getSession()) {
            TeacherMapper mapper = session.getMapper(TeacherMapper.class);
            int rows = mapper.insert(teacher);
            session.commit();
            return rows > 0;
        }
    }

    public boolean deleteTeacherById(int id) {
        try (SqlSession session = MybatisUtil.getSession()) {
            TeacherMapper mapper = session.getMapper(TeacherMapper.class);
            int rows = mapper.deleteById(id);
            session.commit();
            return rows > 0;
        }
    }


    // 其他方法（findByCourseId、findAll、findById 类似，略）
    // 后续扩展（可选）：
    // public Teacher getById(int id) {...}
    // public boolean insertTeacher(Teacher t) {...}
    // public boolean updateTeacher(Teacher t) {...}
    // public boolean deleteTeacher(int id) {...}
}