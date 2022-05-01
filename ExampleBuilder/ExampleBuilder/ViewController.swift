//
//  ViewController.swift
//  ExampleBuilder
//
//  Created by Mohsen Khosravinia on 5/1/22.
//

import UIKit

class ViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        let director = Employee()
        let burger = try? director.createKittenSpecial()
        titleLabel.text = burger?.description ?? "Couldn't find description"
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.frame = view.bounds
        titleLabel.center = view.center
    }

}

