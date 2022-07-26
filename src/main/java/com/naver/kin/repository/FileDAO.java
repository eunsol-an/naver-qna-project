package com.naver.kin.repository;

import java.util.List;

import com.naver.kin.domain.FileVO;

public interface FileDAO {
	int insertFile(FileVO fvo);
	List<FileVO> selectListFile(long bno);
	int deleteFile(String uuid);
	int deleteAllFile(long bno);
	List<FileVO> selectAllFiles();
}
