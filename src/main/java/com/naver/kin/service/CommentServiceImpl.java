package com.naver.kin.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.kin.domain.CommentVO;
import com.naver.kin.domain.PagingVO;
import com.naver.kin.handler.PagingHandler;
import com.naver.kin.repository.BoardDAO;
import com.naver.kin.repository.CommentDAO;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Inject
	private CommentDAO cdao;
	
	@Inject
	private BoardDAO bdao;

	@Transactional
	@Override
	public int post(CommentVO cvo) {
		int isUp = cdao.insert(cvo);
		if (isUp > 0) {
			isUp = bdao.updateCmtQty(cvo.getBno(), 1);
		}
		return isUp;
	}

	@Override
	public PagingHandler getList(long bno, PagingVO pgvo) {
		return new PagingHandler(cdao.selectList(bno, pgvo), pgvo,
				cdao.selectTotalCount(bno));
	}

	@Override
	public int modify(CommentVO cvo) {
		return cdao.update(cvo);
	}

	@Transactional
	@Override
	public int remove(CommentVO cvo) {
		long bno = cdao.selectPno(cvo.getCno());
		int isUp = cdao.delete(cvo.getCno());
		if (isUp > 0) {
			isUp = bdao.updateCmtQty(bno, -1);
		}
		return isUp;
	}

	@Override
	public int removeAll(long bno) {
		return cdao.deleteAll(bno);
	}

}
