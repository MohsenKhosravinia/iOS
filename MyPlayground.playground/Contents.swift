import Foundation
import SwiftAlgorithm

extension Double {
    init(binomial n: Int, _ k: Int) {
        if k > n {
            self = 0.0
        } else if k == 0 {
            self = 1.0
        } else {
            var n: Int = n
            var i: Double = 1.0
            for d in 1...k {
                i *= Double(n)
                i /= Double(d)
                n -= 1
            }
            self = i
        }
    }
}

//let n = 4
//let k = 1
//Double(binomial: n, k)
//
//let result = zip(1...n, stride(from: n, to: n - k, by: -1)).reduce(1) {
//    ($0 * Double($1.1)) / Double($1.0)
//}

let k: Int = 9
let n: Int = 10

let strided = stride(from: n, to: n - k, by: -1)
print(dump(strided))
let array = Array(strided)
let zipped = zip(1...k, strided)
let result = zipped.reduce(1) {
    print($0, "*", Double($1.1), "/", Double($1.0))
    return ($0 * Double($1.1)) / Double($1.0)
}

let
