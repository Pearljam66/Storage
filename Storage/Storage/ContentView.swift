//
//  ContentView.swift
//  Storage
//
//  Created by Sarah Clark on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    let model: StorageModel

    @State var files: [DownloadFile] = []
    @State var status = ""
    @State var isDisplayingDownload = false
    @State var isDisplayingError = false
    @State var selected = DownloadFile.empty {
        didSet {
            isDisplayingDownload = true
        }
    }
    @State var lastErrorMessage = "None" {
        didSet {
            isDisplayingError = true
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(content: {
                        if files.isEmpty {
                            ProgressView().padding()
                        }
                        ForEach(files) { file in
                            Button(action: {
                                selected = file
                            }, label: {
                                FileListItem(file: file)
                            })
                        }
                    }, header: {
                        Label(" Storage", systemImage: "externaldrive.badge.icloud")
                            .font(.title)
                            .foregroundStyle(Color.accentColor)
                            .padding(.bottom, 20)
                    }, footer: {
                        Text(status)
                    })
                }
                .listStyle(.insetGrouped)
                .animation(.easeOut(duration: 0.33), value: files)
            }
            .alert("Error", isPresented: $isDisplayingError, actions: {
                Button("Close", role: .cancel) { }
            }, message: {
                Text(lastErrorMessage)
            })
            .navigationDestination(isPresented: $isDisplayingDownload) {
                DownloadView(file: selected).environmentObject(model)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(model: StorageModel())
}
