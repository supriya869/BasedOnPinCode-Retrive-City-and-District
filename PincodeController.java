package com.example.ElectricityBill.controller;

import com.example.ElectricityBill.model.Pincode;
import com.example.ElectricityBill.service.PincodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class PincodeController {

    @Autowired
    private PincodeService pincodeService;

    @PostMapping("/getPincodeDetails")
    public List<Pincode> getPincodeDetails(@RequestParam String pincode) {
        // Fetch details from service
        List<Pincode> pincodeDetails = pincodeService.getPincodeDetails(pincode);

        // Log the result
        if (pincodeDetails.isEmpty()) {
            System.out.println("No details found for pincode: " + pincode);
        } else {
            System.out.println("Pincode Details: " + pincodeDetails);
        }

        // Return the details in JSON format
        return pincodeDetails;  // Make sure it returns a list of Pincode objects
    }
}
