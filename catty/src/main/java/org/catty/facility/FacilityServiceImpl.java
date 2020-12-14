package org.catty.facility;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.catty.member.Member;
import org.catty.member.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class FacilityServiceImpl implements FacilityService{
	@Autowired
	private FacilityMapper facilityMapper;
	
	@Autowired
	private FeedBarrelMapper feedBarrelMapper;
	
	@Autowired
	private WaterBarrelMapper waterBarrelMapper;
	
	@Autowired
	private ManagementFacilityMapper managementFacilityMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Value("${facility.path.uidList}")
	private static String facilityUidListPath;
	
	//등록
	@Override
	public boolean registerFacility(Facility facility,
			ManagementFacility managementFacility,
			FeedBarrel feedBarrel,
			WaterBarrel waterBarrel) {
			facility.setStatus("O");
		int result = 0;
		try {
			//입력받은(입력한) 고유번호를 가진 시설물 (임시 시설물 삭제)
			Facility tempFacility = new Facility();
			tempFacility.setUid(facility.getUid());
			tempFacility = facilityMapper.selectFacility(tempFacility);
			
			if (tempFacility != null) {
				int count = facilityMapper.deleteFacility(tempFacility);
			}
			
			result = facilityMapper.insertFacility(facility);
			
			Facility facility_ = facilityMapper.selectFacility(facility);		//시설물을 미리 등록한후 시설물의 일련번호를 가져와야 사료통과 물통, 담당자를 추가 할 수 있다. (FK) 
																		//따라서 시설물의 정보를 다시 가져옴
			List<FeedBarrel> feedBarrelList = feedBarrel.getFeedBarrelList();
			List<WaterBarrel> waterBarrelList = waterBarrel.getWaterBarrelList();
			List<ManagementFacility> managementFacilityList = managementFacility.getManagementFacilityList();
			
			if (facility.getType().equals("F")) {
				//사료통 추가
				if (feedBarrelList != null) {
					for (int i = 0 ; i < feedBarrelList.size() ; i++ ) {
						feedBarrel = feedBarrelList.get(i);
						if (feedBarrel != null) {	//사료통 설렉트 박스에 값이 없음이 아닌경우만 insert
							feedBarrel = new FeedBarrel(feedBarrel.getNo(), facility_.getNo(), "O", (int)(feedBarrel.getStandard()*0.3), 0, "O",feedBarrel.getStandard());	//임계값 계산필요
							feedBarrelMapper.insertFeedBarrel(feedBarrel);
						}
					}
				}
				//물통 추가
				if (waterBarrelList != null)
				for (int i = 0 ; i < waterBarrelList.size() ; i++ ) {
					waterBarrel = waterBarrelList.get(i);
					if (waterBarrel != null) {	//물통 설렉트 박스에 값이 없음이 아닌경우만 insert
						waterBarrel = new WaterBarrel(waterBarrel.getNo(), facility_.getNo(), "O", (int)(waterBarrel.getStandard()*0.3), 0, "O", waterBarrel.getStandard());	//임계값 계산필요
						waterBarrelMapper.insertWaterBarrel(waterBarrel);
					}
				}
			}
			
			//담당자 배정
			//TODO : 담당자가 2개이하의 담당 시설물을 가지고 있는지 체크해야됨
			if (managementFacilityList != null)	 {
				for (int i = 0 ; i < managementFacilityList.size() ; i++ ) {
					if (managementFacilityList.get(i) != null) {	//담당자 설렉트 박스에 값이 없음이 아닌경우만 insert
																									//맴버 id
						ManagementFacility member = new ManagementFacility(managementFacilityList.get(i).getMemberNo(), facility_.getNo());
						
						if (managementFacilityMapper.selectManagementFacilityList(managementFacilityList.get(i)).size() <= 2){
							managementFacilityMapper.insertManagementFacility(member);
						} else {
							return false;
						}
					}
				}
			}
			
			if (result > 0) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	//목록조회
	@Override
	public List<Facility> getFacilityList(String term) {
		List<Facility> facilityList = null;
		try {
			facilityList = facilityMapper.selectFacilityList(term);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return facilityList;
	}

	//조회
	@Override
	public Map<String, Object> getFacility(Facility facility) { //시설물 no가 반드시 포함되어야함
		Map<String, Object> facilityMap = new HashMap<>();
		
		//조회한 시설물에 담당자가 존재하는지? (시설물id를 이용)
			//존재 하면 담당자 목록 조회해옴
			try {
				
				facilityMap.put("facility", facilityMapper.selectFacility(facility));	//시설물 (상세)조회
				ManagementFacility managementFacility = new ManagementFacility();
				managementFacility.setFacilityNo(facility.getNo());
				
				List<ManagementFacility> managementFacilityList = managementFacilityMapper.selectManagementFacilityList(managementFacility);
				
				List<Member> memberList = new ArrayList();
				
				if (managementFacilityList != null) {
					for (int i = 0 ; i < managementFacilityList.size() ; i ++) {
						Member member = new Member();
						member.setNo(managementFacilityList.get(i).getMemberNo());
						memberList.add(memberMapper.selectMember(member));
					}
					facilityMap.put("memberList", memberList);
				}
				
				FeedBarrel feedBarrel = new FeedBarrel();
				WaterBarrel waterBarrel = new WaterBarrel();
				feedBarrel.setFacilityNo(facility.getNo());
				waterBarrel.setFacilityNo(facility.getNo());
				
				if (facilityMap.get("facility") != null) {
					if (((Facility)(facilityMap.get("facility"))).getType().equals("F")) { 			//급식소라면 물통 사료통도 조회함
						facilityMap.put("feedBarrelList", feedBarrelMapper.selectFeedBarrelList(feedBarrel));
						facilityMap.put("waterBarrelList", waterBarrelMapper.selectWaterBarrelList(waterBarrel));
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return facilityMap;
	}

	//수정
	@Override
	public boolean editFacility(Facility facility,
			FeedBarrel feedBarrel,
			WaterBarrel waterBarrel) {
		int result = 0;
		//시설물 수정 폼에서 받아온 정보를 여기서 DB에 갱신한다.
			//이때 필요한 파라미터는 facility 뿐만아니라 담당자, 사료통, 물통도 있다.
		
		try {
			result = facilityMapper.updateFacility(facility);
			
			//일단 이 시설물에 존재하는 모든 사료통 정보를 가져와서 해당 사료통 번호랑 입력받은 사료통 번호가 같으면 규격 수정 규격도 같으면 
				//그리고 남은 것들은 등록
			
			//해당 시설물의 사료통만 조회
			FeedBarrel feedBarrelDb = new FeedBarrel();
			feedBarrelDb.setFacilityNo(facility.getNo());
			List<FeedBarrel> feedBarrelListDb = feedBarrelMapper.selectFeedBarrelList(feedBarrelDb);
			
			WaterBarrel waterBarrelDb = new WaterBarrel();
			feedBarrelDb.setFacilityNo(facility.getNo());
			List<WaterBarrel>  waterBarrelListDb = waterBarrelMapper.selectWaterBarrelList(waterBarrelDb);
			
			//수정폼에서 등록된 사료통
			List<FeedBarrel> feedBarrelList = feedBarrel.getFeedBarrelList();
			List<WaterBarrel> waterBarrelList = waterBarrel.getWaterBarrelList();
			
			//테이블내의 기존에 존재하는 사료통들과 현재 수정폼에서 입력된 사료통들을 비교한다.
				//1.입력한 사료통이 테이블에 이미 존재할 경우 업데이트
				//2.입력한 사료통이 테이블에는 없을경우 해당 사료통 등록함
				//3.테이블에 존재하는 
					//입력값 12 테이블 13 
					//12는 업데이트 3은 삭제
				//아니면 그냥 해당 시설물 사료통 다 삭제하고 다시 등록.끝?
			
			for (FeedBarrel feedBarrelDb_ : feedBarrelListDb) {
				feedBarrelMapper.deleteFeedBarrel(feedBarrelDb_);
			}
			
			if (feedBarrelList != null) {
				for (FeedBarrel feedBarrel_ : feedBarrelList) {
					feedBarrel_.setCriticalValue((int)(feedBarrel_.getStandard()*0.3));
					feedBarrel_.setStatus("O");
					feedBarrel_.setSupplementStatus("X");
					feedBarrel_.setCapacity(feedBarrel_.getStandard());
					feedBarrelMapper.insertFeedBarrel(feedBarrel_);
				}
			}
			
			for (WaterBarrel waterBarrelDb_ : waterBarrelListDb) {
				waterBarrelMapper.deleteWaterBarrel(waterBarrelDb_);
			}
			
			if (waterBarrelList != null) {
				for (WaterBarrel waterBarrel_ : waterBarrelList) {
					waterBarrel_.setCriticalValue((int)(waterBarrel_.getStandard()*0.3));
					waterBarrel_.setStatus("O");
					waterBarrel_.setSupplementStatus("X");
					waterBarrel_.setCapacity(waterBarrel_.getStandard());
					waterBarrelMapper.insertWaterBarrel(waterBarrel_);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	//삭제
	@Override
	public boolean deleteFacility(Facility facility) {
		int result = 0;
		try {
			facility = facilityMapper.selectFacility(facility);
			if (facility != null) {
				result = facilityMapper.deleteFacility(facility);
				if (facility.getType().equals("F"))	 {
					FeedBarrel feedBarrel = new FeedBarrel();
					feedBarrel.setFacilityNo(facility.getNo());
					feedBarrelMapper.deleteFeedBarrel(feedBarrel);
					
					WaterBarrel waterBarrel = new WaterBarrel();
					waterBarrel.setFacilityNo(facility.getNo());
					waterBarrelMapper.deleteWaterBarrel(waterBarrel);
				}
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (result > 0) {
			return true;
		}
		return false;
	}

	//시설물 사료통 정보 목록 수정(갱신)
	@Override
	public void editFeedBarrelList(Facility facility, List<FeedBarrel> feedBarrelList) {
		try {
			for (int i = 0 ; i < feedBarrelList.size() ; i++) {
				FeedBarrel feedBarrel = feedBarrelList.get(i);
	            feedBarrel.setFacilityNo(facilityMapper.selectFacility(facility).getNo());
	            
	            FeedBarrel originalBarrel = new FeedBarrel(feedBarrel.getNo(), facility.getNo(), null, 0, 0, null, 0);
	            originalBarrel.setNo(feedBarrel.getNo());
	            originalBarrel = feedBarrelMapper.selectFeedBarrel(originalBarrel);
				
	            if (originalBarrel != null) {
					if (originalBarrel.getCriticalValue() <= feedBarrel.getCapacity()) {
						feedBarrel.setSupplementStatus("X");
					} else {
						feedBarrel.setSupplementStatus("O");
					}
	            }
	            
				feedBarrelMapper.updateFeedBarrel(feedBarrel);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//시설물 물통 정보 목록 수정(갱신)
	@Override
	public void editWaterBarrelList(Facility facility, List<WaterBarrel> waterBarrelList) {
		try {
			for (int i = 0 ; i < waterBarrelList.size() ; i++) {
				WaterBarrel waterBarrel = waterBarrelList.get(i);
				waterBarrel.setFacilityNo(facilityMapper.selectFacility(facility).getNo());
	            
				WaterBarrel originalBarrel = new WaterBarrel(waterBarrel.getNo(), facility.getNo(), null, 0, 0, null, 0);
	            originalBarrel.setNo(waterBarrel.getNo());
	            originalBarrel = waterBarrelMapper.selectWaterBarrel(originalBarrel);
				
	            if (originalBarrel != null) {
					if (originalBarrel.getCriticalValue() <= waterBarrel.getCapacity()) {
						waterBarrel.setSupplementStatus("X");
					} else {
						waterBarrel.setSupplementStatus("O");
					}
	            }
					
				waterBarrelMapper.updateWaterBarrel(waterBarrel);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//시설물 담당자 목록 조회
	@Override
	public List<ManagementFacility> getManagementFacilityList(Facility facility) {
		ManagementFacility managementFacility = new ManagementFacility();
		managementFacility.setFacilityNo(facility.getNo());
		List<ManagementFacility> list = null;
		try {
			list = managementFacilityMapper.selectManagementFacilityList(managementFacility);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	//담당자 시설물 목록 조회
	@Override
	public List<ManagementFacility> getManagementFacilityList(Member member) {
		ManagementFacility managementFacility = new ManagementFacility();
		managementFacility.setMemberNo(member.getNo());
		List<ManagementFacility> list = null;
		try {
			list = managementFacilityMapper.selectManagementFacilityList(managementFacility);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	//시설물 담당자 등록
	@Override
	public boolean registerManagementFacility(ManagementFacility managementFacility) {
		try {
			managementFacilityMapper.insertManagementFacility(managementFacility);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	//시설물 담당자 삭제
	@Override
	public boolean deleteManagementFacilityList(ManagementFacility managementFacility) {
		try {
			managementFacilityMapper.deleteManagementFacility(managementFacility);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	//시설물 고유번호 저장
	@Override
	public void setTempFacilityUid(Facility facility) {
		try {
			//uid가 이미 존재하는지 조회	//없다면
			if (facilityMapper.selectFacility(facility) == null) {
				facility.setNo(-1);
				facilityMapper.insertTempFacility(facility);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<FeedBarrel> getFeedBarrelList(int facilityNo) {
		try {
			Facility facility = new Facility();
			facility.setNo(facilityNo);
			
			if (facilityMapper.selectFacility(facility).getType().equals("F")) {
				FeedBarrel feedBarrel = new FeedBarrel();
				feedBarrel.setFacilityNo(facilityNo);
				System.out.println(feedBarrel.getFacilityNo());
				return feedBarrelMapper.selectFeedBarrelList(feedBarrel);
			}
			
			return null;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	@Override
	public List<WaterBarrel> getWaterBarrelList(int facilityNo) {
		try {
			Facility facility = new Facility();
			facility.setNo(facilityNo);
			
			if (facilityMapper.selectFacility(facility).getType().equals("F")) {
				WaterBarrel waterBarrel = new WaterBarrel();
				waterBarrel.setFacilityNo(facilityNo);
				return waterBarrelMapper.selectWaterBarrelList(waterBarrel);
			}
			
			return null;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}