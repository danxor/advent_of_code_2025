struct Shape {
    let grid: [(x: Int, y: Int)]
    let width: Int
    let height: Int
    let cellCount: Int

    init(cells: Set<Point2D>) {
        let normalized = Shape.normalize(cells)
        self.grid = normalized.map { ($0.x, $0.y) }

        self.width = (normalized.map { $0.x }.max() ?? 0) + 1
        self.height = (normalized.map { $0.y }.max() ?? 0) + 1
        self.cellCount = normalized.count
    }

    private static func normalize(_ points: Set<Point2D>) -> Set<Point2D> {
        let minX = points.map { $0.x }.min()!
        let minY = points.map { $0.y }.min()!
        return Set(points.map { Point2D(x: $0.x - minX, y: $0.y - minY) })
    }

    func rotations() -> [Shape] {
        var rotations: [Set<Point2D>] = []

        var current = Set(grid.map { Point2D(x: $0.x, y: $0.y) })

        for _ in 0..<4 {
            let normalized = Shape.normalize(current)
            if !rotations.contains(normalized) {
                rotations.append(normalized)
            }

            let normalize_flipped = Shape.normalize(flip(Set(grid.map { Point2D(x: $0.x, y: $0.y) })))
            if !rotations.contains(normalize_flipped) {
                rotations.append(normalize_flipped)
            }

            current = rotate(current)
        }

        return rotations.map { Shape(cells: $0) }
    }

    private func rotate(_ points: Set<Point2D>) -> Set<Point2D> {
        Set(points.map { Point2D(x: $0.y, y: -$0.x) })
    }

    private func flip(_ points: Set<Point2D>) -> Set<Point2D> {
        Set(points.map { Point2D(x: -$0.x, y: $0.y) })
    }
}

struct Region {
    let width: Int
    let height: Int
    let presentCounts: [Int]
}

struct Day12: DaySolver {
    let day = 12

    private func parseRegionLine(_ line: String) -> Region? {
        let parts = line.components(separatedBy: ":")

        let dimensions = parts[0].trimmingCharacters(in: .whitespaces).components(separatedBy: "x")
        let width = Int(dimensions[0])!
        let height = Int(dimensions[1])!

        let counts = parts[1].trimmingCharacters(in: .whitespaces).components(separatedBy: " ").compactMap { Int($0) }

        return Region(width: width, height: height, presentCounts: counts)
    }

     private func solveRegion(in region: Region, shapeVariants: [[Shape]]) -> Bool {
        var presents: [(shapeIndex: Int, cellCount: Int)] = []
        var total = 0

        for (shapeIndex, count) in region.presentCounts.enumerated() {
            if shapeIndex < shapeVariants.count {
                let cellCount = shapeVariants[shapeIndex][0].cellCount
                for _ in 0..<count {
                    presents.append((shapeIndex, cellCount))
                    total += cellCount
                }
            }
        }

        let area = region.width * region.height
        if total > area {
            return false
        }

        if presents.isEmpty {
            return true
        }

        presents.sort { $0.shapeIndex < $1.shapeIndex }

        var grid = [Bool](repeating: false, count: region.width * region.height)

        return placePresents(
            grid: &grid,
            width: region.width,
            height: region.height,
            presentsToPlace: presents,
            currentPresentIndex: 0,
            shapeVariants: shapeVariants,
            remainingCells: total,
            minPlacementX: 0,
            minPlacementY: 0
        )
    }

    private func placePresents(
        grid: inout [Bool],
        width: Int,
        height: Int,
        presentsToPlace: [(shapeIndex: Int, cellCount: Int)],
        currentPresentIndex: Int,
        shapeVariants: [[Shape]],
        remainingCells: Int,
        minPlacementX: Int,
        minPlacementY: Int
    ) -> Bool {
        if currentPresentIndex == presentsToPlace.count {
            return true
        }

        let currentShapeIndex = presentsToPlace[currentPresentIndex].shapeIndex
        let variants = shapeVariants[currentShapeIndex]

        let startY = minPlacementY
        let startX = minPlacementX

        for variant in variants {
            for y in startY..<height {
                let xStart = (y == startY) ? startX : 0

                for x in xStart..<width {
                    if canPlace(variant, x: x, y: y, in: grid, width: width, height: height) {
                        placeShape(variant, x: x, y: y, in: &grid, width: width, occupied: true)

                        let nextMinX: Int
                        let nextMinY: Int

                        if currentPresentIndex + 1 < presentsToPlace.count &&
                           presentsToPlace[currentPresentIndex + 1].shapeIndex == currentShapeIndex {
                            nextMinX = x
                            nextMinY = y
                        } else {
                            nextMinX = 0
                            nextMinY = 0
                        }

                        if placePresents(
                            grid: &grid,
                            width: width,
                            height: height,
                            presentsToPlace: presentsToPlace,
                            currentPresentIndex: currentPresentIndex + 1,
                            shapeVariants: shapeVariants,
                            remainingCells: remainingCells - variant.cellCount,
                            minPlacementX: nextMinX,
                            minPlacementY: nextMinY
                        ) {
                            return true
                        }

                        placeShape(variant, x: x, y: y, in: &grid, width: width, occupied: false)
                    }
                }
            }
        }

        return false
    }

    private func canPlace(_ shape: Shape, x: Int, y: Int, in grid: [Bool], width: Int, height: Int) -> Bool {
        for cell in shape.grid {
            let xx = x + cell.x
            let yy = y + cell.y

            if xx >= width || yy >= height || grid[yy * width + xx] {
                return false
            }
        }
 
        return true
    }

    private func placeShape(_ shape: Shape, x: Int, y: Int, in grid: inout [Bool], width: Int, occupied: Bool) {
        for cell in shape.grid {
            let flatIndex = (y + cell.y) * width + (x + cell.x)
            grid[flatIndex] = occupied
        }
    }

   func solvePart1(input: String) -> String {
        var shapes: [Shape] = []

        let parts = input.components(separatedBy: "\n\n")

        for part in parts.dropLast() {
            var occupiedCells: Set<Point2D> = []

            let lines = part.components(separatedBy: "\n")
            for (y, line) in lines.dropFirst().enumerated() {
                for (x, char) in line.enumerated() {
                    if char == "#" {
                        occupiedCells.insert(Point2D(x: x, y: y))
                    }
                }
            }

            shapes.append(Shape(cells: occupiedCells))
        }

        var regions: [Region] = []

        let lines = parts[parts.count - 1].components(separatedBy: "\n")
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty { continue }
            if let region = parseRegionLine(trimmed) {
                regions.append(region)
            }
        }

        let allShapeVariants = shapes.map { $0.rotations() }

        var sum = 0

        for region in regions {
            if solveRegion(in: region, shapeVariants: allShapeVariants) {
                sum += 1
            }
        }

        return "\(sum)"
    }

    func solvePart2(input: String) -> String {
        return ""
    }
}
