struct Day07: DaySolver {
    let day = 7

    func solvePart1(input: String) -> String {
        let m = Map.init(input)

        guard let start = m.locate("S") else {
            print("No starting point found")
            return ""
        }

        var visited = Set<Position>()

        var beams = Set<Position>()
        beams.insert(start)

        var splits = 0

        while beams.count > 0 {
            var new_beams = Set<Position>()

            for beam in beams {
                visited.insert(beam)

                if m[beam.x, beam.y] == "^" {
                    splits += 1
                    
                    if beam.x - 1 >= 0 {
                        let new_pos = Position(x: beam.x - 1, y: beam.y)
                        new_beams.insert(new_pos)
                    }

                    if beam.x + 1 < m.width {
                        let new_pos = Position(x: beam.x + 1, y: beam.y)
                        new_beams.insert(new_pos)
                    }
                } else if beam.y < m.height {
                    let new_pos = Position(x: beam.x, y: beam.y + 1)
                    if !visited.contains(new_pos) {
                        new_beams.insert(new_pos)
                    }
                }
            }

            beams = new_beams
        }

        return "\(splits)"
    }

    func solvePart2(input: String) -> String {
        let m = Map.init(input)

        guard let start = m.locate("S") else {
            print("No starting point found")
            return ""
        }

        var beams = Array(repeating: 0, count: m.width)
        beams[start.x] = 1

        for y in 1..<m.height {
            var new_beams = beams

            for x in 0..<m.width {
                if m[x, y] == "^" {
                    new_beams[x] = 0
                    new_beams[x - 1] += beams[x]
                    new_beams[x + 1] += beams[x]
                }
            }

            beams = new_beams
        }

        return "\(beams.reduce(0, +))"
    }
}
