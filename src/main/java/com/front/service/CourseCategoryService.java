package com.front.service;

import com.front.mapper.CourseCategoryMapper;
import com.front.pojo.CourseCategory;
import com.front.utils.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CourseCategoryService {
    public List<CourseCategory> findSubCategories(int parentId) {
        SqlSession session = MybatisUtil.getSession();
        CourseCategoryMapper mapper = session.getMapper(CourseCategoryMapper.class);
        return mapper.findSubCategories(parentId);
    }

    public int findIdByName(String name) {
        SqlSession session = MybatisUtil.getSession();
        try {
            CourseCategoryMapper mapper = session.getMapper(CourseCategoryMapper.class);
            return mapper.findIdByName(name);
        } finally {
            MybatisUtil.closeSession(session);
        }
    }

    public int countByKeyword(String keyword) {
        try (SqlSession session = MybatisUtil.getSession()) {
            CourseCategoryMapper mapper = session.getMapper(CourseCategoryMapper.class);
            return mapper.countByKeyword(keyword);
        }
    }

    public List<CourseCategory> getByKeywordWithPage(String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        try (SqlSession session = MybatisUtil.getSession()) {
            CourseCategoryMapper mapper = session.getMapper(CourseCategoryMapper.class);
            return mapper.findByKeywordPaged(keyword, offset, pageSize);
        }
    }

    public List<CourseCategory> getNestedCategoryList() {
        try (SqlSession session = MybatisUtil.getSession()) {
            CourseCategoryMapper mapper = session.getMapper(CourseCategoryMapper.class);

            List<CourseCategory> topList = mapper.findByParentId(0);
            for (CourseCategory top : topList) {
                List<CourseCategory> secondList = mapper.findByParentId(top.getId());
                for (CourseCategory second : secondList) {
                    List<CourseCategory> thirdList = mapper.findByParentId(second.getId());
                    second.setChildren(thirdList);
                }
                top.setChildren(secondList);
            }

            return topList;
        }
    }

    public List<String> getAllTypes() {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(CourseCategoryMapper.class).getAllTypes();
        }
    }

    public CourseCategory findById(int id) {
        try (SqlSession session = MybatisUtil.getSession()) {
            return session.getMapper(CourseCategoryMapper.class).findById(id);
        }
    }

    public boolean insertCategory(int parentId, String name, String type) {
        try (SqlSession session = MybatisUtil.getSession()) {
            int rows = session.getMapper(CourseCategoryMapper.class).insertCategory(parentId, name, type);
            session.commit();
            return rows > 0;
        }
    }

    public boolean isNameDuplicate(String name, int parentId, int excludeId) {
        try (SqlSession session = MybatisUtil.getSession()) {
            int count = session.getMapper(CourseCategoryMapper.class)
                    .countByNameAndParentExceptId(name, parentId, excludeId);
            return count > 0;
        }
    }

    public boolean updateCategory(int id, String name, String type) {
        try (SqlSession session = MybatisUtil.getSession()) {
            int rows = session.getMapper(CourseCategoryMapper.class).updateCategory(id, name, type);
            session.commit();
            return rows > 0;
        }
    }

    public boolean hasCourses(int categoryId) {
        try (SqlSession session = MybatisUtil.getSession()) {
            int count = session.getMapper(CourseCategoryMapper.class)
                    .countCoursesUnderCategory(categoryId);
            return count > 0;
        }
    }

    public boolean deleteById(int id) {
        try (SqlSession session = MybatisUtil.getSession()) {
            int rows = session.getMapper(CourseCategoryMapper.class).deleteById(id);
            session.commit();
            return rows > 0;
        }
    }
}
