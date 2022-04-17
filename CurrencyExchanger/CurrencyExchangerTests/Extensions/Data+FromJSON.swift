//
//  Data+FromJSON.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

import Foundation
import XCTest

extension Data {
    
    public static func fromJSON(fileName: String,
                                file: StaticString = #file,
                                line: UInt = #line) throws -> Data {
        let bundle = Bundle(for: TestBundleClass.self)
        let resourceURL = bundle.url(forResource: fileName, withExtension: "json")
        let url = try XCTUnwrap(resourceURL,
                                "Unable to find \(fileName).json. Did you add it to the tests?",
                                file: file, line: line)
        return try Data(contentsOf: url)
    }
}

private class TestBundleClass { }
