package org.catty.cat;

import java.util.HashMap;
import java.util.Map;

import org.catty.facility.Facility;
import org.catty.facility.FacilityServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@RestController
@RequestMapping("/cat")
public class CatController {
	@Autowired
	private CatServiceImpl catService;
	@Autowired
	private FacilityServiceImpl facilityService;
	
	@GetMapping("/form")
	public ModelAndView registerCat() {
		
		ModelAndView mav = new ModelAndView("cat/register");
		
		Cat cat = new Cat();
		cat.setNo(-1);
		cat = catService.getCat(cat);
		System.out.println(cat);
		
		mav.addObject("cat", cat);
		
		return mav;
	}
	
	@PostMapping
	public ModelAndView registerCat(Cat cat,@RequestParam MultipartFile attach) {
		ModelAndView mav = new ModelAndView();
		
		boolean result = catService.registerCat(cat, attach);
		
		//성공
		if (result) {
			mav.setView(new RedirectView("/cat"));
			
			return mav;
		}
		
		//실패
		mav.setView(new RedirectView("/error"));
		
		return mav;
	}
	
	@GetMapping
	public ModelAndView getCatList() {
		ModelAndView mav = new ModelAndView("cat/list");
		
		return mav;
	}
	
	@GetMapping(consumes=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> getCatList(Cat cat, int sort) {
		Map<String, Object> rows = new HashMap<String, Object>();
		rows.put("catList", catService.getCatList(cat.getName(), sort));
		rows.put("accessList", catService.getAccessRecordForTime(cat));
		rows.put("facilityList", facilityService.getFacilityList(null));
		
		return rows; 
	}
	
	@GetMapping("/data/map/{no}")
	public Map<String, Object> getAccessMap(@PathVariable int no) {
		Map<String, Object> row = new HashMap<String, Object>();

		Cat cat = new Cat();
		cat.setNo(no);
		
		AccessRecord accessRecord = catService.getAccessRecord(cat);
		if (accessRecord != null) {
			row.put("access", accessRecord);
			
			Facility facility = new Facility();
			facility.setNo(accessRecord.getFacilityNo());
			
			Map<String, Object> facilityInfo = facilityService.getFacility(facility);
			if (facilityInfo != null) {
				row.put("facility", facilityInfo);
			}
		}
		
		return row; 
	}
	
	@GetMapping("/data/list/{no}")
	public Map<Object, Object> getAccessList(@PathVariable int no) {
		Cat cat = new Cat();
		cat.setNo(no);
		
		Map<Object, Object> rows = new HashMap<Object, Object>();
		rows.put("accessList", catService.getAccessRecordList(cat));
		rows.put("facilityList", facilityService.getFacilityList(""));
		
		return rows; 
	}
	
	@GetMapping("/{no}")
	public ModelAndView getCat(@PathVariable int no) {
		ModelAndView mav = new ModelAndView();
		
		Cat cat = new Cat();
		cat.setNo(no);
		cat = catService.getCat(cat);
		if (cat != null) {
			mav.addObject("cat", cat);
			
			mav.setViewName("cat/detail");
			return mav;
		}
		
		mav.setView(new RedirectView("/error"));
		return mav;
	}
	
	@GetMapping(value="/{no}", consumes=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> getCatRenew(Cat cat) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("cat", catService.getCat(cat));
		
		map.put("catList", catService.getCatList("", 0));
		
		return map;
	}
	
	
	@GetMapping("/{no}/form")
	public ModelAndView editCat(@PathVariable int no) {
		ModelAndView mav = new ModelAndView("cat/edit");
		
		Cat cat = new Cat();
		cat.setNo(no);
		mav.addObject("cat", catService.getCat(cat));
		
		return mav;
	}
	
	@PutMapping("/{no}")
	public ModelAndView editCat(@PathVariable int no, Cat cat, MultipartFile attach) {
		ModelAndView mav = new ModelAndView();
		
		boolean result = catService.editCat(cat, attach);
		
		if (result) {
			mav.setView(new RedirectView("/cat/" + cat.getNo()));
			
			return mav;
		}
		
		mav.setView(new RedirectView("/error"));
		
		return mav;
	}
	
	@DeleteMapping("/{no}")
	public ModelAndView deleteCat(@PathVariable int no) {
		ModelAndView mav = new ModelAndView();
		
		Cat cat = new Cat();
		cat.setNo(no);

		boolean result = catService.deleteCat(cat);
		if (result) {
			mav.setView(new RedirectView("/cat"));
			
			return mav;
		}
		
		mav.setView(new RedirectView("/error"));
		
		return mav;
	}
	
	@PostMapping("/data")
	public void saveCatAccessData(@RequestBody Map<String, Object> object) {
		if (object != null) {
			System.out.println("날라온 접근정보 : " + object + " from CatController");
		}
		Map<String, Object> accessInfo = (Map<String, Object>) object.get("accessRecord"); 
		
		Cat cat = new Cat();
		cat.setTagId(accessInfo.get("uid").toString());
		
		boolean isCheck = catService.setTagId(cat);
		if(isCheck) {
			cat.setNo(-1);
			cat = catService.getCat(cat);
			System.out.println("no:" + cat.getNo() + "/ tagId:" + cat.getTagId());
		}
		
		boolean isResult= catService.saveAccessRecord(object);
	}
}
