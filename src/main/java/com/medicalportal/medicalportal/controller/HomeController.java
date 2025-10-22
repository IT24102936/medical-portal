package com.medicalportal.medicalportal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/home")
    public String home() {
        return "home"; // Maps to index.jsp
    }
    @GetMapping("/")
    public String index() {
        return "home"; //
    }
}