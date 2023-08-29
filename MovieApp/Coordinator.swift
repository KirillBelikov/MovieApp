//
//  Coordinator.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

class Coordinator {
    
    static let shared = Coordinator()
    private init() {
        self.screen = .splash
    }
    
    var mainNavigation: UINavigationController?
    var screen: Screen
    
     func push(to screen: Screen) {
         self.screen = screen
         DispatchQueue.main.async { [weak self] in
             guard let self = self,
                let mainNavigation = mainNavigation else {
                 return
             }
             mainNavigation.pushViewController(screen.viewController, animated: true)
         }
    }
    
    func showAlert(title: String, subtitle: String) {
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        mainNavigation?.present(alertController, animated: true, completion: nil)
    }
    
    func setToRoot(_ screen: Screen) {
        self.screen = screen
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let firstWindow = windowScene.windows.first {
            let navigation = UINavigationController(rootViewController: screen.viewController)
            mainNavigation = navigation
            firstWindow.rootViewController = mainNavigation
        }
    }
}
