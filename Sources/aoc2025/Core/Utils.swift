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