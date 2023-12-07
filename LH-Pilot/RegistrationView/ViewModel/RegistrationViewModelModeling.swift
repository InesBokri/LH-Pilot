//
//  RegistrationViewModelModeling.swift
//  LH-Pilot
//
//  Created by Ines BOKRI on 07/12/2023.
//

import Foundation

public protocol RegistrationViewModelModeling {
    
    // MARK: - Functions
    func fechData()
    func checkLicenseTypeValidity(_ text: String) -> Bool
    func checkPasswordValidity(_ password: String, _ username: String) -> Bool
    func checkConfirmPasswordValidity(_ password: String, _ confirmPassword: String) -> Bool
}
