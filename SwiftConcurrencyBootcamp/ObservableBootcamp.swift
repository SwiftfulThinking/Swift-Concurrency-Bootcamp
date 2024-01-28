//
//  ObservableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Nick Sarno on 1/28/24.
//

import SwiftUI

actor TitleDatabase {
    
    func getNewTitle() -> String {
        "Some new title!"
    }
}

@Observable class ObservableViewModel {
    
    @ObservationIgnored let database = TitleDatabase()
    @MainActor var title: String = "Starting title"
    
    
    func updateTitle() {
        Task { @MainActor in
            title = await database.getNewTitle()
            print(Thread.current)
        }
    }
}

struct ObservableBootcamp: View {
    
    @State private var viewModel = ObservableViewModel()
    
    var body: some View {
        Text(viewModel.title)
            .task {
                viewModel.updateTitle()
            }
    }
}

#Preview {
    ObservableBootcamp()
}
