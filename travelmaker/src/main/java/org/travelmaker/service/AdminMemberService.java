package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.MemberVO;

public interface AdminMemberService {

	public MemberVO getUser(String memNo);
	
	public List<MemberVO> getUserList();

	public List<MemberVO> searchUser(Criteria cri);

	public List<MemberVO> getWithdrawUserList();
	
	public List<MemberVO> searchWithdrawUser(Criteria cri);

	public int removeUser(int result);
	
	
	
	

	
	
	
}
