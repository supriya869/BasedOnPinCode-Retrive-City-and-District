package com.example.ElectricityBill.service;

import com.example.ElectricityBill.model.Pincode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.ElectricityBill.repository.PincodeRepository;

import java.util.List;

@Service
public class PincodeService {

    @Autowired
    private PincodeRepository pincodeRepository;

    public List<Pincode> getPincodeDetails(String pincode) {
        return pincodeRepository.findByPincode(pincode);  // Assuming findByPincode is the correct method
    }
}
