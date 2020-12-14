package org.catty.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.HandlerMapping;

@Component
public class AdminInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 
			throws Exception {
		String theMethod = request.getMethod();
		
		String url = request.getRequestURI();
		
		HttpSession session = request.getSession();
		
		boolean isAdmin = Boolean.valueOf(String.valueOf(session.getAttribute("isAdmin")));
		
		if (HttpMethod.GET.matches(theMethod)) {
			//경로 변수 추출
			Map<?, ?> pathVariables = (Map<?, ?>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
			
			if (url.matches("/cat/" + pathVariables.get("no")) || url.matches("/facility/" + pathVariables.get("facilityNo")) || isAdmin) {
				return true;
			}
			
			response.sendRedirect("/common/login");
				
			return false;
		} else if (HttpMethod.POST.matches(theMethod)) {
			if (url.matches("/member") || isAdmin) {
				return true;
			}
			
			response.sendRedirect("/common/login");
				
			return false;
		} else {
			if (isAdmin) {
				return true;
			} 
			
			response.sendRedirect("/common/login");
				
			return false;
		}
	}
}