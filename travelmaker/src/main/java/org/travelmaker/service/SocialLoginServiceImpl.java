package org.travelmaker.service;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.travelmaker.loginapi.KakaoUserInfo;
import org.travelmaker.loginapi.Kakao_restapi;
import org.travelmaker.loginapi.NaverLoginBO;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class SocialLoginServiceImpl implements SocialLoginService {

	private NaverLoginBO naverLoginBO = new NaverLoginBO();     // 네이버
	private Kakao_restapi kakao_restapi = new Kakao_restapi();  // 카카오

	@Override
	public String getNaverAuthUrl(HttpSession session) {
		
		// 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		return naverAuthUrl;
	}

	@Override
	public JSONObject getJsonByNaver(OAuth2AccessToken oauthToken, String userInfo) throws ParseException {
		   
		 // String형식인 userInfo를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(userInfo);
		JSONObject jsonObj = (JSONObject) obj;
		   
		return (JSONObject)jsonObj.get("response");
	}
	
	// 네이버 유저 정보 가져오기
	public String getNaverUserProfile(OAuth2AccessToken oauthToken) throws IOException {
		return naverLoginBO.getUserProfile(oauthToken);
	}
	
	// 네이버 토큰 얻기
	public OAuth2AccessToken getNaverToken(@RequestParam String code, @RequestParam String state, HttpSession session) throws IOException {
		return naverLoginBO.getAccessToken(session, code, state);
	
	}

	// 카카오
	@Override
	public StringBuffer getKakaoConnect() {
		
		  StringBuffer url = new StringBuffer();
		  url.append("https://kauth.kakao.com/oauth/authorize?");
		  url.append("client_id=" + "1bf3c8a08cf3e47ad275686f733fb056");
		  url.append("&redirect_uri=http://localhost:809/member/kakaoLogin");
		  url.append("&response_type=code");
		return url;
	}

	@Override
	public JsonNode getKakaoToken(String code) {
		JsonNode access_token = kakao_restapi.getKakaoAccessToken(code);
		return access_token;
	}

	@Override
	public JsonNode getKakaoUserProfile(JsonNode access_token) {
		JsonNode userProfile = KakaoUserInfo.getKakaoUserInfo(access_token.get("access_token"));
		return userProfile;
	}


}
