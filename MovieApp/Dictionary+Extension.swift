//
//  Dictionary+Extension.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation

extension Dictionary {
    
    //MARK: Parser methods
    private var jsonDict: [String:Any] {
        return self as? [String:Any] ?? [:]
    }
    
    func int(key: String) -> Int {
        if let intValue = jsonDict[key] as? Int {
            return intValue
        }
        if let strValue = jsonDict[key] as? String, let intValue = Int(strValue) {
            return intValue
        }
        return 0
    }
    
    func optionalInt(key: String) -> Int? {
        if let intValue = jsonDict[key] as? Int {
            return intValue
        }
        if let strValue = jsonDict[key] as? String, let intValue = Int(strValue) {
            return intValue
        }
        return nil
    }
    
    func double(key: String) -> Double {
        if let doubleValue = jsonDict[key] as? Double {
            return doubleValue
        }
        if let strValue = jsonDict[key] as? String, let doubleValue = Double(strValue) {
            return doubleValue
        }
        return 0
    }
    
    func optionalDouble(key: String) -> Double? {
        if let doubleValue = jsonDict[key] as? Double {
            return doubleValue
        }
        if let strValue = jsonDict[key] as? String, let doubleValue = Double(strValue) {
            return doubleValue
        }
        return nil
    }
    
    func bool(key: String, defaultValue: Bool = false) -> Bool {
        if let boolean = jsonDict[key] as? Bool {
            return boolean
        }
        
        else if let intValue = jsonDict[key] as? Int {
            return intValue == 1
        }
        return defaultValue
    }
    
    func string(key: String) -> String? {
        let rawValue = jsonDict[key]
        if let value = rawValue as? String {
            return value
        }
        if let value = rawValue as? Int {
            return "\(value)"
        }
        return nil
    }
    
    func date(key: String) -> Date {
        guard let value = jsonDict[key] as? String else { return Date() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.date(from: value) ?? Date()
    }
    
    func array(key: String) -> [Any] {
        return jsonDict[key] as? [Any] ?? []
    }
    
    func dict(key: String) -> [String: Any]? {
        return jsonDict[key] as? [String:Any]
    }
    
    func cgFloat(key: String) -> CGFloat {
        return jsonDict[key] as? CGFloat ?? 0
    }
}
