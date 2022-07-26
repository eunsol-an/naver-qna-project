package com.naver.kin.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FileVO {
	private String uuid;
	private String saveDir;
	private String fileName;
	private long bno;
	private long fileSize;
	private String regAt;
}
