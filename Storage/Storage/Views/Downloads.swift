//
//  Downloads.swift
//  Storage
//
//  Created by Sarah Clark on 3/21/24.
//

import SwiftUI

struct Downloads: View {
    let downloads: [DownloadInfo]
    var body: some View {
        ForEach(downloads) { download in
            VStack(alignment: .leading) {
                Text(download.name).font(.caption)
                ProgressView(value: download.progress)
            }
        }
    }
}
