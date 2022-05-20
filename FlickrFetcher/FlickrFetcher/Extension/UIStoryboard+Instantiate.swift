//
//  UIStoryboard+Instantiate.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import UIKit

extension UIStoryboard {
    
    static var home: UIStoryboard {
        UIStoryboard(name: "Home", bundle: nil)
    }
    
    func instantiate<T: UIViewController>(viewController: T.Type) -> T {
        instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
