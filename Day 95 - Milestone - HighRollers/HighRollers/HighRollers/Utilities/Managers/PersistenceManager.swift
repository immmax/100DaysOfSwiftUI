//
//  PersistenceManager.swift
//  HighRollers
//
//  Created by Maxim Datskiy on 4/14/24.
//

import Foundation

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let rolls = "rolls"}
    
    static func retrieveRolls() throws -> [Roll] {
        guard let rollsData = defaults.data(forKey: Keys.rolls) else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try JSONDecoder().decode([Roll].self, from: rollsData)
        } catch {
            throw error
        }
    }
    
    static func save(newRoll: Roll) throws {
        do {
            var rolls = try retrieveRolls()
            rolls.append(newRoll)
            
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedRolls = try JSONEncoder().encode(rolls)
            
            defaults.setValue(encodedRolls, forKey: Keys.rolls)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
