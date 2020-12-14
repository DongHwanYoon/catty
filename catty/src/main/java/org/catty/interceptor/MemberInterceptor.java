package org.catty.interceptor;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.HandlerMapping;

@Component
public class MemberInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 
			throws Exception {
		String theMethod = request.getMethod();
		String url = request.getRequestURI();
		HttpSession session = request.getSession();
		
		Map<?, ?> pathVariables = (Map<?, ?>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
		
		if (HttpMethod.GET.matches(theMethod) && url.matches("/member/" + pathVariables.get("no"))) {
			//경로 변수 추출
			int pageNo = Integer.parseInt(String.valueOf(pathVariables.get("no")));
			int sessionNo = Integer.parseInt(String.valueOf(session.getAttribute("no")));
			
			boolean isAdmin = Boolean.valueOf(String.valueOf(session.getAttribute("isAdmin")));
			
			if (url.matches("/member/" + pathVariables.get("no"))) {
				if (pageNo == sessionNo || isAdmin) {
					
					return true;
				}
			}
			
			response.sendRedirect("/common/login");
				
			return false;
		}
		
		if (session.getAttribute("id") != null) {
			return true;
		} else {
			response.sendRedirect("/common/login");
			
			return false;
		}
	}
}