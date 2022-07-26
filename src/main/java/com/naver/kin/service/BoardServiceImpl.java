package com.naver.kin.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.naver.kin.domain.BoardDTO;
import com.naver.kin.domain.BoardVO;
import com.naver.kin.domain.FileVO;
import com.naver.kin.domain.PagingVO;
import com.naver.kin.repository.BoardDAO;
import com.naver.kin.repository.FileDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO bdao;
	
	@Inject
	private FileDAO fdao;

	@Override
	public int write(BoardDTO bdto) {
		int isUp = bdao.insert(bdto.getBvo());
		if (bdto.getFileList() != null && isUp > 0) {
			long bno = bdao.selectLastBno();
			for (FileVO fvo : bdto.getFileList()) {
				fvo.setBno(bno);
				isUp *= fdao.insertFile(fvo);
			}
		}
		return isUp;
	}

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		return bdao.selectList(pgvo);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardDTO getDetail(long bno) {
		bdao.updateReadCount(bno, 1);
		return new BoardDTO(bdao.selectOne(bno), fdao.selectListFile(bno));
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public int modify(BoardDTO bdto) {
		int isUp = bdao.update(bdto.getBvo());
		if (bdto.getFileList() != null && isUp > 0) {
			for (FileVO fvo : bdto.getFileList()) {
				fvo.setBno(bdto.getBvo().getBno());
				isUp *= fdao.insertFile(fvo);
			}
		}
		isUp *= bdao.updateReadCount(bdto.getBvo().getBno(), -2);
		return isUp;
	}

	@Override
	public int remove(long bno) {
		int isUp = bdao.delete(bno);
		if (isUp > 0) {
			isUp = fdao.deleteAllFile(bno);
		}
		return isUp;
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		return bdao.selectTotalCount(pgvo);
	}

	@Override
	public int removeFile(String uuid) {
		return fdao.deleteFile(uuid);
	}

}
