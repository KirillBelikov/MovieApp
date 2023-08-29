//
//  UITableView+Extension.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

extension UITableView {
    
    func registerXib(xibName: String) {
        let xib = UINib(nibName: xibName, bundle: nil)
        register(xib, forCellReuseIdentifier: xibName)
    }
}
