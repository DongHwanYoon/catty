package org.catty.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.catty.facility.Facility;
import org.catty.facility.FacilityMapper;
import org.catty.facility.ManagementFacility;
import org.catty.facility.ManagementFacilityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private ManagementFacilityMapper managementFacilityMapper;
	@Autowired
	private FacilityMapper facilityMapper;

	@Override
	public boolean joinMember(JoinInfo joinInfo) {
		String id = joinInfo.getId();
		Member member = new Member();
		member.setId(id);

		try {
			if (memberMapper.selectMember(member) == null) {
				member.setId(joinInfo.getId());
				member.setPwd(joinInfo.getPwd());
				member.setName(joinInfo.getName());
				member.setPhoneNo(joinInfo.getPhoneNo());
				member.setAuthority(joinInfo.getAuthority());
				memberMapper.insertMember(member);

				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
	
	@Override
	public boolean checkIdDuplication(String id) {
		Member member = new Member();
		member.setId(id);
		
		try {
			if (memberMapper.count(member) == 1) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	@Override
	public List<Member> getMemberList(String term) {
		List<Member> memberList = null;

		try {
			memberList = memberMapper.selectMemberList(term);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return memberList;
	}
	
	@Override
	public Member getMember(Member member) {
		try {
			member = memberMapper.selectMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return member;
	}

	@Override
	public boolean editMember(JoinInfo joinInfo) {
		int no = joinInfo.getNo();
		Member member = new Member();
		member.setNo(no);

		int count = 0;

		try {
			if (memberMapper.selectMember(member) != null) {
				member = memberMapper.selectMember(member);
				
				member.setPhoneNo(joinInfo.getPhoneNo());
				
				count = memberMapper.updateMember(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (count != 0) {
			return true;
		}

		return false;
	}

	@Override
	public boolean withdrawal(Member member) {
		int count = 0;

		try {
			count = memberMapper.deleteMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (count != 0) {
			return true;
		}

		return false;
	}
	
	@Override
	public Map<String, Object> getFacilityInChargeList(Member member) {
		Map<String, Object> memberData = new HashMap<String, Object>();;
		List<ManagementFacility> facilities = null;
		List<String> facilityNames = null;
		
		ManagementFacility managementFacility = new ManagementFacility();
		managementFacility.setMemberNo(member.getNo());

		try {
			member = memberMapper.selectMember(member);
			
			facilities = managementFacilityMapper.selectManagementFacilityList(managementFacility);
			facilityNames = getManagementFacilityForName(facilities);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		memberData.put("member", member);
		memberData.put("facilityNames", facilityNames);
		
		System.out.println("담당 시설물 목록 : " + facilityNames);

		return memberData;
	}
	
	public List<String> getManagementFacilityForName(List<ManagementFacility> facilities) {
		List<String> facilityNames = new ArrayList<String>();
		String facilityName = "";
		
		try {
			for (ManagementFacility value : facilities) {
				Facility facility = new Facility();
				facility.setNo(value.getFacilityNo());
				
				facility = facilityMapper.selectFacility(facility);
				System.out.println("########" + facility.getName());
				facilityName = facility.getName();
				
				facilityNames.add(facilityName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return facilityNames;
	}
}