package org.travelmaker.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.service.AdminMemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@RestController
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class MemberContorller2 {

	private AdminMemberService service;

	private static final Logger logger = LoggerFactory.getLogger(MemberContorller2.class);

	@GetMapping("userInfo2")
	public ResponseEntity<List<MemberVO>> userInfo2(Criteria cri, Model model) {

		if (cri.getKeyword() == null || cri.getType() == null) {
			return new ResponseEntity<>(service.getUserList(), HttpStatus.OK);
		} else {
			return new ResponseEntity<>(service.searchUser(cri), HttpStatus.OK);

		}

	}
	
}
