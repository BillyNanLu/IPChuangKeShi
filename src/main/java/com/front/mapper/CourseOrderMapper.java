package com.front.mapper;

import com.front.pojo.CourseOrder;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CourseOrderMapper {
    Integer countByCourseAndUser(@Param("courseId") int courseId,
                             @Param("userId") int userId);

    void insertOrder(@Param("orderNo") String orderNo,
                     @Param("courseId") int courseId,
                     @Param("userId") int userId);

    void confirmPayment(@Param("orderNo") String orderNo, @Param("method") String method);

    int countOrders(@Param("keyword") String keyword, @Param("status") String status);

    List<CourseOrder> getOrdersByPage(@Param("keyword") String keyword,
                                      @Param("status") String status,
                                      @Param("offset") int offset,
                                      @Param("limit") int limit);

    List<CourseOrder> listByUserId(@Param("userId") Integer userId);
}
