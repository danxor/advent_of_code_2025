import Foundation

struct Config {
    let year: Int
    let session: String

    static func create(filename: String) throws -> Config {
        var year: Int = 2025
        var session: String = ""

        if FileManager.default.fileExists(atPath: filename) {
            let content = try String.init(contentsOfFile: filename, encoding: .utf8)
                .components(separatedBy: .newlines)

            for line: String in content {
                if line.count == 0 {
                    continue
                }

                let noComment = line.split(separator: "#", maxSplits: 1, omittingEmptySubsequences: true).first!

                let cleaned = noComment.trimmingCharacters(in: .whitespacesAndNewlines)

                let parts = cleaned.split(separator: "=", maxSplits: 1)

                let key = parts[0].trimmingCharacters(in: .whitespaces)
                let value = parts[1].trimmingCharacters(in: .whitespaces)

                switch key {
                    case "YEAR":
                        year = Int(value)!
                        break
                    case "SESSION":
                        session = value
                        break
                    default:
                        break
                }
            }
    
            return Config(year: year, session: session)
        } else {
            throw NSError(
                domain: NSCocoaErrorDomain,
                code: NSFileNoSuchFileError,
                userInfo: [
                    NSLocalizedDescriptionKey: "File not found: \(filename)"
                ]
            )
        }
    }
}