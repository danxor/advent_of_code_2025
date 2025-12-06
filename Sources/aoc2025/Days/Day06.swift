struct Day06: DaySolver {
    let day = 6

    func parse(_ input: String) -> ([String], [[String]]) {
        let tmp = input.split(separator: "\n")
            .map {
                String.init($0)
            }

        let operations = tmp[tmp.count - 1]
            .split(separator: " ", omittingEmptySubsequences: true)
            .map {
                String.init($0)
            }

        let lines = tmp.dropLast()

        var splitters = [Int]()

        for j in 0..<lines[0].count {
            var isOnlyWhitespace = true

            for i in 0..<lines.count {
                let ch = lines[i].substr(from: j, len: 1)
                if ch != " " {
                    isOnlyWhitespace = false
                    break
                }
            }

            if (isOnlyWhitespace) {
                splitters.append(j)
            }
        }

        var items = [[String]]()
        for row in 0..<lines.count {
            var group = [String]()

            let line = lines[row]

            var x = 0
            var j = 0
            while j < splitters.count {
                let v = line.substr(from: x, len: splitters[j] - x)
                x = 1 + splitters[j]
                group.append(v)
                j += 1
            }

            if x < line.count {
                let v = line.substr(from: x, len: line.count - x)
                group.append(v)
            }

            items.append(group)
        }

        return (operations, Utils.transpose(items, default_value: ""))
    }

    func solvePart1(input: String) -> String {
        var sum = 0

        let res = parse(input)
        let operations = res.0

        let numbers = res.1
            .map {
                $0.map {
                    Int($0.trimmingCharacters(in: .whitespaces))!
                }
            }

        for row in 0..<numbers.count {
            let op = operations[row]

            var s = op == "*" ? 1 : 0
            for value in numbers[row] {
                if op == "*" {
                    s *= value
                } else {
                    s += value
                }
            }

            sum += s
        }

       return "\(sum)"
    }

    func solvePart2(input: String) -> String {
        var sum = 0

        let res = parse(input)

        let operations = res.0
        let items = res.1

        for row in 0..<items.count {
            let op = operations[row]

            var tmp = [[String.Element]]()
            for col in 0..<items[row].count {
                let cell = Array(items[row][col])
                tmp.append(cell)
            }

            let values = Utils.transpose(tmp, default_value: " ")
                .map {
                    String($0).trimmingCharacters(in: .whitespaces)
                }
                .map {
                    Int($0)!
                }

            var s = op == "*" ? 1 : 0
            for value in values {
                if op == "*" {
                    s *= value
                } else {
                    s += value
                }
            }

            sum += s
        }

        return "\(sum)"
    }
}
