package com.naver.kin.service;

import java.util.List;

import com.naver.kin.domain.BoardDTO;
import com.naver.kin.domain.BoardVO;
import com.naver.kin.domain.PagingVO;

public interface BoardService {
	int write(BoardDTO bdto);
	List<BoardVO> getList(PagingVO pgvo);
	BoardDTO getDetail(long bno);
	int modify(BoardDTO bdto);
	int remove(long bno);
	int getTotalCount(PagingVO pgvo);
	int removeFile(String uuid);
}
