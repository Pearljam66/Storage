//
//  ByteAccumulator.swift
//  Storage
//
//  Created by Sarah Clark on 3/21/24.
//

import Foundation

struct ByteAccumulator: CustomStringConvertible {
    private var offset = 0
    private var counter = -1
    private let name: String
    private let size: Int
    private let chunkCount: Int
    private var bytes: [UInt8]
    var data: Data { return Data(bytes[0..<offset]) }

    init(name: String, size: Int) {
        self.name = name
        self.size = size
        chunkCount = max(Int(Double(size) / 20), 1)
        bytes = [UInt8](repeating: 0, count: size)
    }

    var isBatchCompleted: Bool {
        return counter >= chunkCount
    }

    var description: String {
        "[\(name)] \(sizeFormatter.string(fromByteCount: Int64(offset)))"
    }

    var progress: Double {
        Double(offset) / Double(size)
    }

    mutating func append(_ byte: UInt8) {
        bytes[offset] = byte
        counter += 1
        offset += 1
    }

    mutating func checkCompleted() -> Bool {
        defer { counter = 0 }
        return counter == 0
    }


}
