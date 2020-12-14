package org.travelmaker.service;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;

public interface apiLoginService { // api 로그인에 관한 서비스 인터페이스
	
	// Naver
	public String getNaverAuthUrl(HttpSession session); // 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 

	public JSONObject getJsonByNaver(OAuth2AccessToken oauthToken, String userInfo) throws ParseException;
	
	public String getNaverUserProfile(OAuth2AccessToken oauthToken) throws IOException; // 네이버 유저 정보 가져오기
	
	public OAuth2AccessToken getNaverToken(@RequestParam String code, @RequestParam String state, HttpSession session) throws IOException; // 네이버 토큰 얻기

	// KaKao
	public StringBuffer getKakaoConnect(); // 카카오 로그인 주소를 얻어온다.
	
	public JsonNode getKakaoToken(String code); // 카카오 토큰 얻기
	
	public JsonNode getKakaoUserProfile(JsonNode access_token); // 카카오 유저 정보 얻기
	
}
