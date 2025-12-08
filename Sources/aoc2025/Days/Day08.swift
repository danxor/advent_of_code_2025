import Foundation

struct Day08: DaySolver {
    let day = 8

    struct Circuit {
        var boxes = [Point3D]()
        
        static func distance(from one: Self, to other: Self) -> Double {
            var minDistance: Double = .infinity
            
            for box1 in one.boxes {
                for box2 in other.boxes {
                    let distance = box1.distance(box2)
                    if distance < minDistance {
                        minDistance = distance
                    }
                }
            }
            
            return minDistance
        }
        
        mutating func merge(with other: Self) {
            boxes.append(contentsOf: other.boxes)
        }
        
        var size: Int {
            boxes.count
        }
    }
    
    struct Edge {
        let a: Int
        let b: Int
        let distance: Double
    }

    func solvePart1(input: String) -> String {
        let lines = input.lines(includeEmpty: false)

        let limit = lines.count < 1000 ? 10 : 1000
        
        var circuits: [Circuit] = []
        
        for line in lines {
            let coordinates: [Int] = line.split(separator: ",").map { Int($0)! }
            circuits.append(Circuit(boxes: [Point3D(x: coordinates[0], y: coordinates[1], z: coordinates[2])]))
        }

        let originalBoxes = circuits.map { $0.boxes[0] }
        
        var edges: [Edge] = []
        
        for i in 0..<circuits.count {
            for j in (i + 1)..<circuits.count {
                let distance = Circuit.distance(from: circuits[i], to: circuits[j])
                edges.append(Edge(a: i, b: j, distance: distance))
            }
        }
        edges.sort { $0.distance < $1.distance }
        
        for edge in edges.prefix(limit) {
            let boxA = originalBoxes[edge.a]
            let boxB = originalBoxes[edge.b]
            
            guard
                let circuitAIndex = circuits.firstIndex(where: { $0.boxes.contains(boxA) }),
                let circuitBIndex = circuits.firstIndex(where: { $0.boxes.contains(boxB) }),
                circuitAIndex != circuitBIndex
            else {
                continue
            }
            
            circuits[circuitAIndex].merge(with: circuits[circuitBIndex])
            circuits.remove(at: circuitBIndex)
        }
        
        var result: Int = 1
        
        let sizes = circuits.map((\.size)).sorted { $0 > $1 }
        for size in sizes.prefix(3) {
            result *= size
        }

        return "\(result)"
    }

    func solvePart2(input: String) -> String {
        let lines = input.lines(includeEmpty: false)

        var circuits: [Circuit] = []
        
        for line in lines {
            let coordinates: [Int] = line.split(separator: ",").map { Int($0)! }
            circuits.append(Circuit(boxes: [Point3D(x: coordinates[0], y: coordinates[1], z: coordinates[2])]))
        }

        let originalBoxes = circuits.map { $0.boxes[0] }
        
        var edges: [Edge] = []
        
        for i in 0..<circuits.count {
            for j in (i + 1)..<circuits.count {
                let distance = Circuit.distance(from: circuits[i], to: circuits[j])
                edges.append(Edge(a: i, b: j, distance: distance))
            }
        }
        edges.sort { $0.distance < $1.distance }
        
        for edge in edges {
            let a = originalBoxes[edge.a]
            let b = originalBoxes[edge.b]
            
            guard
                let circuitA = circuits.firstIndex(where: { $0.boxes.contains(a) }),
                let circuitB = circuits.firstIndex(where: { $0.boxes.contains(b) }),
                circuitA != circuitB
            else {
                continue
            }
            
            if circuits.count == 2 {
                return "\(a.x * b.x)"
            }
            
            circuits[circuitA].merge(with: circuits[circuitB])
            circuits.remove(at: circuitB)
        }

        return ""
    }
}
