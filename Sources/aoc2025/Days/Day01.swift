struct Day01: DaySolver {
    let day = 1

    func solvePart1(input: String) -> String {
        var counter = 0
        var pos: Int = 50

        let rotations = input.lines(includeEmpty: false)
            .map {
                return [
                    String($0.prefix(1)),
                    String($0.dropFirst())
                ]
            }

        for rotation in rotations {
            let steps = Int(rotation[1])!

            if rotation[0] == "R" {
                pos += steps
            } else {
                pos -= steps
            }

            pos = pos.mod(100)
            if pos == 0 {
                counter += 1
            }
        }

        return "\(counter)"
    }

    func solvePart2(input: String) -> String {
        var counter = 0
        var pos: Int = 50

        let rotations = input.lines(includeEmpty: false)
            .map {
                return [
                    String($0.prefix(1)),
                    String($0.dropFirst())
                ]
            }

        for rotation in rotations {
            let steps = Int(rotation[1])!
            
            if rotation[0] == "R" {
                let tmp = pos + steps
                counter += tmp / 100
                pos += steps
            } else {
                if pos <= steps && pos != 0 {
                    counter += 1
                }
                
                let tmp = abs(pos - steps)
                counter += tmp / 100
                pos -= steps
            }
            
            pos = pos.mod(100)
        }

        return "\(counter)"
    }
}
