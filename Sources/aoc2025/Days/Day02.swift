struct Day02: DaySolver {
    let day = 2

    func is_invalid(_ s: String) -> Bool {
        var m = s.count / 2

        while m > 0 {
            if s.count % m == 0 {
                var i = m
                var matches = true

                let r = s.startIndex..<s.index(s.startIndex, offsetBy: m)
                let a = s[r]

                while m <= s.count - i {
                    let e = s.index(s.startIndex, offsetBy: i + m)
                    let v = s.index(s.startIndex, offsetBy: i)..<e
                    let b = e < s.endIndex ? s[v] : s.dropFirst(i)
                    
                    if a != b {
                        matches = false
                        break
                    }
                    
                    i += m
                }

                if matches {
                    return true
                }
            }

            m = m - 1
        }

        return false
    }

    func solvePart1(input: String) -> String {
        var sum = 0

        let ranges = input.trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: ",")
            .map {
                [
                    String($0.split(separator: "-")[0]),
                    String($0.split(separator: "-")[1])
                ]
            }

        for range in ranges {
            let low = Int(range[0])!
            let hi = Int(range[1])!

            for i in low..<hi+1 {
                let s = String(i)
                let m = s.count / 2
                if (s.count & 1) == 0 && s.dropLast(m) == s.dropFirst(m) {
                    sum += i
                }
            }
        }

        return "\(sum)"
    }

    func solvePart2(input: String) -> String {
        var sum = 0

        let ranges = input.trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: ",")
            .map {
                [
                    String($0.split(separator: "-")[0]),
                    String($0.split(separator: "-")[1])
                ]
            }

        for range in ranges {
            let low = Int(range[0])!
            let hi = Int(range[1])!

            for i in low..<hi+1 {
                let s = String(i)
                if s == "2121212118" {
                    sum += 1
                    sum -= 1
                }
                if is_invalid(s) {
                    sum += i
                }
            }
        }

        return "\(sum)"
    }
}
