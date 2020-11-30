package org.travelmaker.service;

import java.util.ArrayList;
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
	public List<MemberVO> getUserList(Criteria cri) {
		
		return mapper.getUserList(cri);
	}

	@Override
	public int removeUser(ArrayList<Integer> ids) {

		return mapper.removeUser(ids);
	}

	@Override
	public List<MemberVO> getWithdrawUserList(Criteria cri) {
		
		return mapper.getWithdrawUserList(cri);
	}

	@Override
	public MemberVO getUser(String memNo) {

		return mapper.getUser(memNo);
	}

}
