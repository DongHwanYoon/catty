package org.catty.common;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.catty.member.MemberServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

@RestController
@RequestMapping("/common")
public class CommonController {
	@Autowired
	private LoginServiceImpl loginService;
	@Autowired
	private MemberServiceImpl memberService;
	
	@GetMapping
	public ModelAndView test() {
		return new ModelAndView("common/회원상세");
	}
	
	@GetMapping("/login")
	public ModelAndView login(LoginInfo loginInfo, @CookieValue(value = "rememberId", required = false) Cookie cookie) {
		System.out.println("쿠키는 널이야?");
		if (cookie != null) {
			System.out.println("쿠키는 널이 아니지롱");
			loginInfo.setId(cookie.getValue());
		}
		
		return new ModelAndView("common/login");
	}
	
	@GetMapping("/idCheck")
	public boolean idCheck(@RequestParam("id") String id) {
		
		System.out.println("아이디 : " + id);
		System.out.println(memberService.checkIdDuplication(id));
		
		return memberService.checkIdDuplication(id);
	}

	
	@PostMapping("/login")
	public ModelAndView login(LoginInfo loginInfo, HttpSession session, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		boolean isLogin = loginService.login(loginInfo);
		
		System.out.println("!!!!!!!!!!!!!" + loginInfo.isRemember());
		
		if (isLogin) {
			Cookie cookie = new Cookie("rememberId", loginInfo.getId());
			
			System.out.println("##############");
			System.out.println(loginInfo.isRemember() == true);
			if (loginInfo.isRemember()) {
				cookie.setMaxAge(60 * 60 * 3);
			} else {
				cookie.setMaxAge(0);
			}
			
			response.addCookie(cookie);
			
			return new ModelAndView(new RedirectView("/cat"));
		} 
		
		redirectAttributes.addFlashAttribute("message", "unlogged");
		
		return new ModelAndView(new RedirectView("/common/login"));
	}
	
	@GetMapping("/logout")
	public ModelAndView logout() {
		loginService.logout();
		
		return new ModelAndView(new RedirectView("/common/login"));
	}
}