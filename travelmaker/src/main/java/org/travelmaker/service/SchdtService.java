package org.travelmaker.service;

import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.travelmaker.domain.SchdtVO;
import org.travelmaker.domain.Schdt_PlaceVO;
import org.travelmaker.domain.ScheduleDtVO;

public interface SchdtService {

	public List<SchdtVO> getSchdt(int schNo);

	public List<Schdt_PlaceVO> getplacetitle(int schNo);
	
	public int insertSchDt(SchdtVO[] schdtVOs);
	
	public SchdtVO[][] setAll(int schNo,SchdtVO[][] schdtVOs);
	
	public List<CompletableFuture<Void>> getInitSchWithDistAndDu(ScheduleDtVO[][] schdtVOs);

}
