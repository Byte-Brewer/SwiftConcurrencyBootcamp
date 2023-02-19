//
//  AsyncAwaitBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Nazar Prysiazhnyi on 17.02.2023.
//

import SwiftUI


class AsyncAwaitBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTittle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dataArray.append("Title1 : \(Thread.current)")
        }
    }
    
    func addTittle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            let title = "Title2 : \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)
                self.dataArray.append("Title3 : \(Thread.current)")
            }
        }
    }
    

    func addAuthor1() async {
        let author1 = "Author1 : \(Thread.current)"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let author2 = "Author2 : \(Thread.current)"
        await MainActor.run(body: {
            self.dataArray.append(author2)
            let author3 = "Author3 : \(Thread.current)"
            self.dataArray.append(author3)
        })
        
        await addSomething()
    }
    
    func addSomething() async {
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something1 = "Something1 : \(Thread.current)"
        await MainActor.run(body: {
            self.dataArray.append(something1)
            let something2 = "Something2 : \(Thread.current)"
            self.dataArray.append(something2)
        })
    }
}

struct AsyncAwaitBootcamp: View {
    
    @StateObject private var viewModel = AsyncAwaitBootcampViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
//            viewModel.addTittle1()
//            viewModel.addTittle2()
            Task {
                await viewModel.addAuthor1()
                
                let text = "Final Text : \(Thread.current)"
                viewModel.dataArray.append(text)
            }
        }
    }
}

struct AsyncAwaitBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitBootcamp()
    }
}

