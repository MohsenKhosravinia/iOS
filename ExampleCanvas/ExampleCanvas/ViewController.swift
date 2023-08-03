//
//  ViewController.swift
//  ExampleCanvas
//
//  Created by Mohsen Khosravinia on 2/17/23.
//

import UIKit
import Stevia

final class ViewController: UIViewController {
    private let normalView = UIView()
    private let steviaView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Test Test Test Test Test Test"
        
        addSomeViewWithNSLayoutConstraints()
        addSomeViewWithStevia()
    }
    
    private func addSomeViewWithNSLayoutConstraints() {
        view.addSubview(normalView)
        normalView.translatesAutoresizingMaskIntoConstraints = false
        normalView.backgroundColor = .red
        normalView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            normalView.heightAnchor.constraint(equalToConstant: 200),
            normalView.widthAnchor.constraint(equalToConstant: 100),
            normalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            normalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addSomeViewWithStevia() {
        view.subviews(
            steviaView.style { view in
                view.backgroundColor = .black
                view.layer.cornerRadius = 20
            }
        )
        
        view.layout(
            120,
            |-16-steviaView.height(50)-16-|
        )
    }
}

final class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.backgroundColor = .systemOrange
        navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.black
        ]
    }
}

// MARK: - Preview

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CustomNavigationController_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            UINavigationControllerPreview {
                let viewController = ViewController()
                return CustomNavigationController(rootViewController: viewController)
            }
            .edgesIgnoringSafeArea(.all)

//            UIViewControllerPreview {
//                let viewController = ViewController()
//                viewController.view.backgroundColor = .systemIndigo
//                return viewController
//            }
//            .edgesIgnoringSafeArea(.all)
        }
    }
}
#endif
