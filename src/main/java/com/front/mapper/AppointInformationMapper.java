package com.front.mapper;

import com.front.pojo.AppointInformation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AppointInformationMapper {

    void insertAppointInformation(AppointInformation appointInfo);

    int countByKeyword(@Param("keyword") String keyword);

    List<AppointInformation> getByKeywordWithPage(
            @Param("keyword") String keyword,
            @Param("offset") int offset,
            @Param("limit") int limit
    );
}