//
//  License.swift
//  LH-Pilot
//
//  Created by Ines BOKRI on 06/12/2023.
//

import Foundation

public struct License: Codable {
    
    let type: String
    let aircrafts: [String]
    
    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case type
        case aircrafts
    }
}
