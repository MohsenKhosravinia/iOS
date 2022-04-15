//
//  API.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

enum API {
    case connectWallet
    case login
    case logout
    case rooms
    case createRoom
    case recordings(roomUID: String)
    case deleteRecording(roomUID: String, recordingID: String)
    case roomLink(_ roomUID: String)

    var endPoint: EndPoint {
        switch self {
        case .connectWallet:
            /// It is a dummy API because we should connect the wallet
            /// via a proper SDK. Wallet connect does not work at the moment.
            return EndPoint(path: "/api/v1/connectWallet")

        case .login:
            return EndPoint(path: "/api/v1/login")

        case .logout:
            /// It is a dummy api and not implemented at the moment
            return EndPoint(path: "/api/v1/logout")

        case .rooms:
            return EndPoint(path: "/api/v1/rooms")
            
        case .createRoom:
            return EndPoint(path: "/api/v1/rooms/create")

        case .recordings(let roomUID):
            return EndPoint(path: "/api/v1/recordings/\(roomUID)")
            
        case .deleteRecording(let roomUID, let recordingUID):
            return EndPoint(path: "/api/v1/recordings/\(roomUID)/\(recordingUID)")
            
        case .roomLink(let roomUID):
            return EndPoint(path: "/\(roomUID)")
        }
    }
}
