package org.catty.member;

import java.util.List;
import java.util.Map;

public interface MemberService {
	public boolean joinMember(JoinInfo joinInfo);
	public boolean checkIdDuplication(String id);
	public List<Member> getMemberList(String term);
	public Member getMember(Member member);
	public boolean editMember(JoinInfo joinInfo);
	public boolean withdrawal(Member member);
	public Map<String, Object> getFacilityInChargeList(Member member);
}
