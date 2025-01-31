package com.example.ElectricityBill.repository;


import com.example.ElectricityBill.model.Pincode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PincodeRepository extends JpaRepository<Pincode, Long> {
    List<Pincode> findByPincode(String pincode);  // Fetch multiple records for the given pincode
}
