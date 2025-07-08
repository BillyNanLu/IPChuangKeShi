package com.front.mapper;

import com.front.pojo.CourseCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CourseCategoryMapper {
    List<CourseCategory> findSubCategories(int parentId);

    int findIdByName(String name);

    int countByKeyword(@Param("keyword") String keyword);

    List<CourseCategory> findByKeywordPaged(@Param("keyword") String keyword,
                                            @Param("offset") int offset,
                                            @Param("limit") int limit);

    List<CourseCategory> findByParentId(@Param("parentId") int parentId);

    // 查询所有 type 类型
    List<String> getAllTypes();

    // 根据 id 查找分类
    CourseCategory findById(@Param("id") int id);

    int insertCategory(@Param("parentId") int parentId,
                       @Param("name") String name,
                       @Param("type") String type);

    int updateCategory(@Param("id") int id,
                       @Param("name") String name,
                       @Param("type") String type);

    int countByNameAndParentExceptId(@Param("name") String name,
                                     @Param("parentId") int parentId,
                                     @Param("excludeId") int excludeId);

    int countCoursesUnderCategory(@Param("categoryId") int categoryId);

    int deleteById(@Param("id") int id);
}
