package com.hilton.controller;
import com.hilton.service.ProductivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class ProductivityController{
  
@Autowired
private ProductivityService service;
  
@PostMapping("/loadEmployeeData")
public String loadData(@RequestParam String fileName) throws Exception{
  service.loadData(fileName);
  return "Data Loaded Successfully";
  }
  
}
