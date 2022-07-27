package com.naver.kin.handler;

import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.naver.kin.domain.FileVO;
import com.naver.kin.repository.FileDAO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@AllArgsConstructor
public class FileSweepHandler {
	private final String UP_DIR = "C:\\_java\\lec\\_spring\\uploaded\\";
	
	@Inject
	private FileDAO fdao;
	
	@Scheduled(cron = "1 0 01 * * *")
	public void fileSweeper() throws Exception {
		log.info(">>> fileSweeper Runccing Start : {}", LocalDateTime.now());
		
		List<FileVO> dbFileList = fdao.selectAllFiles();
		
		List<String> savedFileList = new ArrayList<>();
		for (FileVO fvo : dbFileList) {
			String filePath = fvo.getSaveDir() + "\\" + fvo.getUuid();
			String fileName = fvo.getFileName();
			savedFileList.add(UP_DIR + filePath + "_" + fileName);
			savedFileList.add(UP_DIR + filePath + "_th_" + fileName);
		}
		
		LocalDate now = LocalDate.now();
		String targetDay = now.toString();
		targetDay = targetDay.replace("-", File.separator);
		
		File dir = Paths.get(UP_DIR + targetDay).toFile();
		File[] allFileObjects = dir.listFiles();
		
		for (File file : allFileObjects) {
			String storedFileName = file.toPath().toString();
			if (!savedFileList.contains(storedFileName)) {
				file.delete();
				log.info(">>> deleted file : {}", storedFileName);
			}
		}
		log.info(">>> fileSweeper Runccing Finish : {}", LocalDateTime.now());
	}
}
