struct Day05: DaySolver {
    let day = 5

    func is_in_range(_ ranges: [(Int, Int)], _ ingredient: Int) -> Bool {
        for range in ranges {
            if range.0 <= ingredient && ingredient <= range.1 {
                return true
            }
        }

        return false
    }

    func compact_ranges(_ ranges: [(Int, Int)]) -> [(Int, Int)] {
        let sorted = ranges.sorted { $0.0 < $1.0 }

        var result: [(Int, Int)] = []
        var current = sorted[0]

        for range in sorted.dropFirst() {
            if range.0 <= current.1 {
                current.1 = max(current.1, range.1)
            } else {
                result.append(current)
                current = range
            }
        }

        result.append(current)

        return result
    }

    func solvePart1(input: String) -> String {
        var fresh = 0

        let parts = input.split(separator: "\n\n")

        let tmp = parts[0].split(separator: "\n").map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }.map {
            $0.split(separator: "-")
        }

        let ranges = tmp.map {
            (
                Int($0[0])!,
                Int($0[1])!
            )
        }

        let ingredients = parts[1].split(separator: "\n").map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }.map {
            Int($0)!
        }

        for ingredient in ingredients {
            if is_in_range(ranges, ingredient) {
                fresh += 1
            }
        }

        return "\(fresh)"
    }

    func solvePart2(input: String) -> String {
        var sum = 0

        let parts = input.split(separator: "\n\n")

        let tmp = parts[0].split(separator: "\n").map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }.map {
            $0.split(separator: "-")
        }

        let ranges = tmp.map {
            (
                Int($0[0])!,
                Int($0[1])!
            )
        }

        let overlapped = compact_ranges(ranges)

        for range in overlapped {
            sum += 1 + range.1 - range.0
        }

        return "\(sum)"
    }
}
