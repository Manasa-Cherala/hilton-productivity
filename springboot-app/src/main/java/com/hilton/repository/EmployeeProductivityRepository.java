package com.hilton.repository;

import com.hilton.entity.EmployeeProductivity;
import org.springframework.data.jpa.repository.JpaRepository;
@Repository
public interface EmployeeProductivity extends JpaRepository<EmployeeProductivity, Long>{
}
