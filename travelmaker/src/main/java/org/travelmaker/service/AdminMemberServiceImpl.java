package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;

import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.mapper.AdminMemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminMemberServiceImpl implements AdminMemberService {

	private AdminMemberMapper mapper;

	@Override
	public List<MemberVO> getUserList() {
		
//		System.out.println(mapper.getList());

		
		return mapper.getUserList();
	}

	@Override
	public int removeUser(int result) {

		return mapper.removeUser(result);
		
	}


	@Override
	public List<MemberVO> getWithdrawUserList() {
		
		return mapper.getWithdrawUserList();
	}

	@Override
	public List<MemberVO> searchUser(Criteria cri) {
		return mapper.searchUser(cri);
	}

	@Override
	public List<MemberVO> searchWithdrawUser(Criteria cri) {

		return mapper.searchWithdrawUser(cri);
	}

	@Override
	public MemberVO getUser(String memNo) {

		return mapper.getUser(memNo);
	}




}
