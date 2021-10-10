//
//  ViewController.swift
//  ExampleTesting
//
//  Created by Mohsen Khosravinia on 10/10/21.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: LoginViewModelInterface!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = LoginViewModel()
    }


}

