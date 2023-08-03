import Foundation

private extension Array where Element == Bool {
    func allTrue() -> Bool {
        allSatisfy { $0 }
    }
    
    func oneTrue() -> Bool {
        for item in self {
            if item {
                return true
            }
        }
        return false
    }
}

let array: [Bool?] = [true, true, true]
array.allTrue()

let array2: [Bool?] = [false, false, false, false]
array2.oneTrue()
