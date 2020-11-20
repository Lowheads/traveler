package org.travelmaker.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PlaceDTO {
	
	private String plcTitle;
	private int plcNo;
	private int themeNo;

}
