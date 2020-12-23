package org.travelmaker.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// /member/main을 제외하고는 로그인해야 이용 가능
public class LoginHandle extends HandlerInterceptorAdapter {

	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// session 객체를 가져옴
		HttpSession session = request.getSession();
		// login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
		Object obj = session.getAttribute("email");
		
		// 로그인 전에 요청한 주소 저장
		// 예 : /qnaboard/get?pageNum=1&amount=20&type=&keyword=&bno=2132
		String requestPath = request.getServletPath();  // 내가 요청한 경로
		String query = request.getQueryString(); // ?뒤에 주소를 저장
		
//		System.out.println(requestPath + "?" + query);
		
		HttpSession httpSession = request.getSession();
		
		if(query != null) { // 파라미터 주소값이 있다면 주소값도 저장
			httpSession.setAttribute("movePath", requestPath+"?"+query);
		}else { // 아니라면 페이지 경로만 저장
			httpSession.setAttribute("movePath", requestPath);
		}
		
		if (obj == null) {
			// 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 후 이용해주세요.'); location.href='/main/index'</script>");
            out.flush();
			return false; // 더이상 컨트롤러 요청으로 가지 않도록false로 반환함
		}

		// preHandle의return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
		// 따라서true로하면 컨트롤러 uri로 가게 됨.
		return true;
	}

	// 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

}
