package org.travelmaker.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PositionDTO {
	
	private int lat;
	private int lng;

}
