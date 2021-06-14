//
//  SocketConnector.swift
//  TetViet
//
//  Created by vinhdd on 12/17/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Starscream
import SwiftyJSON
import SocketIO

class SocketIOService {
    
    // MARK: - Singleton
    static let instance = SocketIOService()
    
    // MARK: - Variables
    private var socketIO: SocketIOClient?
    private var managerIO: SocketManager?
    
    // MARK: - Closures
    var didReceiveJSON: ((_ json: JSON) -> Void)?
    var didConnect: (() -> Void)?
    var didDisconnect: (() -> Void)?
    
    // MARK: - Init & deinit
    init() {
        // Do nothing
    }
    
    // MARK: - Socket action
        
    func disconnectSocket() {
        print("-> [IO Socket] is disconnected!")
        managerIO?.defaultSocket.disconnect()
        managerIO = nil
    }
    
    func write(string: String) {
        print("-> [IO Socket] will write: \(string)")
        socketIO?.emit("/ws/livechat", string)
    }
    
    func isSocketConnected() -> Bool {
        return managerIO?.defaultSocket.status == .connected
    }
}
