package com.medicalportal.medicalportal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class DoctorHomeController {

    @GetMapping("/")
    public String home() {
        return "redirect:/login"; // my login page
    }
}
