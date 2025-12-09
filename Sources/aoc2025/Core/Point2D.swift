import Foundation

struct Point2D: Hashable, Equatable {
    var x: Int
    var y: Int

    func area(_ to: Point2D) -> Int {
        let dx = 1 + abs(self.x - to.x)
        let dy = 1 + abs(self.y - to.y)
        return dx * dy
    }
}
