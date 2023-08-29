//
//  String+Extension.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation

extension String {

    static func jsonToString(json: [String:Any]){
        do {
            let data =  try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data, encoding: .utf8) // the data will be converted to the string
            po("JSON STRING", data: convertedString ?? "") // <-- here is ur string
            
        } catch let error {
            po("ERROR CONVERTING TO JSON SRING", data: error.localizedDescription)
        }
    }
}
