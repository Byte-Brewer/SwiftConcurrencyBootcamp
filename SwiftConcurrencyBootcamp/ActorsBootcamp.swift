//
//  ActorsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Nazar Prysiazhnyi on 21.02.2023.
//

import SwiftUI

class MyDataManager {
    
    static let instance = MyDataManager()
    private init() {}
    
    var data: [String] = []
    private let queue = DispatchQueue(label: "com.MyApp.MyDataManager")
    
    func getRandomData(completionHandler: @escaping (_ titlr: String?) -> ()) {
        queue.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandler(self.data.randomElement())
        }
    }
}

actor MyActorDataManager {
    
    static let instance = MyActorDataManager()
    private init() {}
    
    var data: [String] = []
    nonisolated let myRandomText = "Montana"
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
    
    nonisolated func getSaveData() -> String {
        return "New Data"
    }
}

struct HomeView: View {
    
    let manager = MyActorDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onAppear {
            let text = manager.myRandomText
            let newData = manager.getSaveData()
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
            /*
            DispatchQueue.global(qos: .default).async {
                manager.getRandomData { title in
                    if let title {
                        DispatchQueue.main.async {
                            self.text = title
                        }
                    }
                }
            }
            */
        }
    }
}

struct BrowseView: View {
    
    let manager = MyActorDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
//            DispatchQueue.global(qos: .background).async {
//                if let data = manager.getRandomData() {
//                    DispatchQueue.main.async {
//                        self.text = data
//                    }
//                }
//            }
        }
    }
}

struct ActorsBootcamp: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

struct ActorsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActorsBootcamp()
    }
}
