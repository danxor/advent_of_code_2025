struct Day04: DaySolver {
    let day = 4

    func count_adjacent(_ table: [[Character]], _ x: Int, _ y: Int) -> Int {
        let height = table.count
        let width = table[0].count

        let offsets = [ (-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (0, 1), (1, 1) ]

        var count = 0

        for offset in offsets {
            let xx = x + offset.0
            let yy = y + offset.1

            if xx >= 0 && xx < width && yy >= 0 && yy < height && table[yy][xx] == "@" {
                count += 1
            }
        }

        return count
    }

    func solvePart1(input: String) -> String {
        var table = [[Character]]()
        let lines = input.lines(includeEmpty: false)
        
        for line in lines {
            table.append(Array(line))
        }
        
        let height = table.count
        let width = table[0].count
        var result = 0

        for y in 0..<height {
            for x in 0..<width {
                if table[y][x] == "@" {
                    let adj = count_adjacent(table, x, y)
                    if adj < 4 {
                        result += 1
                    }
                }
            }
        }

        return "\(result)"
    }

    func solvePart2(input: String) -> String {
        var table = [[Character]]()
        let lines = input.lines(includeEmpty: false)
        
        for line in lines {
            table.append(Array(line))
        }
        
        let height = table.count
        let width = table[0].count

        var result = 0
        var round = 1

        while round > 0 {
            round = 0

            for y in 0..<height {
                for x in 0..<width {
                    if table[y][x] == "@" {
                        let adj = count_adjacent(table, x, y)
                        if adj < 4 {
                            table[y][x] = "."
                            round += 1
                            result += 1
                        }
                    }
                }
            }
        }

        return "\(result)"
    }
}
