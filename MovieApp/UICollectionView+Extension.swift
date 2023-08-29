//
//  UICollectionView+Extension.swift
//  MovieApp
//
//  Created by Kirill Belikov on 29.08.2023.
//

import UIKit

extension UICollectionView {
 
    func registerXib(xibName: String) {
        let xib = UINib(nibName: xibName, bundle: nil)
        register(xib, forCellWithReuseIdentifier: xibName)
    }
}
