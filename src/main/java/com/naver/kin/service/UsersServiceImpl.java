package com.naver.kin.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.naver.kin.domain.PagingVO;
import com.naver.kin.domain.UsersVO;
import com.naver.kin.repository.UsersDAO;

@Service
public class UsersServiceImpl implements UsersService {
	
	@Inject
	private UsersDAO udao;

	@Override
	public int register(UsersVO uvo) {
		return udao.insert(uvo);
	}

	@Override
	public UsersVO login(UsersVO uvo) {
		return udao.selectOne(uvo);
	}

	@Override
	public List<UsersVO> getList(PagingVO pgvo) {
		return udao.selectList(pgvo);
	}

	@Override
	public UsersVO getDetail(String email) {
		return udao.selectDetail(email);
	}

	@Override
	public int modify(UsersVO uvo) {
		return udao.update(uvo);
	}

	@Override
	public int remove(String email) {
		return udao.delete(email);
	}

	@Override
	public int dupleCheck(String email) {
		return udao.selectEmail(email);
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		return udao.selectTotalCount(pgvo);
	}

}
