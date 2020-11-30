package org.travelmaker.service;

import java.util.ArrayList;
import java.util.List;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.MemberVO;

public interface AdminMemberService {

	public MemberVO getUser(String memNo);
	
	public List<MemberVO> getUserList(Criteria cri);

	public List<MemberVO> getWithdrawUserList(Criteria cri);
	
	public int removeUser(ArrayList<Integer> ids);
	
}
