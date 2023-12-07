//
//  PilotLicenses.swift
//  LH-Pilot
//
//  Created by Ines BOKRI on 06/12/2023.
//

import Foundation

public struct PilotLicenses: Codable {
    
    let pilotLicenses: [License]
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case pilotLicenses = "pilot-licenses"
    }
}
