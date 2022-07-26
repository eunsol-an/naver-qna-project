package com.naver.kin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.naver.kin.domain.PagingVO;
import com.naver.kin.domain.UsersVO;

@Service
public interface UsersService {
	int register(UsersVO uvo);
	UsersVO login(UsersVO uvo);
	List<UsersVO> getList(PagingVO pgvo);
	UsersVO getDetail(String email);
	int modify(UsersVO uvo);
	int remove(String email);
	int dupleCheck(String email);
	int getTotalCount(PagingVO pgvo);
}
