package com.naver.kin.service;

import com.naver.kin.domain.CommentVO;
import com.naver.kin.domain.PagingVO;
import com.naver.kin.handler.PagingHandler;

public interface CommentService {
	int post(CommentVO cvo);
	PagingHandler getList(long bno, PagingVO pgvo);
	int modify(CommentVO cvo);
	int remove(CommentVO cvo);
	int removeAll(long bno);
}
