package com.naver.kin.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVO {
	private long bno;
	private String category;
	private String title;
	private String writer;
	private String description;
	private int readCount;
	private int cmtQty;
	private int fileCount;
	private String regAt;
	private String modAt;
}
