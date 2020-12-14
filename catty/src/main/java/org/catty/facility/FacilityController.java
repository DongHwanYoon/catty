package org.catty.facility;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@RestController
@RequestMapping("/facility")
public class FacilityController {
	@Autowired
	private FacilityServiceImpl facilityService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@Autowired
	private CatServiceImpl catService;
	
	//등록 폼
	// [GET] ~/facility/form
	@GetMapping("/form")
	public ModelAndView registerFacility() {
		List<Facility> facilityList = facilityService.getFacilityList(""); //검색어가 공란이면 모두 조회해옴
		List<Member> memberList = getPossibleManager();
		Facility facility = new Facility();
		facility.setNo(-1);
		ModelAndView modelAndView = new ModelAndView("facility/register", "memberList", memberList);
		
		facility = (Facility) (facilityService.getFacility(facility).get("facility"));
		modelAndView.addObject("facilityList", facilityList);		
		modelAndView.addObject("tempFacility", facility);
		
		return modelAndView;
	}
	
	//등록
	//[POST] ~/facility
	@PostMapping
	public ModelAndView registerFacility(Facility facility,
			ManagementFacility managementFacility,
			FeedBarrel feedBarrel,
			WaterBarrel waterBarrel) {
		
		 if (facilityService.registerFacility(facility, managementFacility,
		 feedBarrel, waterBarrel)) { 
			 return new ModelAndView("facility/list"); 
		 }
		return new ModelAndView("facility/list");
	}
	
	//목록 조회 폼
	//[GET] ~/facility
	@GetMapping
	public ModelAndView getFacilityList() {	//form
		ModelAndView modelAndView = new ModelAndView("facility/list");
		return modelAndView;
	}
	
	//목록 조회 (비동기 방식)
	//[GET] ~/facility
	@GetMapping(consumes=MediaType.APPLICATION_JSON_VALUE)
	public Map<Object, Object> getFacilityList(String term) {
		Map<Object, Object> rows = new HashMap<>();
		
		List<Facility> facilityList = facilityService.getFacilityList(term);
		
		List<FeedBarrel> feedBarrelList = null;
		List<WaterBarrel> waterBarrelList = null;
		
		int i = -1;
		for (Facility facility : facilityList) {
			feedBarrelList = facilityService.getFeedBarrelList(facility.getNo());
			waterBarrelList = facilityService.getWaterBarrelList(facility.getNo());
			
			i++;
			if (facility.getType().equals("F")) {
				
				if (feedBarrelList != null) {
					for (FeedBarrel feedBarrel : feedBarrelList) {
							rows.put(i , feedBarrel.getSupplementStatus());
//						if (feedBarrel.getSupplementStatus().equals("X")) {
//							rows.put(i, "보충 필요 없음");
//						} 
////						if (feedBarrel.getSupplementStatus().equals("O")) {
////							rows.put(i, "보충 필요");
////						}
					}
				}
				
				if (waterBarrelList != null) {
					for (WaterBarrel waterBarrel : waterBarrelList) {
						rows.put(i , waterBarrel.getSupplementStatus());
						
//						if (waterBarrel.getSupplementStatus().equals("X")) {
//							rows.put(i, "보충 필요 없음");
//						} 
////						if (waterBarrel.getSupplementStatus().equals("O")) {
////							rows.put(i, "보충 필요");
////						}
					}
				}
			}
		}
		
		//그냥 여기서 rows에 넣기전에 계산 다한다음 ox 만 넣어버리자
	    rows.put("facilityList", facilityList);
	    return rows; 
	}
	
	//조회
	//[GET] ~/facility/{facilityNo}
	@GetMapping("/{facilityNo}")
	public ModelAndView getFacility(@PathVariable int facilityNo) {
		Facility facility = new Facility();
		facility.setNo(facilityNo);
		
		Map<String, Object> facilityMap = facilityService.getFacility(facility);
		facility = (Facility) facilityMap.get("facility");
		ModelAndView modelAndView = new ModelAndView("facility/detail", "facility", facility);
		
		if (facilityMap.get("memberList") != null) {
			modelAndView.addObject("memberList", facilityMap.get("memberList"));
		}
		
		if (facilityMap.get("feedBarrelList") != null) {
			modelAndView.addObject("feedBarrelList", facilityMap.get("feedBarrelList"));
		}
		
		if (facilityMap.get("waterBarrelList") != null) {
			modelAndView.addObject("waterBarrelList", facilityMap.get("waterBarrelList"));
		}
		
		return modelAndView;
	}
	
	@GetMapping(value="/{no}", consumes=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> getCatRenew(Facility facility) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("facility", (Facility)facilityService.getFacility(facility).get("facility"));
		
		map.put("facilityList", facilityService.getFacilityList(""));
		
		return map;
	}
	
	//[GET] ~/facility/{facilityNo}/form
	//수정 폼
	@GetMapping("/{facilityNo}/form")
	public ModelAndView editFacility(@PathVariable int facilityNo) {
		//시설물 정보를 가져와서 폼에 보여줌
		Facility facility = new Facility();
		facility.setNo(facilityNo);
		Map<String, Object> facilityMap = facilityService.getFacility(facility);
		//이 시설물을 담당하고 잇는 담당자를 넣을 자료구조
		List<Member> managerList = new ArrayList<>();
		//시설물 관리 테이블에서 이 시설물을 기준으로 회원 목록을 가져옴
		List<ManagementFacility> managementFacilityList = facilityService.getManagementFacilityList(facility);
		//테이블에 존재하는 모든 회원을 가져옴 >> sql문으로 조건을 걸어서 가져오는게 맞는듯...
		List<Member> memberList = memberService.getMemberList("");

		//이 시설물을 담당하고있는 회원을 꺼냄
		for (int i = 0 ; i < memberList.size() ; i++) {
			for (int j = 0; j < managementFacilityList.size(); j++ ) {
				//테이블에서 이 시설물을 담당하는 담당자는 따른 자료구조에 저장한다 (수정폼에서 바로 볼 수 있도록 따로 구분)
				if (memberList.get(i).getNo() == managementFacilityList.get(j).getMemberNo()) {
					managerList.add(memberList.get(i));
				}
			}
		}
		
		//담당 시설물이 2개이하인 목록에서 이미 이 시설물을 담당하고 잇는 담당자는 빼버림 (왼쪽 셀렉트 박스에들어있는데 오른쪽에도 들어있으면 안되기때문)
		memberList = getPossibleManager();
		Iterator it = memberList.iterator();
		
		while(it.hasNext()) {
			Member member = (Member) it.next();
			for (Member manager : managerList) {
				if (member.getNo() == manager.getNo()) {
					it.remove();
				}
			}
		}
		//결론. 시설물을 3개 담당하고 있어도 이 시설물을 담당한다면 수정 폼에서 담당자 셀렉트 박스에 표시해주고 3개를 담당하고있지만 이 시설물을 담당하지않으면
			//아예 표시하지 않는다 ( 수정 불가능 하도록 )
		
		List<FeedBarrel> feedBarrelList = (List<FeedBarrel>)facilityMap.get("feedBarrelList");
		List<WaterBarrel> waterBarrelList = (List<WaterBarrel>)facilityMap.get("waterBarrelList");
		
		ModelAndView modelAndView = new ModelAndView("facility/edit", "facility", (Facility)facilityMap.get("facility"));
		modelAndView.addObject("memberList", memberList);		//담당 시설물이 2개 이하인 담당자 목록
		modelAndView.addObject("managerList", managerList);		//현재 시설물을 담당하고 있는 담당자 목록
		modelAndView.addObject("feedBarrelList", feedBarrelList);
		modelAndView.addObject("waterBarrelList", waterBarrelList);
		
		return modelAndView;
	}
	
	//[PUT] ~/facility
	//수정
	@PutMapping
	public ModelAndView editFacility(Facility facility,
			ManagementFacility managementFacility,
			FeedBarrel feedBarrel,
			WaterBarrel waterBarrel) {
		//입력한 시설물 정보를 db에 갱신함
		
		//수정 폼에서 가져온 회원 목록 + 담당자 목록
		List<ManagementFacility> managementFacilityList = managementFacility.getManagementFacilityList();
		//DB에서 가져온 모든 담당자 목록
		List<ManagementFacility> managerList = facilityService.getManagementFacilityList(facility);
		
		Iterator it = managementFacilityList.iterator();
		
		while (it.hasNext()) {
			//등록할 담당자
			ManagementFacility registManagementFacility = (ManagementFacility) it.next();
			
			//음수인경우 = 담당자 추가 셀렉트 박스에있었을 경우 (오른쪽)
			if (registManagementFacility.getMemberNo() < 0) {
				System.out.println(registManagementFacility.getMemberNo());
				registManagementFacility.setMemberNo(registManagementFacility.getMemberNo()*(-1));
				String str = registManagementFacility.getMemberNo()+registManagementFacility.getFacilityNo()+"";
				
				for (ManagementFacility manager : managerList) {
					String str2 = manager.getMemberNo()+manager.getFacilityNo()+"";
					
					//managementFacility 테이블에 추가하려는 memberNo + facilityNo 문자열과 같은 로우가 있으면 해당 로우는 뺀다. (이미 등록 되어있던 담당자임)
					if (str.equals(str2)) {
						it.remove();
					}
				}
				//양수인경우 = 그냥 회원 목록 셀렉트 박스에잇었을 경우 (왼쪽)
			} else {
				String str = registManagementFacility.getMemberNo()+registManagementFacility.getFacilityNo()+"";
				
				for (ManagementFacility manager : managerList) {
					String str2 = manager.getMemberNo()+manager.getFacilityNo()+"";
					
					//왼쪽 셀렉트 박스에 있는데 테이블에 같은 로우가 존재한다면 해당 로우는 제거한다.
					if (str.equals(str2)) {
						facilityService.deleteManagementFacilityList(registManagementFacility);
					}
				}
				//왼쪽 셀렉트 박스에 존재하는 회원들은 담당자 등록이 아니기때문에 그냥 추가할 담당자 목록 리스트에서 제거한다.
				it.remove();
			}
		}
		//managementFacility 테이블에 없는 담당자를 등록
		for (ManagementFacility registManager : managementFacilityList) {
			facilityService.registerManagementFacility(registManager);
		}
		
		facilityService.editFacility(facility, feedBarrel, waterBarrel);
		
		return new ModelAndView(new RedirectView("/facility/"+facility.getNo()));
	}
	
	//[DELETE] ~/facility/{facilityNo}
	//삭제
	@DeleteMapping("/{facilityNo}")
	public ModelAndView deleteFacility(@PathVariable int facilityNo) {
		//시설물 정보 삭제
		Facility facility = new Facility();
		facility.setNo(facilityNo);
		facilityService.deleteFacility(facility);
		
		return new ModelAndView(new RedirectView("/facility"));
	}
	
	@PostMapping("/data")	//수정필요
	//정보 저장(갱신)
	public void saveData(@RequestBody Map<String, Object> object) {
		//시설물 정보 가져옴
		Facility facility = new Facility();
		facility.setUid(object.get("uid").toString());
		
		System.out.println("시설물 일련번호 : " + facility.getUid());
		
		facility = (Facility) facilityService.getFacility(facility).get("facility");
		
		
		List<Map<String, Object>> feedBarrelList_ = (List<Map<String, Object>>) object.get("feedBarrel");
		List<FeedBarrel> feedBarrelList = null;
		if (feedBarrelList_ != null) {
			feedBarrelList = new ArrayList<FeedBarrel>();
			
			System.out.println("사료통 갯수 : " + feedBarrelList_.size());
			
			for (int i = 0 ; i < feedBarrelList_.size() ; i++) {
				feedBarrelList.add(new FeedBarrel());
				feedBarrelList.get(i).setNo((int) (feedBarrelList_.get(i).get("no")));
				feedBarrelList.get(i).setCapacity((int) (feedBarrelList_.get(i).get("capacity")));
				feedBarrelList.get(i).setStatus((feedBarrelList_.get(i).get("status").toString()));
				
				System.out.println((feedBarrelList_.get(i).get("no")) + "번 사료통 정보 : " + feedBarrelList_.get(i).toString());
			}
		}
		
		
		List<Map<String, Object>> waterBarrelList_ = (List<Map<String, Object>>) object.get("waterBarrel");
		List<WaterBarrel> waterBarrelList = null;
		if (waterBarrelList_ != null) {
			waterBarrelList = new ArrayList<WaterBarrel>();
			System.out.println("물통 갯수 : " + feedBarrelList.size());
			
			for (int i = 0 ; i < waterBarrelList_.size() ; i++) {
				waterBarrelList.add(new WaterBarrel());
				waterBarrelList.get(i).setNo((int) (waterBarrelList_.get(i).get("no")));
				waterBarrelList.get(i).setCapacity((int) (waterBarrelList_.get(i).get("capacity")));
				waterBarrelList.get(i).setStatus((waterBarrelList_.get(i).get("status").toString()));
				
				System.out.println((i + 1) + "번 물통 정보 : " + waterBarrelList_.get(i).toString());
			}
		}
		
		Map<String, Object> accessInfo = (Map<String, Object>) object.get("accessRecord"); 
		
		//시설물정보가 null이 아닌경우
		if (facility != null) {
			if (facility.getNo() != -1) {
				if (accessInfo != null) {
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
				
				if (feedBarrelList != null) {
					facilityService.editFeedBarrelList(facility, feedBarrelList);
				}
				
				if (waterBarrelList != null) {
					facilityService.editWaterBarrelList(facility, waterBarrelList);
				}
			} else {
				facility.setUid(object.get("uid").toString());
				facilityService.setTempFacilityUid(facility);
			}
		} else {
			try {
				facility = new Facility();
				facility.setName("");
				facility.setStatus("O");
				facility.setType("F");
				facility.setUid(object.get("uid").toString());
				facilityService.setTempFacilityUid(facility);
			} catch (Exception e) {
				System.out.println("에이전트 정보 저장 오류");
			}
		}
	}
	
//	//시설물 물통 정보 목록 갱신(수정)
//	@PutMapping(value = "/{facilityUid}/waterBarrel" , consumes = MediaType.APPLICATION_JSON_VALUE)
//	public void editWaterBarrelList(@PathVariable String facilityUid, WaterBarrel waterBarrel) {
//		Facility facility = new Facility();
//		facility.setUid(facilityUid);
//		facility = (Facility) facilityService.getFacility(facility).get("facility");
//		
//		if (facility != null) {
//			facilityService.editFacilityWaterBarrelList(facility, waterBarrel);
//		}
//	}
	
	private List<Member> getPossibleManager() {
		List<Member> memberList = memberService.getMemberList("");
		List<ManagementFacility> managerList = facilityService.getManagementFacilityList(new Facility());
		
		//담당 시설물이 3개 이상인 회원은 memberList에서 삭제하는 알고리즘
		Iterator it = memberList.iterator();
		while (it.hasNext()) {
			Member member = (Member) it.next();
			int count = 0 ;
			for (ManagementFacility manager : managerList) {
				if (member.getNo() == manager.getMemberNo()) {
					count++;
					if (count >= 3) {
						it.remove();
					}
				}
			}
		}
		return memberList;
	}
}