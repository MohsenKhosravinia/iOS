import Foundation
import CryptoKit

//final class WalletRequest {
//    let noncechars = "0123456789abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
//    let macid: String
//    let macsecret: String
//    let ext: String
//
//    init(macid: String, macsecret: String, ext: String) {
//        self.macid = macid
//        self.macsecret = macsecret
//        self.ext = ext
//    }
//}
//
//extension WalletRequest {
//    func urlencode(_ data: [String: String]) -> String {
//        var str = [String]()
//        for p in data.keys {
//            let encodedKey = p.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            let encodedValue = data[p]!.replacingOccurrences(
//                of: "{{[^}]+}}",
//                with: { match in
//                    let variableName = match.dropFirst(2).dropLast(2)
//                    return pm.environment.get(variableName)
//                },
//                options: .regularExpression
//            )
//            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            .replacingOccurrences(of: "%20", with: "+")
//
//            str.append("\(encodedKey)=\(encodedValue)")
//        }
//        let joinedString = str.joined(separator: "&")
//        return joinedString
//    }
//
//    func signRequest(host: String, port: Int, path: String, body: Any?, method: String) -> [String: String] {
//        let timestamp = Int(Date().timeIntervalSince1970)
//        let nonce = self.getNonce()
//        var ext: String?
//
//        if let bodyDict = body as? [String: String], !bodyDict.isEmpty {
//            ext = self.urlencode(bodyDict)
//        }
//
//        if let bodyString = body as? String, !bodyString.isEmpty {
//            if var extString = ext {
//                extString += "&"
//                extString += "body_hash=\(self.createbodyhash(bodyString))"
//                ext = extString
//            } else {
//                ext = "body_hash=\(self.createbodyhash(bodyString))"
//            }
//        }
//
//        let messageHash = self.createMessageHash(
//            timestamp: timestamp,
//            nonce: nonce,
//            method: method,
//            path: path,
//            host: host,
//            port: port,
//            ext: ext ?? "",
//            macsecret: self.macSecret
//        )
//
//        return self.createAuthorizationHeader(
//            macId: self.macId,
//            timestamp: timestamp,
//            nonce: nonce,
//            messageHash: messageHash,
//            ext: ext
//        )
//    }
//
//    func getNonce() -> String {
//        var result = ""
//        for i in stride(from: 64, to: 0, by: -1) {
//            let randomIndex = Int.random(in: 0..<noncechars.count)
//            result += String(noncechars[randomIndex])
//        }
//        return result
//    }
//
//    func createBodyHash(body: String) -> String {
//        let data = Data(body.utf8)
//        let sha256 = SHA256.hash(data: data)
//        return sha256.base64EncodedString()
//    }
//
//    func createMessageHash(timestamp: String, nonce: String, method: String, path: String, host: String, post: String, ext: String) -> String {
//        let message = "\(timestamp)\n\(nonce)\n\(method)\n\(path)\n\(host)\n\(port)\n\(ext)\n"
//        let messageData = Data(message.utf8)
//        let keyData = Data(key.utf8)
//        let hmac = HMAC<SHA256>.authenticationCode(for: messageData, using: SymmetricKey(data: keyData))
//        let base64Hmac = Data(hmac).base64EncodedString()
//        return base64Hmac
//    }
//
//    func createAuthorizationHeader(id: String, timestamp: String, nonce: String, messagehash: String, ext: String) -> String {
//        "mac id=\"\(id)\", ts=\"\(timestamp)\", nonce=\"\(nonce)\", mac=\"\(messagehash)\", ext=\"\(ext)\""
//    }
//}
//
//
//func process() {
//    let wr = WalletRequest(macid: macid, macsecret: macsecret, ext: ext)
//    var fullurl = request.url
//    fullurl = fullurl.replacingOccurrences(of: "\\{\\{(.*?)\\}\\}", with: { match in
//        let variable = String(match[match.index(match.startIndex, offsetBy: 2)..<match.index(match.endIndex, offsetBy: -2)])
//        return pm.environment.get(variable)
//    }, options: .regularExpression)
//
//    let url = URL(string: fullurl)!
//    let scheme = url.scheme ?? "http"
//    let host = url.host ?? ""
//    let path = url.path
//    let port = (scheme == "https") ? 443 : 80
//
//    let path = "/" + (url.path ?? "")
//    let authheader = wr.signrequest(host: host, port: port, path: path, data: request.data, method: request.method)
//    pm.request.headers.add(key: "authorization", value: authheader)
//
//
//}



//
//let timestamp = Int(Date().timeIntervalSince1970)
//let nonce = self.getnonce()
//let ext = self.ext ?? ""
//
//if let bodyDict = body as? [String: String] {
//    let encodedBody = self.urlencode(bodyDict)
//    // pm.environment.set("debug", encodedBody)
//    body = encodedBody
//}
//
//if let bodyString = body as? String, !bodyString.isEmpty {
//    if var extString = ext {
//        extString += "&"
//        extString += "body_hash=\(self.createbodyhash(bodyString))"
//        ext = extString
//    } else {
//        ext = "body_hash=\(self.createbodyhash(bodyString))"
//    }
//}
//
//let messagehash = self.createmessagehash(
//    timestamp: timestamp,
//    nonce: nonce,
//    method: method,
//    path: path,
//    host: host,
//    port: port,
//    ext: ext ?? "",
//    macsecret: self.macsecret
//)


let requestURL = URL(string: "https://wallet-api.paysera.com/rest/v1/transfers?credit_account_number=EVP4710004322356&limit=50&offset=0&statuses%5B%5D=signed&statuses%5B%5D=prepared&statuses%5B%5D=processing&statuses%5B%5D=reserved&statuses%5B%5D=registered&statuses%5B%5D=ready&statuses%5B%5D=success&statuses%5B%5D=waitingFunds")!
let index = requestURL.absoluteString.range(of: (requestURL.path))?.lowerBound
let fullPath = requestURL.absoluteString.suffix(from: index!)
print(fullPath)
