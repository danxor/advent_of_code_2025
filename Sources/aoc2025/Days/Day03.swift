struct Day03: DaySolver {
    let day = 3

    func solvePart1(input: String) -> String {
        var sum = 0

        let lines = input.lines(includeEmpty: false)

        for line in lines {
            var max = Int.min

            for i in 0..<line.count {
                let first = line.substr(from: i, len: 1)

                for j in i + 1..<line.count {
                    let second = line.substr(from: j, len: 1)

                    let num = Int(first + second)!

                    if max < num {
                        max = num
                    }
                }
            }

            sum += max
        }

        return "\(sum)"
    }

    func solvePart2(input: String) -> String {
        var sum = 0

        let lines = input.lines(includeEmpty: false)

        for line in lines {
            var first = 0
            var last = line.count - 12
            var max = 0
            
            for _ in 1...12 {
                var tmp = 0

                last += 1
                
                for i in first..<last {
                    let v = Int(line.substr(from: i, len: 1))!
                    if v > tmp {
                        tmp = v
                        first = i + 1
                    }
                }

                max = 10 * max + tmp
            }
            
            sum += max
        }

        return "\(sum)"
    }
}
