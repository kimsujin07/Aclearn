package com.ezen.aclearn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Set;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class UrlInterceptor extends HandlerInterceptorAdapter{

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // TODO Auto-generated method stub
    	
    	String getRequestURI = request.getRequestURI();
    	//String getContextPath = request.getContextPath();
    	String getRequestURL = request.getRequestURL().toString();
    	//String getServletPath = request.getServletPath();
    	
    	System.out.println("@@@getRequestURI -> " + getRequestURI);
    	//System.out.println("@@@getContextPath -> " + getContextPath);
    	System.out.println("@@@getRequestURL -> " + getRequestURL);
    	//System.out.println("@@@getServletPath -> " + getServletPath);
    	
    	System.out.println("@@@해당"+getRequestURI + " 의 전체 파라미터 출력 start");
    	Set<String> keySet = request.getParameterMap().keySet();
    	for(String key: keySet) {
    		System.out.println(key + ": " + request.getParameter(key));
    	}    	
    	System.out.println("@@@해당 url의 전체 파라미터 출력 end");
    	
        return super.preHandle(request, response, handler);
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub
        super.postHandle(request, response, handler, modelAndView);
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // TODO Auto-generated method stub
        super.afterCompletion(request, response, handler, ex);
    }	
	
}
