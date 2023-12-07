//
//  RegistrationViewModel.swift
//  LH-Pilot
//
//  Created by Ines BOKRI on 07/12/2023.
//

import UIKit

final class RegistrationViewModel: RegistrationViewModelModeling {
    
    // MARK: - Properties
    var piloteLicenses: PilotLicenses?

    // MARK: - Functions
    func fechData() {
        if let path = Bundle.main.path(forResource: "lufthansaData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = try JSONDecoder().decode(PilotLicenses.self, from: data )

                self.piloteLicenses = model
            } catch {
                // handle error
            }
        }
    }
    
     func checkLicenseTypeValidity(_ text: String) -> Bool {
        guard let licensesType = self.piloteLicenses else { return false }
        var licenseType = [String]()
        
        for item in licensesType.pilotLicenses {
            licenseType.append(item.type)
        }

        return licenseType.contains(where: {$0.caseInsensitiveCompare(text) == .orderedSame}) ? true : false
    }
    
    func getAirCraftFromLicenseType(_ type: String) -> [String] {
        guard let licensesType = self.piloteLicenses else { return [] }
        
        var aircrafts = [String]()
        for item in licensesType.pilotLicenses where item.type == type.uppercased() {
            aircrafts = item.aircrafts
        }
        
        return aircrafts
    }
    
    func checkPasswordValidity(_ password: String, _ username: String) -> Bool {
        if password.isEmpty {
            return false
        } else {
            let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{12,}")
            let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)

            return passwordtesting.evaluate(with: password) && !password.contains(username)
        }
    }
    
    func checkConfirmPasswordValidity(_ password: String, _ confirmPassword: String) -> Bool {
        if password.isEmpty {
            
            return false
        } else {
            return password == confirmPassword
        }
    }
}
