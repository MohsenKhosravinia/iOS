import Algorithms

let array = ["A", "B", "C", "D", "E", "F", "G", "H"]
let combinations = array.combinations(ofCount: 3)
let uniqueCombinations = Set(combinations)

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

let uniqueCombinations2 = Double(binomial: array.count, 3)
