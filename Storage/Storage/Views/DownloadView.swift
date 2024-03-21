//
//  DownloadView.swift
//  Storage
//
//  Created by Sarah Clark on 3/21/24.
//

import SwiftUI
import UIKit

struct DownloadView: View {
    let file: DownloadFile

    @EnvironmentObject var model: StorageModel

    @State var fileData: Data?
    @State var isDownloadActive = false
    @State var duration = ""

    var body: some View {
        List {
            FileDetails(
                file: file,
                isDownloading: !model.downloads.isEmpty,
                isDownloadActive: $isDownloadActive,
                downloadSingleAction: {
                },
                downloadWithUpdatesAction: {
                },
                downloadMultipleAction: {
                }
            )
            if !model.downloads.isEmpty {
                // Show progress for any ongoing downloads.
                Downloads(downloads: model.downloads)
            }

            if !duration.isEmpty {
                Text("Duration: \(duration)")
                    .font(.caption)
            }

            if let fileData {
                // Show a preview of the file if it's a valid image.
                FilePreview(fileData: fileData)
            }
        }
        .animation(.easeOut(duration: 0.33), value: model.downloads)
        .listStyle(.insetGrouped)
        .toolbar {
            Button(action: {
            }, label: { Text("Cancel All") })
            .disabled(model.downloads.isEmpty)
        }
    }
}

