import Foundation

var result: Result<[String], Error>!
result = .success(["ONE", "TWO"])

let success = try? result.get()

print(String(describing: success))

