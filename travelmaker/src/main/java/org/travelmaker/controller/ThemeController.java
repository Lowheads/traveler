package org.travelmaker.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ThemeVO;
import org.travelmaker.service.ThemeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class ThemeController {

	private ThemeService service;

	@GetMapping("/theme")
	public String theme(Model model) {

		List<ThemeVO> list = service.getThemeList();

		model.addAttribute("list", list);

		return "theme";
	}

	@GetMapping("/themeInfo/{themeNo}")
	public String themeInfo(@PathVariable("themeNo") int themeNo, Model model) {

		List<PlaceVO> list = service.getThemeInfo(themeNo);

		model.addAttribute("list", list);

		return "themeInfo";
	}

	@GetMapping("/modifyTheme/{themeNo}")
	public String modifyTheme(@PathVariable("themeNo") int themeNo, Model model) {

		List<PlaceVO> list = service.getThemeInfo(themeNo);
		model.addAttribute("list", list);

		return "modifyTheme";

	}

	@PostMapping("/modifyTheme/{themeNo}")
	public String modifyThemeAction(@PathVariable("themeNo") int themeNo, String[] removedPlaces, String[] addedPlaces,
			Model model, RedirectAttributes rttr) {
		
		for (int i = 0; i < removedPlaces.length; i++) {

			System.out.println(removedPlaces[i]);
		}
		System.out.println("----------------------");
		for (int i = 0; i < addedPlaces.length; i++) {

			System.out.println(addedPlaces[i]);
		}

		int result = service.updateTheme(removedPlaces, addedPlaces, themeNo);

		if (result == removedPlaces.length) {
			
			System.out.println("remove success");
			rttr.addFlashAttribute("message", "SUCCESS");
		}

		return "redirect:/admin/themeInfo/" + themeNo;

	}

	@GetMapping(value = "/getPlaceList/{keyword}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<PlaceVO>> getPlaceList(@PathVariable("keyword") String keyword, Model model) {

		ResponseEntity<List<PlaceVO>> list = null;
		list = ResponseEntity.status(HttpStatus.OK).body(service.getPlaceList(keyword));

		return list;
	}

}
