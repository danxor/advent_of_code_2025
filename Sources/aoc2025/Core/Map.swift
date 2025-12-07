struct Position: Hashable {
    let x: Int
    let y: Int
}

class Map {
    private(set) var width: Int
    private(set) var height: Int
    private(set) var grid: [[Character]]

    init(_ from: String) {
        self.grid = from.split(separator: "\n")
            .map {
                $0.trimmingCharacters(in: .whitespacesAndNewlines)
            }.map {
                Array($0)
            }
        
        self.width = self.grid[0].count
        self.height = self.grid.count
    }

    subscript(x: Int, y: Int) -> Character {
        get {
            if x >= 0 && x < self.width && y >= 0 && y < self.height {
                return self.grid[y][x]
            }

            return "."
        }
        set {
            if x >= 0 && x < self.width && y >= 0 && y < self.height {
                self.grid[y][x] = newValue
            }
        }
    }

    func locate(_ ch: Character) -> Position? {
        for y in 0..<self.height {
            for x in 0..<self.width {
                if self[x, y] == ch {
                    return Position(x: x, y: y)
                }
            }
        }

        return nil
    }

    func debug() {
        for row in self.grid {
            let line = String(row)
            print("\(line)")
        }
    }
}