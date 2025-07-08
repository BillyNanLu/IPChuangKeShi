package com.front.mapper;

import com.front.pojo.AppointConsult;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AppointConsultMapper {
    void insert(AppointConsult appointConsult);

    int countAll();

    int countByKeyword(@Param("keyword") String keyword);

    List<AppointConsult> findAll();

    List<AppointConsult> findByKeyword(@Param("keyword") String keyword);

    List<AppointConsult> findByPage(@Param("start") int start,
                                    @Param("limit") int limit);

    List<AppointConsult> findByPageAndKeyword(@Param("keyword") String keyword,
                                              @Param("start") int start,
                                              @Param("limit") int limit);

    void deleteById(@Param("id") int id);
}