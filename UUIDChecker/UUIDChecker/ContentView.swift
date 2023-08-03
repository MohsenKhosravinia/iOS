//
//  ContentView.swift
//  UUIDChecker
//
//  Created by Mohsen Khosravinia on 1/17/23.
//

import SwiftUI
import AdSupport

struct ContentView: View {
    @ObservedObject var vm: ViewModel
    
    init(vm: ViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
            Text(vm.uuidString)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ViewModel())
    }
}

class ViewModel: ObservableObject {
    @Published var uuidString: String
    
    init() {
//        uuidString = UIDevice.current.identifierForVendor!.uuidString
        uuidString = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
}
