//
//  FilterOptionCell.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

class FilterOptionCell: UICollectionViewCell {
    
    @IBOutlet weak private var label: UILabel!
    
    func configure(with category: Category, selected: Bool) {
        label.text = category.name
        label.font = UIFont.systemFont(ofSize: 14, weight: selected ? .bold : .regular)
    }
}
