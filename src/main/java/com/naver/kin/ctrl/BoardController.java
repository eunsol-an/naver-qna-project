package com.naver.kin.ctrl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.kin.domain.FileVO;
import com.naver.kin.domain.PagingVO;
import com.naver.kin.domain.BoardDTO;
import com.naver.kin.domain.BoardVO;
import com.naver.kin.handler.FileHandler;
import com.naver.kin.handler.PagingHandler;
import com.naver.kin.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Inject
	private BoardService bsv;
	
	@Inject
	private FileHandler fhd;
	
	@GetMapping("/write")
	public void write() {
	}
	@PostMapping("/write")
	public String write(BoardVO bvo
			, @RequestParam(name = "fileAttached"
						, required = false) MultipartFile[] files) {
		List<FileVO> fileList = null;
		if (files[0].getSize() > 0) {
			fileList = fhd.getFileList(files);
			bvo.setFileCount(fileList.size());
		}
		int isUp = bsv.write(new BoardDTO(bvo, fileList));
		log.info(">>> BoardController > write - POST : {}", isUp > 0 ? "OK" : "FAIL");
		return "redirect:/board/list";
	}
	@GetMapping("/list")
	public void list(Model model
				, PagingVO pgvo) {
		model.addAttribute("list", bsv.getList(pgvo));
		int totalCount = bsv.getTotalCount(pgvo);
		model.addAttribute("pgn", new PagingHandler(pgvo, totalCount));
	}
	@GetMapping(value = {"/detail", "/modify"})
	public void detail(Model model
			, @RequestParam("bno") long bno
			, @ModelAttribute("pgvo") PagingVO pgvo) {
		model.addAttribute("bdto", bsv.getDetail(bno));
	}
	@PostMapping("/modify")
	public String modify(BoardVO bvo
			, @RequestParam(name = "fileAttached", required = false) MultipartFile[] files
			, RedirectAttributes rttr
			, PagingVO pgvo) {
		List<FileVO> fileList = null;
		if (files[0].getSize() > 0) {
			fileList = fhd.getFileList(files);
			bvo.setFileCount(fileList.size());
		}
		int isUp = bsv.modify(new BoardDTO(bvo, fileList));
		
		rttr.addFlashAttribute("msg_mod", isUp);
		rttr.addAttribute("pageNo", pgvo.getPageNo());
		rttr.addAttribute("qty", pgvo.getQty());
		rttr.addAttribute("type", pgvo.getType());
		rttr.addAttribute("kw", pgvo.getKw());
		log.info(">>> BoardController > modify - POST : {}", isUp > 0 ? "OK" : "FAIL");
		return "redirect:/board/detail?bno=" + bvo.getBno();
	}
	@DeleteMapping(value = "/file/{uuid}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> removeFile(@PathVariable("uuid") String uuid) {
		return bsv.removeFile(uuid) > 0 ?
				new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") long bno
			, RedirectAttributes rttr
			, PagingVO pgvo) {
		int isUp = bsv.remove(bno);
		rttr.addFlashAttribute("msg_del", isUp);
		rttr.addAttribute("pageNo", pgvo.getPageNo());
		rttr.addAttribute("qty", pgvo.getQty());
		rttr.addAttribute("type", pgvo.getType());
		rttr.addAttribute("kw", pgvo.getKw());
		log.info(">>> BoardController > remove - POST : {}", isUp > 0 ? "OK" : "FAIL");
		return "redirect:/board/list";
	}
}
