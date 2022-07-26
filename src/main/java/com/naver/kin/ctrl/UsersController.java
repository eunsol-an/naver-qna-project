package com.naver.kin.ctrl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.kin.domain.PagingVO;
import com.naver.kin.domain.UsersVO;
import com.naver.kin.handler.PagingHandler;
import com.naver.kin.service.UsersService;

@Controller
@RequestMapping("/users/*")
public class UsersController {
	private static Logger log = LoggerFactory.getLogger(UsersController.class);
	
	@Inject
	private UsersService usv;
	
	@GetMapping("/register")
	public void register() {
	}
	@PostMapping("/register")
	public String register(UsersVO uvo) {
		int isUp = usv.register(uvo);
		log.info(">>> UsersController > register : {} ", isUp > 0 ? "OK" : "FAIL");
		return "redirect:/";
	}
	@GetMapping("/list")
	public void list(Model model
			, PagingVO pgvo) {
		List<UsersVO> list = usv.getList(pgvo);
		model.addAttribute("list", list);
		model.addAttribute("pgn", new PagingHandler(pgvo, usv.getTotalCount(pgvo)));
	}
	@GetMapping(value = {"/detail", "/modify"})
	public void detail(Model model
			, @RequestParam("email") String email
			, @ModelAttribute("pgvo") PagingVO pgvo) {
		model.addAttribute("uvo", usv.getDetail(email));
	}
	@PostMapping("/modify")
	public String modify(UsersVO uvo
			, RedirectAttributes rttr
			, PagingVO pgvo) {
		int isUp = usv.modify(uvo);
		rttr.addAttribute("pageNo", pgvo.getPageNo());
		rttr.addAttribute("qty", pgvo.getQty());
		rttr.addAttribute("type", pgvo.getType());
		rttr.addAttribute("kw", pgvo.getKw());
		log.info(">>> UsersController > modify : {} ", isUp > 0 ? "OK" : "FAIL");
		return "redirect:/users/detail?email=" + uvo.getEmail();
	}
	@PostMapping("/remove")
	public String remove(UsersVO uvo
			, RedirectAttributes rttr
			, PagingVO pgvo) {
		int isUp = usv.remove(uvo.getEmail());
		rttr.addAttribute("pageNo", pgvo.getPageNo());
		rttr.addAttribute("qty", pgvo.getQty());
		rttr.addAttribute("type", pgvo.getType());
		rttr.addAttribute("kw", pgvo.getKw());
		log.info(">>> UsersController > remove : {} ", isUp > 0 ? "OK" : "FAIL");
		return "redirect:/users/list";
	}
	@GetMapping("/login")
	public void login() {
	}
	@PostMapping("/login")
	public String login(UsersVO uvo
			, HttpSession ses
			, RedirectAttributes rttr) {
		UsersVO sesUvo = usv.login(uvo);
		if (sesUvo != null) {
			ses.setAttribute("ses", sesUvo);
			ses.setMaxInactiveInterval(600);
			rttr.addFlashAttribute("isLogin", 1);
			log.info(">>> UsersController > login - OK");
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("isLogin", 1);
			return "redirect:/users/login";
		}
	}
	@GetMapping("/logout")
	public String logout(HttpSession ses
			, RedirectAttributes rttr) {
		ses.removeAttribute("ses");
		ses.invalidate();
		rttr.addFlashAttribute("isLogout", 1);
		log.info(">>> UsersController > logout - OK");
		return "redirect:/";
	}
	@ResponseBody
	@PostMapping(value = "/dupleCheck"
	, consumes = "application/json"
	, produces = {MediaType.TEXT_PLAIN_VALUE})
	public String dupleCheck(@RequestBody HashMap<String, String> map) {
		log.info(">>> {}", map.get("email"));
		int isExist = usv.dupleCheck(map.get("email"));
		return isExist > 0 ? "1" : "0";
	}
	
}
