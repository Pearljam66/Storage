//
//  DownloadFile.swift
//  Storage
//
//  Created by Sarah Clark on 3/21/24.
//

import Foundation

struct DownloadFile: Codable, Identifiable, Equatable {
    var id: String { return name }
    let name: String
    let size: Int
    let date: Date
    static let empty = DownloadFile(name: "", size: 0, date: Date())
}
