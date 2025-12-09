struct Day09: DaySolver {
    let day = 9

    func solvePart1(input: String) -> String {
        let lines = input.lines(includeEmpty: false)

        var points = [Point2D]()
        for line in lines {
            let coordinates = line.split(separator: ",").map { Int($0)! }
            points.append(Point2D(x: coordinates[0], y: coordinates[1]))
        }

        var max = Int.min

        for i in 0..<points.count {
            for j in i + 1..<points.count {
                let area = points[i].area(points[j])
                if max < area {
                    max = area
                }
            }
        }
        return "\(max)"
    }

    func solvePart2(input: String) -> String {
        let lines = input.lines(includeEmpty: false)

        var points = [Point2D]()
        for line in lines {
            let coordinates = line.split(separator: ",").map { Int($0)! }
            points.append(Point2D(x: coordinates[0], y: coordinates[1]))
        }

        let boundaries = getBoundingBox(points)

        var max = Int.min
        for i in 0..<points.count {
            for j in i + 1..<points.count {
                let u = points[i]
                let v = points[j]

                if inside(u, v, box: boundaries) {
                    let area = u.area(v)
                    if max < area {
                        max = area
                    }
                }
            }
        }

        return "\(max)"
    }

    func inside(_ u: Point2D, _ v: Point2D, box: [Int: (Int, Int)]) -> Bool {
        let xmin = min(u.x, v.x)
        let xmax = max(u.x, v.x)
        let ymin = min(u.y, v.y)
        let ymax = max(u.y, v.y)

        for y in ymin...ymax {
            if box[y] == nil {
                return false
            }

            let b = box[y]!
            if xmin < b.0 || xmax > b.1 {
                return false
            }
        }

        return true
    }

    func getBoundingBox(_ points: [Point2D]) -> [Int: (Int, Int)] {
        var box = [Int: (Int, Int)]()

        for i in 0..<points.count {
            let u = points[i]
            let v = points[(i + 1) % points.count]

            if u.x == v.x {
                let ymin = min(u.y, v.y)
                let ymax = max(u.y, v.y)

                for y in ymin...ymax {
                    if box[y] == nil {
                        box[y] = (u.x, u.x)
                    } else {
                        let b = box[y]!

                        box[y] = ( min(b.0, u.x), max(b.1, u.x) )
                    }
                }
            } else if u.y == v.y {
                if box[u.y] == nil {
                    box[u.y] = ( min(u.x, v.x), max(u.x, v.x) )
                } else {
                    let b = box[u.y]!
                    box[u.y] = ( min(b.0, u.x, v.x), max(b.1, u.x, v.x) )
                }
            }
        }

        return box
    }
}
