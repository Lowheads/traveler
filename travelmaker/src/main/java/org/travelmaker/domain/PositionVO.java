package org.travelmaker.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PositionVO {
	
	private int fromLat;
	private int fromLng;
	private int toLat;
	private int toLng;

}
