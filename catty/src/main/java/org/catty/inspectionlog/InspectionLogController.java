package org.catty.inspectionlog;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.catty.facility.Facility;
import org.catty.facility.FacilityServiceImpl;
import org.catty.member.Member;
import org.catty.member.MemberServiceImpl;
import org.catty.photo.Photo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@RestController
@RequestMapping("/inslog")
public class InspectionLogController {
	@Autowired
	private InspectionLogServiceImpl inspectionLogService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private FacilityServiceImpl facilityService;
	
	//등록 폼
	@GetMapping("/form")
	public ModelAndView registerInsLog() {
		ModelAndView modelAndView = new ModelAndView("insLog/register");
		modelAndView.addObject("facilityList", facilityService.getFacilityList(""));
		
		return modelAndView;
	}
	
	//등록 기능	
	@PostMapping
	public ModelAndView registerInsLog(InspectionLog inspectionLog, @RequestParam MultipartFile attach) { //multipartFile 이걸로 서버측 파일 시스템에 저정하고 관한 정보를 디비에 저장
		Member member = new Member();
		if (session.getAttribute("id") != null) {
			member.setId(session.getAttribute("id").toString());
			member.setNo(memberService.getMember(member).getNo());
		} else {
			//로그인해달라는 표시
			return new ModelAndView(new RedirectView("/common/login"));
		}

		inspectionLog.setMemberNo(memberService.getMember(member).getNo());
		String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		inspectionLog.setRegistrateDate(now);
		inspectionLog.setModifiedDate(now);
		
		inspectionLogService.registerInspectionLog(inspectionLog, attach);
		
		return new ModelAndView(new RedirectView("/inslog"));
	}

	//목록 조회 폼
	@GetMapping
	public ModelAndView getInsLogList(InspectionLog inspectionLog) {
		ModelAndView modelAndView = new ModelAndView("insLog/list");
		return modelAndView;
	}
	
	//목록 조회 기능
	@GetMapping(consumes=MediaType.APPLICATION_JSON_VALUE)
	public Map<Object, Object> getInsLogList(String term) {
	      Map<Object, Object> rows = new HashMap<>();
	      
	      List<InspectionLog> inspectionLogList = inspectionLogService.getInspectionLogList(term);
	      List<Facility> facilityList = facilityService.getFacilityList(term);
	      List<Member> memberList = new ArrayList();
	      Member member = new Member();
	     
	      
	      for (int i = 0 ; i < inspectionLogList.size() ; i++) {	//작성자명과 검색어는 다르기때문에 따로 구해와야함
	    	 int memberNo = inspectionLogList.get(i).getMemberNo();
	    	 member.setNo(memberNo);
	    	 memberList.add(memberService.getMember(member));
	      }
	      rows.put("inspectionLogList", inspectionLogList);
	      rows.put("facilityList", facilityList);
	      rows.put("memberList", memberList);
	      
	      return rows; 
	}
	
	//조회
	@GetMapping("/{inspectionLogNo}")
	public ModelAndView getInsLog(@PathVariable int inspectionLogNo) {
		InspectionLog inspectionLog = new InspectionLog();
		inspectionLog.setNo(inspectionLogNo);
		inspectionLog = inspectionLogService.getInspectionLog(inspectionLog);
		
		Facility facilityNo = new Facility();				//시설물 번호를 사용하기위한 시설물 객체
		facilityNo.setNo(inspectionLog.getFacilityNo());	//시설물 번호
		Map<String, Object> facilityMap = facilityService.getFacility(facilityNo);	//시설물 번호로 시설물 조회해옴
		Facility facility = (Facility)facilityMap.get("facility");	//시설물 번호로 찾아온 시설물 객채
		
		Member member = new Member();
		member.setNo(inspectionLog.getMemberNo());
		member = memberService.getMember(member);
		
		ModelAndView modelAndView = new ModelAndView("insLog/detail");
		modelAndView.addObject("inspectionLog", inspectionLog);
		modelAndView.addObject("member", member);
		modelAndView.addObject("facility", facility);
		
		return modelAndView;
	}
	
	//수정 폼
	@GetMapping("/{inspectionLogNo}/form")
	public ModelAndView editInsLog(@PathVariable int inspectionLogNo) {
		InspectionLog inspectionLog = new InspectionLog();
		inspectionLog.setNo(inspectionLogNo);
		inspectionLog = inspectionLogService.getInspectionLog(inspectionLog);
		
		Photo photo = new Photo();
		photo.setType("I");
		photo.setTypeNo(inspectionLogNo);
		
		Facility facilityNo = new Facility();				//시설물 번호를 사용하기위한 시설물 객체
		facilityNo.setNo(inspectionLog.getFacilityNo());	//시설물 번호
		Map<String, Object> facilityMap = facilityService.getFacility(facilityNo);	//시설물 번호로 시설물 조회해옴
		Facility facility = (Facility)facilityMap.get("facility");	//시설물 번호로 찾아온 시설물 객채
		
		ModelAndView modelAndView = new ModelAndView("insLog/edit");
		modelAndView.addObject("inspectionLog", inspectionLog);
		modelAndView.addObject("facility", facility);
		return modelAndView;
	}
	
	//수정
	@PutMapping
	public ModelAndView editInsLog(InspectionLog inspectionLog, @RequestParam MultipartFile attach) {
		if (inspectionLogService.editInspectionLog(inspectionLog, attach)) {
			ModelAndView modelAndView = new ModelAndView(new RedirectView("/inslog/"+inspectionLog.getNo()));
			return modelAndView;
		}
		return new ModelAndView(new RedirectView("/inslog"));
	}
	
	//삭제
	@DeleteMapping("/{inspectionLogNo}")
	public ModelAndView deleteInsLog(@PathVariable int inspectionLogNo) {
		InspectionLog inspectionLog = new InspectionLog();
		inspectionLog.setNo(inspectionLogNo);
		
		if (inspectionLogService.deleteInspectionLog(inspectionLog)) {
			ModelAndView modelAndView = new ModelAndView(new RedirectView("/inslog"));
			return modelAndView;
		}
		return new ModelAndView(new RedirectView("/inslog"));
	}
}
