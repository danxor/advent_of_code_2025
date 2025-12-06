extension BinaryInteger {
    func mod(_ n: Self) -> Self {
        precondition(n != 0, "Modulo by zero is undefined")
        return (self % n + n) % n
    }
}

extension String {
    func lines(includeEmpty: Bool = true) -> [String] {
        let result = self.components(separatedBy: .newlines)
            .map {
                $0.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .filter {
                !$0.isEmpty || includeEmpty
            }

        return result
    }

    func substr(from: Int, len: Int) -> String {
        var tmp = self.dropFirst(from)
        if tmp.count > len {
            tmp.removeLast(tmp.count - len)
        }

        return String(tmp)
    }
}

struct Utils {
    static func transpose<T>(_ matrix: [[T]], default_value: T) -> [[T]] {
        let rows = matrix.count
        let cols = matrix[0].count

        var result: [[T]] = Array(
            repeating: Array(repeating: default_value, count: rows),
            count: cols
        )

        for i in 0..<rows {
            for j in 0..<cols {
                result[j][i] = matrix[i][j]
            }
        }

        return result
    }
}