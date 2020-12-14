package org.catty.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfiguration implements WebMvcConfigurer {
	@Autowired
	private MemberInterceptor memberInterceptor;
	@Autowired
	private AdminInterceptor adminInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(memberInterceptor)
				.addPathPatterns("/member/**", "/facility/**", "/obslog/**", "/inslog/**"
									, "/photo/**")
				.excludePathPatterns("/member", "/member/join", "/photo/cat/**", "/facility/data");

		registry.addInterceptor(adminInterceptor)
				.addPathPatterns("/cat/**", "/member", "/facility/**")
				.excludePathPatterns("/cat", "/facility", "/facility/data", "/cat/data/**");
	}
}