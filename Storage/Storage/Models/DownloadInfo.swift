//
//  DownloadInfo.swift
//  Storage
//
//  Created by Sarah Clark on 3/21/24.
//

import Foundation

struct DownloadInfo: Identifiable, Equatable {
    let id: UUID
    let name: String
    var progress: Double
}
