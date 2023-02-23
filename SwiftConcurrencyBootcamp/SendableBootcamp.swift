//
//  SendableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Nazar Prysiazhnyi on 23.02.2023.
//

import SwiftUI


actor CurrentUserManager {
    
    func updaneDatabase(userInfo: MyClassUserInfo) {
        
    }
}

struct MyUserInfi: Sendable {
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

class SendablrBootcamVieewModel: ObservableObject {
    
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        
        let info = MyClassUserInfo(name: "Info")
        
        await manager.updaneDatabase(userInfo: info)
    }
}


struct SendableBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SendableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SendableBootcamp()
    }
}
