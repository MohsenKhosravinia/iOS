//
//  ViewController.swift
//  JailbreakDetection
//
//  Created by Mohsen Khosravinia on 4/21/23.
//

import UIKit
import JailbreakDetector

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(JailbreakDetector.isJailbroken())
    }
}

