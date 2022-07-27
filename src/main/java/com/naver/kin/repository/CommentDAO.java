package com.naver.kin.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.naver.kin.domain.CommentVO;
import com.naver.kin.domain.PagingVO;

public interface CommentDAO {
	int insert(CommentVO cvo);
	List<CommentVO> selectList(@Param("bno") long bno, @Param("pgvo") PagingVO pgvo);
	int update(CommentVO cvo);
	int delete(long cno);
	int deleteAll(long bno);
	int selectTotalCount(long bno);
	long selectPno(long cno);
}
