package org.travelmaker.mapper;

import java.util.ArrayList;
import java.util.List;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.MemberVO;

public interface AdminMemberMapper {

	public MemberVO getUser(String memNo);
	
	public List<MemberVO> getUserList(Criteria cri);
	
	public int removeUser(ArrayList list);
	
	public List<MemberVO> getWithdrawUserList(Criteria cri);
	
}
