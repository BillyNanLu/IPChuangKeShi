package com.front.service;

import com.front.mapper.CourseOrderMapper;
import com.front.pojo.CourseOrder;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CourseOrderService {
    public boolean hasEnrolled(int courseId, int userId) {
        SqlSession session = MybatisUtil.getSession();
        CourseOrderMapper mapper = session.getMapper(CourseOrderMapper.class);
        Integer count = mapper.countByCourseAndUser(courseId, userId);
        return count != null && count > 0;
    }

    public void insertOrder(String orderNo, int courseId, int userId) {
        SqlSession session = MybatisUtil.getSession();
        CourseOrderMapper mapper = session.getMapper(CourseOrderMapper.class);
        mapper.insertOrder(orderNo, courseId, userId);
        session.commit();
    }

    public void confirmPayment(String orderNo, String method) {
        SqlSession session = MybatisUtil.getSession();
        try {
            CourseOrderMapper mapper = session.getMapper(CourseOrderMapper.class);
            mapper.confirmPayment(orderNo, method);
            session.commit();
        } finally {
            session.close();
        }
    }

    public int countOrders(String keyword, String status) {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(CourseOrderMapper.class).countOrders(keyword, status);
        }
    }

    public List<CourseOrder> getOrdersByPage(String keyword, String status, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(CourseOrderMapper.class)
                    .getOrdersByPage(keyword, status, offset, pageSize);
        }
    }

    public List<CourseOrder> listByUserId(Integer userId) {
        try (SqlSession sqlSession = MybatisUtil.getSession()) {
            CourseOrderMapper orderMapper = sqlSession.getMapper(CourseOrderMapper.class);
            List<CourseOrder> orderBeanList = orderMapper.listByUserId(userId);
            return orderBeanList;
        }
    }
}
