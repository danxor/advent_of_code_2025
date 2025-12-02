import Foundation
import FoundationNetworking

struct InputDownloader {
    @MainActor
    static func fetch(config: Config, day: Int) async throws -> String {
        let url = URL(string: "https://adventofcode.com/\(config.year)/day/\(day)/input")!
        var request = URLRequest(url: url)
        request.setValue("session=\(config.session)", forHTTPHeaderField: "Cookie")

        let (data, _) = try await URLSession.shared.data(for: request)
        return String(decoding: data, as: UTF8.self)
    }

    @MainActor
    static func ensureInputFile(config: Config, day: Int) async throws -> String {
        let dir = "Inputs/"
        let filename = "\(dir)/\(String(format: "day%02d.txt", day))"

        if !FileManager.default.fileExists(atPath: filename) {
            try FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true)
            let input = try await fetch(config: config, day: day)
            try input.write(toFile: filename, atomically: true, encoding: .utf8)
        }

        return try String.init(contentsOfFile: filename, encoding: .utf8)
    }
}
