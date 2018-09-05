package com.kh.cat.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.cat.member.service.MemberService;


 
@Controller("AjaxController")
@RequestMapping(value = "/rest")
public class AjaxController {
    
    @Autowired
    MemberService service;
    
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    
    //중복체크
    @RequestMapping(value="/overlay")
    public  @ResponseBody Map<String, String> 
        overlay(@RequestParam("id") String id){
        
        logger.info("중복아이디 체크 : {}",id);
        
        return service.overlay(id);
    }
    
    //중복체크
    @RequestMapping(value="/overlayMail")
    public  @ResponseBody Map<String, String> 
        overlayMail(@RequestParam("email") String email,HttpSession session){
        
        logger.info("중복이메일 체크 : {}",email);
        
        return service.overlayMail(email,session);
    }
    

    
    
    
}
    




