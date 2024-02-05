package com.example.ssl.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController("/")
class DemoController {
    @GetMapping("/greet/{name}")
    public String greet(@PathVariable("name") String name) {
        return "Hello: %s.".formatted(name);
    }
}
