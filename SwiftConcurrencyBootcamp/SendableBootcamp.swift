//
//  SendableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Nick Sarno on 4/4/22.
//

import SwiftUI

actor CurrentUserManager {
    
    func updateDatabase(userInfo: MyClassUserInfo) {
        
    }
    
}

struct MyUserInfo: Sendable {
    var name: String
}

final class MyClassUserInfo: @unchecked Sendable {
    private var name: String
    let queue = DispatchQueue(label: "com.MyApp.MyClassUserInfo")
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(name: String) {
        queue.async {
            self.name = name
        }
    }
}

class SendableBootcampViewModel: ObservableObject {
    
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        
        let info = MyClassUserInfo(name: "info")
        
        await manager.updateDatabase(userInfo: info)
    }
    
}

struct SendableBootcamp: View {
    
    @StateObject private var viewModel = SendableBootcampViewModel()
    
    var body: some View {
        Text("Hello, World!")
            .task {
                
            }
    }
}

struct SendableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SendableBootcamp()
    }
}
