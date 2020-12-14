package org.catty.member;

import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public interface MemberMapper {
    public int count(Member member) throws Exception;
    public List<Member> selectMemberList(String term) throws Exception;
    public Member selectMember(Member member) throws Exception;
    public int insertMember(Member member) throws Exception;
    public int updateMember(Member member) throws Exception;
    public int deleteMember(Member member) throws Exception;
}