package org.catty.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

@RestController
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberServiceImpl memberService;
	
	@GetMapping("/join")
	public ModelAndView joinMember() {
		return new ModelAndView("member/join");
	}
	
	@PostMapping("/join")
	public ModelAndView joinMember(JoinInfo joinInfo, RedirectAttributes redirectAttributes) throws IOException {
		boolean isRegistered  = memberService.joinMember(joinInfo);
		
		if (isRegistered) {
			System.out.println("회원 가입 성공?" + isRegistered);
			
			redirectAttributes.addFlashAttribute("message", "registered");
			
			return new ModelAndView(new RedirectView("/common/login"));
			
		}
		
		redirectAttributes.addFlashAttribute("message", "notRegistered");
		
		return new ModelAndView(new RedirectView("/member/join"));
	}
	
	@GetMapping
	public ModelAndView memberList(String term) {
		
		return new ModelAndView("member/list");
	}
	
	@GetMapping(consumes=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> memberList(Member member) {
		Map<String, Object> rows = new HashMap<String, Object>();
		rows.put("memberList", memberService.getMemberList(member.getName()));
		
		return rows;
	}
	
	@GetMapping("/{no}")
	public ModelAndView getMember(@PathVariable int no) {
		Member member = new Member();
		member.setNo(no);
		
		return new ModelAndView("member/detail" , "member", memberService.getFacilityInChargeList(member));
	}
	
	@GetMapping("/{no}/form")
	public ModelAndView editMember(@PathVariable int no) {
		Member member = new Member();
		member.setNo(no);
		
		
		return new ModelAndView("member/edit", "member", memberService.getFacilityInChargeList(member));
	}
	
	@PutMapping("/{no}")
	public ModelAndView editMember(JoinInfo joinInfo) {
		boolean isEdited = memberService.editMember(joinInfo);
		
		if (isEdited) {
			return new ModelAndView(new RedirectView("/member/" + joinInfo.getNo()));
		}
				
		return new ModelAndView(new RedirectView("/member/" + joinInfo.getNo() + "/form"));
	}
	
	@DeleteMapping("/{no}")
	public ModelAndView deleteMember(@PathVariable int no, RedirectAttributes redirectAttributes) {
		//관리자일 경우 삭제 불가
		Member member = new Member();
		member.setNo(no);
		member = memberService.getMember(member);
		
		System.out.println("권한값 : " + member.getAuthority());
		
		if (member.getAuthority().equals("A")) {
			System.out.println("관리자는 탈퇴할 수 없습니다.");
			
			redirectAttributes.addFlashAttribute("message", "rejected");
			
			return new ModelAndView(new RedirectView("/member"));
		}
		
		boolean isDeleted = memberService.withdrawal(member);
		if (isDeleted) {
			redirectAttributes.addFlashAttribute("message", "isDeleted");
			
			return new ModelAndView(new RedirectView("/member"));
		}
		
		return new ModelAndView(new RedirectView("/member/" + member.getNo() + "/form"));
	}
}