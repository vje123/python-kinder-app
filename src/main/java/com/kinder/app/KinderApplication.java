package com.kinder.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@SpringBootApplication
public class KinderApplication {
    public static void main(String[] args) {
        SpringApplication.run(KinderApplication.class, args);
    }
}

@RestController
@RequestMapping("/api")
class ShapeColorController {
    private static final List<String> shapes = Arrays.asList("Circle", "Square", "Triangle", "Rectangle", "Star");
    private static final List<String> colors = Arrays.asList("Red", "Blue", "Green", "Yellow", "Purple");

    @GetMapping("/shapes")
    public List<String> getShapes() {
        return shapes;
    }

    @GetMapping("/colors")
    public List<String> getColors() {
        return colors;
    }

    @PostMapping("/select")
    public Map<String, String> selectShapeColor(@RequestParam String shape, @RequestParam String color) {
        Map<String, String> response = new HashMap<>();
        response.put("selectedShape", shape);
        response.put("selectedColor", color);
        return response;
    }
}
