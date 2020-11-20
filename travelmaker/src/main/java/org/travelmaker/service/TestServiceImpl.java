package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import org.travelmaker.domain.StatisticVO;
import org.travelmaker.domain.TestVO;
import org.travelmaker.mapper.TestMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class TestServiceImpl implements TestService {

	private TestMapper mapper;
	

	@Override
	public void registerTheme(TestVO t) {
		
		mapper.insertTheme(t);
		
	}


	

}
