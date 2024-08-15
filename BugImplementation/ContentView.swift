//
//  ContentView.swift
//  BugImplementation
//
//  Created by daniiorlov on 15.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ContentViewWithState()
        }
    }
}

struct ContentViewWithState: View {
    enum ContentState {
        case loading
        case loaded(content: String)
    }

    @State private var state: ContentState = .loading
    @State private var isActive = false
    
    var body: some View {
        Group {
            switch state {
            case .loading:
                VStack(spacing: 16) {
                    ProgressView()
                    
                    Button("Перейти на другой экран") {
                        isActive = true
                    }
                }
            case .loaded(let content):
                Label(content, image: "trash.fill")
            }
        }
        .overlay {
            NavigationLink(isActive: $isActive) {
                Text("Ожидаем баг")
            } label: {
                EmptyView()
            }
            .hidden()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.state = .loaded(content: "trash")
            }
        }
    }
}

#Preview {
    ContentView()
}
