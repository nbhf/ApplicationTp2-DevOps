package com.example.ApplicatiopTp2.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/monapi/v1")
public class BonjourController {
    @GetMapping("/bonjour")
    public String saluer(){
        return "Bonjour! Let's test the trigger";
    }
}
