//
//  UIViewController+Preview.swift
//  ExampleCanvas
//
//  Created by Mohsen Khosravinia on 2/17/23.
//

import UIKit

// MARK: - Preview for UINavigationControllers

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UINavigationControllerPreview: UIViewControllerRepresentable {
    let navigationController: UINavigationController
    
    init(_ builder: @escaping () -> UINavigationController) {
        navigationController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    
    func makeUIViewController(context: Context) -> UINavigationController {
        navigationController
    }

    func updateUIViewController(
        _ uiViewController: UINavigationController,
        context: UIViewControllerRepresentableContext<UINavigationControllerPreview>
    ) {
        return
    }
}
#endif

// MARK: - Preview for UIViewControllers

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    func updateUIViewController(
        _ uiViewController: ViewController,
        context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>
    ) {
        return
    }
}
#endif
