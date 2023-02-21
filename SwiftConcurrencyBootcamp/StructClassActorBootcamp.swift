//
//  StructClassActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Nazar Prysiazhnyi on 21.02.2023.
//

/*
 Links:
 - https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language
 - https://medium.com/@vinayakkini/swift-basics-struct-vs-class-31b44ade28ae
 - https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language/59219141#59219141
 - https://stackoverflow.com/questions/27441456/swift-stack-and-heap-understanding
 - https://stackoverflow.com/questions/24232799/why-choose-struct-over-class/24232845
 - https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
 - https://medium.com/doyeona/automatic-reference-counting-in-swift-arc-weak-strong-unowned-925f802c1b99

 VALUE TYPES:
 - Struct, Enum, String, Int, ect.
 - Stored in the stack
 - Faster
 - Thread safe!
 - when we assign or pass value type a new copy of data is created
 
 REFERENCE TYPES:
 - Class, Function, Actor
 - Stored in the Heap
 - Slower, but synchronized
 - NOT Thread safe
 - When yu assign or pass reference type a new refereence to original instance will be created (pointer)
 
 -----------------------
 
 STACK:
 - Stores value types
 - Variables allocated on the stack are stored directly to the memory, and access to thish is very fast
 - Each thread has it's own stack!
 
 HEAP:
 - Stores Reference types
 - Shared acroos threads!
 
 ---------------------
 
 STRUCT:
 - Based on VALUES
 - Can be mutated
 - Stored in the Stack!
 
 CLASS:
 - Base on REFERENCES (INSTANCES)
 - Stored in the Heap!
 - Inherit from other classes
 
 ACTOR:
 - Same as Class, but thread safe!

 --------------------------------
 
 Structs: Data Models, Views
 Classes: ViewModels
 Actors: Shared 'Manager' and 'Data Stores'

 */

import SwiftUI

actor StructClassActorBootcampDataManager {
    
    func getDataFromDataBase() {
        
    }
    
}


class StructClassActorBootcampViewModel: ObservableObject {
    
    @Published var title: String = ""
    
    init() {
        print("init ViewModel")
    }
}

struct StructClassActorBootcamp: View {
    
    @StateObject private var viewNodel = StructClassActorBootcampViewModel()
    let isActive: Bool
    
    init(isActive: Bool) {
        self.isActive = isActive
        print("init View")
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(isActive ? .red : .blue)
            .onAppear {
                print("Hello world")
            }
    }
}

struct StructClassActorBootcampHomeView: View {
    
    @State private var isActive: Bool = false
    
    var body: some View {
        StructClassActorBootcamp.init(isActive: isActive)
            .onTapGesture {
                isActive.toggle()
            }
    }
    
}

struct StructClassActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StructClassActorBootcamp(isActive: true)
    }
}
