package org.travelmaker.mapper;

import java.util.List;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.MemberVO;

public interface AdminMemberMapper {

	public MemberVO getUser(String memNo);
	
	public List<MemberVO> getUserList();
	
	public boolean removeUser(int result);
	
	public List<MemberVO> getWithdrawUserList();
	
	public List<MemberVO> searchUser(Criteria cri);
	
	public List<MemberVO> searchWithdrawUser(Criteria cri);
	
	
	
	
}
