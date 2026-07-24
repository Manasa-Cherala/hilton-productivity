package com.hilton.service;

import com.hilton.entity.EmployeeProductivity;
import com.hilton.repository.EmployeeProductivityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.io.BufferedReader;
import java.io.FileReader;

@Service
  public class ProductivityService{
    @Autowired
    EmployeeProductivityRepository repository;
    public void loadData(String fileName)
    throws Exception{
      BufferedReader br = new BufferedReader(new FileReader(fileName));
      String line;
      while ((line = br.readLine()!=null){
        String[] data = line.split("\|");
        EmployeeProductivity employee = new EmployeeProductivity(data[0],data[1],data[2],data[3]);
        repository.save(employee);
      }
      br.close();
    }
  }

