//
//  SceneDelegate.swift
//  ExampleAbstractFactory
//
//  Created by Mohsen Khosravinia on 4/13/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        #if EMPLOYEE
        let client = Client(factoryType: EmployeeViewFactory.self)
        #else
        let client = Client(factoryType: AdminViewFactory.self)
        #endif
        
        window?.rootViewController = client.signUpViewController()
        
        window?.makeKeyAndVisible()
    }
}

