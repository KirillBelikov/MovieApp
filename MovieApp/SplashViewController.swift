//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

class SplashViewController: UIViewController {

    private var model: SplashViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    static func makeFromNib() -> SplashViewController {
        let nibName = SplashViewController.className
        let viewController = SplashViewController(nibName: nibName, bundle: nil)
        viewController.model = SplashViewModel()
        return viewController
    }
}
