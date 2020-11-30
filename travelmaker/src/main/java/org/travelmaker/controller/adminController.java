package org.travelmaker.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.service.AdminMemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/ad/*")
@AllArgsConstructor
public class adminController {
	
	private AdminMemberService service;
	
	@GetMapping(value="userInfo2", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<MemberVO>> getUserList() {
		
	//	return new ResponseEntity<>(service.getUserList(), HttpStatus.OK);
		return null;
		
	}


	
	@RequestMapping(value="deleteUser/{result}", method = {RequestMethod.GET, RequestMethod.DELETE}, produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> deleteUser(@PathVariable("result") int[] result) {
		
		if(result!=null) {
			for (int i = 0; i < result.length; i++) {
					//service.removeUser(result[i]);
				//	rttr.addFlashAttribute("message", "SUCCESS");
			}
			return new ResponseEntity<>("success",HttpStatus.OK);
		}
		return new ResponseEntity<>("error occured",HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	

}
