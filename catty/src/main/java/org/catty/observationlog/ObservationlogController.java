package org.catty.observationlog;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.util.PropertySource.Comparator;
import org.catty.cat.Cat;
import org.catty.cat.CatServiceImpl;
import org.catty.member.Member;
import org.catty.member.MemberServiceImpl;
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
@RequestMapping("/obslog")
public class ObservationlogController {
	@Autowired
	private ObservationLogServiceImpl observationLogService;
	@Autowired
	private MemberServiceImpl memberService;
	@Autowired
	private CatServiceImpl catService;
	
	@GetMapping("/form")
	public ModelAndView registerObservationLog() {
		ModelAndView mav = new ModelAndView("obsLog/register");
		//회원 정보 필요..
		
		mav.addObject("catList", catService.getCatList("", 0));
		
		return mav;
	}
	
	@PostMapping
	public ModelAndView registerObservationLog(ObservationLog observationLog, @RequestParam MultipartFile attach) {
		observationLogService.registerObservationLog(observationLog, attach);
		
		return new ModelAndView(new RedirectView("/obslog"));
	}
	
	@GetMapping
	public ModelAndView getObservationLogList() {
		ModelAndView mav = new ModelAndView("obsLog/list");
		
		return mav;
	}
	
	@GetMapping(consumes=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> getObservationLogList(ObservationLog observationLog, String name) {
		Map<String, Object> rows = new HashMap<String, Object>();
		
		List<Cat> catList = catService.getCatList(name, 0);
		if (name != null) {
			List<ObservationLog> obsLogList = new ArrayList<ObservationLog>();
			for (int i = 0; i < catList.size(); i++) {
				List<ObservationLog> obsLogs = new ArrayList<ObservationLog>();
				
				observationLog.setCatNo(catList.get(i).getNo());
				
				obsLogs = observationLogService.getObservationLogList(observationLog);
				obsLogList.addAll(obsLogs);
			}
			
			obsLogList.sort(new ObsComparator());
			rows.put("obsLogList", obsLogList);
		} else {
			rows.put("obsLogList", observationLogService.getObservationLogList(observationLog));
		}
		
		rows.put("memberList", memberService.getMemberList(""));
		rows.put("catList", catList);
		
		return rows; 
	}
	
	@GetMapping("/{no}")
	public ModelAndView getObservationLog(@PathVariable int no) {
		ModelAndView mav = new ModelAndView("obsLog/detail");
		
		ObservationLog observationLog = new ObservationLog();
		observationLog.setNo(no);
		observationLog = observationLogService.getObservationLog(observationLog);
		
		Member member = new Member();
		member.setNo(observationLog.getMemberNo());
		
		Cat cat = new Cat();
		cat.setNo(observationLog.getCatNo());
		
		Map<String, Object> row = new HashMap<String, Object>();
		row.put("obsLog", observationLog);
		row.put("member", memberService.getMember(member));
		row.put("cat", catService.getCat(cat));
		
		mav.addObject("row", row);
		
		return mav;
	}
	
	@GetMapping("/{no}/form")
	public ModelAndView editObservationLogForm(@PathVariable int no) {
		ModelAndView mav = new ModelAndView("obsLog/edit");
		
		ObservationLog observationLog = new ObservationLog();
		observationLog.setNo(no);
		observationLog = observationLogService.getObservationLog(observationLog);
		
		Map<String, Object> row = new HashMap<String, Object>();
		row.put("obsLog", observationLog);
		row.put("catList", catService.getCatList("", 0));
		
		mav.addObject("row", row);
		
		return mav;
	}
	
	@PutMapping("/{no}")
	public ModelAndView editObservationLog(@PathVariable int no, ObservationLog observationLog, @RequestParam MultipartFile attach) {
		ModelAndView mav = new ModelAndView(new RedirectView("/obslog/" + no));
		
		boolean result = observationLogService.editObservationLog(observationLog, attach);
		
		if (result) {
			
			return mav;
		}
		
		mav.setView(new RedirectView("/error"));
		return mav;
	}
	
	@DeleteMapping("/{no}")
	public ModelAndView deleteObservationLog(@PathVariable int no) {
		ModelAndView mav = new ModelAndView(new RedirectView("/obslog"));

		ObservationLog observationLog = new ObservationLog();
		observationLog.setNo(no);
		boolean result = observationLogService.deleteObservationLog(observationLog);
		
		if (result) {
			
			return mav;
		}
		
		mav.setView(new RedirectView("/error"));
		return mav;
	}
}
