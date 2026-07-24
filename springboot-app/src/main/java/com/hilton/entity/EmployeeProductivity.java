package com.hilton.entity;
import jakarta.persistence.*;

@Entity
@Table(name="employee_productivity")
public class EmployeeProductivity{
@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
private Long id;

@Column(name="emp_id")
private String empId;

@Column(name="emp_name")
private String empName;

@Column(name="email")
private String email;

@Column(name="productivity_hours")
private String productivityHours;

public EmployeeProductivity(){}

public EmployeeProductivity(String empId,String empName, String email, String productivityHours){
  this.empId=empId;
  this.empName=empName;
  this.email=email;
  this.productivityHours=productivityHours;
}
  

  public Long getId(){
    return id;
  }

  public String getEmpId(){
    return empId;
  }

  public String getEmpName(){
    return empName;
  }

  public String getEmail(){
    return email;
  }

  public String getProductivityHours(){
    return productivityHours;
  }


  public void setEmpId(String empId){
    this.empId=empId;
  }
  
  public void setEmpName(String empName){
    this.empName=empName;
  }

  public void setEmail(String email){
    this.email=email;
  }

  public void setProductivitHours(String productivityHours){
    this.productivityHours=productivityHours;
  }

}
