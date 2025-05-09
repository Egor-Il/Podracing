//
//  UserDefaults+extensions.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/4/25.
//



import Foundation

// MARK: - Extension for save and load data

extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = data(forKey: key),
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
