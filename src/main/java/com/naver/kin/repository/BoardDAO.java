package com.naver.kin.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.naver.kin.domain.BoardVO;
import com.naver.kin.domain.PagingVO;

public interface BoardDAO {
	int insert(BoardVO bvo);
	List<BoardVO> selectList(PagingVO pgvo);
	BoardVO selectOne(long bno);
	int update(BoardVO bvo);
	int delete(long bno);
	int selectTotalCount(PagingVO pgvo);
	long selectLastBno();
	int updateReadCount(@Param("bno")long pno, @Param("i") int i);
	int updateCmtQty(@Param("bno")long pno, @Param("i") int i);
}
