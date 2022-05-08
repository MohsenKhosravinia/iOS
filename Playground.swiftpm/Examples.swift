//
//  Examples.swift
//  Playground
//
//  Created by Mohsen Khosravinia on 5/6/22.
//

import Foundation

var result: Result<[String], Error>!

result = .success(["test1", "test2"])

let success = try? result.get()

print(success)
