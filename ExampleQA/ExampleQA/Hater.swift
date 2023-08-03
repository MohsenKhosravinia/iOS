//
//  Hater.swift
//  ExampleQA
//
//  Created by Mohsen Khosravinia on 5/2/23.
//

import Foundation

struct Hater {
    var hating = false
    
    mutating func hadABadDay() {
        hating = true
    }
    
    mutating func hadAGoodDay() {
        hating = false
    }
}
