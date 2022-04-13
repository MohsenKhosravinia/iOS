//
//  AdminViewController.swift
//  ExampleAbstractFactory
//
//  Created by Mohsen Khosravinia on 4/13/22.
//

import UIKit

class AuthViewController: UIViewController {

    fileprivate var authView: AuthView

    init(authView: AuthView) {
        self.authView = authView
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(authView.contentView)
        authView.contentView.frame = view.frame
    }
}

