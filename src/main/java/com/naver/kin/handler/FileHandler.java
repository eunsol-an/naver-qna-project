package com.naver.kin.handler;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.naver.kin.domain.FileVO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Component
public class FileHandler {
	private final String UP_DIR = "C:\\_java\\lec\\_spring\\uploaded";

	public List<FileVO> getFileList(MultipartFile[] files) {
		LocalDate date = LocalDate.now();
		String today = date.toString();
		today = today.replace("-", File.separator);
		
		File folder = new File(UP_DIR, today);
		
		if (!folder.exists()) {
			folder.mkdirs();
		}
		
		List<FileVO> fileList = new ArrayList<FileVO>();
		for (MultipartFile file : files) {
			FileVO fvo = new FileVO();
			fvo.setSaveDir(today);
			fvo.setFileSize(file.getSize());
			
			String originalFileName = file.getOriginalFilename();
			String onlyFileName = originalFileName.substring(
					originalFileName.lastIndexOf("\\")+1);
			fvo.setFileName(onlyFileName);
			
			UUID uuid = UUID.randomUUID();
			fvo.setUuid(uuid.toString());
			
			String fullFileName = uuid.toString() + "_" + onlyFileName;
			File storeFile = new File(folder, fullFileName);
			
			try {
				file.transferTo(storeFile);
				if(isImageFile(storeFile)) {
					File thumbNail = new File(folder, uuid.toString() + "_th_" + onlyFileName);
					Thumbnails.of(storeFile).size(100, 100).toFile(thumbNail);
				}
			} catch (Exception e) {
				log.debug(">>> File 객체 물리디시스크에 저장 실패");
				e.printStackTrace();
			}
			fileList.add(fvo);
		}
		return fileList;
	}

	private boolean isImageFile(File storeFile) throws IOException {
		String mimeType = new Tika().detect(storeFile);
		return mimeType.startsWith("image") ? true : false;
	}
}
