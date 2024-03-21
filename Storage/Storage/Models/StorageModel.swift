//
//  StorageModel.swift
//  Storage
//
//  Created by Sarah Clark on 3/21/24.
//

import Foundation

class StorageModel: ObservableObject {
    @Published var downloads: [DownloadInfo] = []

    @MainActor var stopDownloads = false
    @MainActor func reset() {
        stopDownloads = false
        downloads.removeAll()
    }

    func download(file: DownloadFile) async throws -> Data {
        guard let url = URL(string: "http://localhost:8080/files/download?\(file.name)") else {
            throw "Could not create the URL"
        }
        return Data()
    }

    func downloadWithProgress(file: DownloadFile) async throws -> Data {
        return try await downloadWithProgress(fileName: file.name, name: file.name, size: file.size)
    }

    private func downloadWithProgress(fileName: String, name: String, size: Int, offset: Int? = nil) async throws -> Data {
        guard let url = URL(string: "http://localhost:8080/files/download?\(fileName)") else {
            throw "Could not create the URL"
        }
        await addDownload(name: name)
        return Data()
    }

    func multiDownloadWithProgress(file: DownloadFile) async throws -> Data {
        func partInfo(index: Int, of count: Int) -> (offset: Int, size: Int, name: String) {
            let standardPartSize = Int((Double(file.size) / Double(count)).rounded(.up))
            let partOffset = index * standardPartSize
            let partSize = min(standardPartSize, file.size - partOffset)
            let partName = "\(file.name) (part \(index + 1))"
            return (offset: partOffset, size: partSize, name: partName)
        }
        let total = 4
        let parts = (0..<total).map { partInfo(index: $0, of: total) }
        return Data()
    }
}

extension StorageModel {

    func addDownload(name: String) {
        let downloadInfo = DownloadInfo(id: UUID(), name: name, progress: 0.0)
        downloads.append(downloadInfo)
    }

    func updateDownload(name: String, progress: Double) {
        if let index = downloads.firstIndex(where: { $0.name == name }) {
            var info = downloads[index]
            info.progress = progress
            downloads[index] = info
        }
    }
}
