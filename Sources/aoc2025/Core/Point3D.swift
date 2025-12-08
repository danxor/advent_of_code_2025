import Foundation

struct Point3D: Hashable, Equatable {
    var x: Int
    var y: Int
    var z: Int

    func distance(_ to: Point3D) -> Double {
        let dx = self.x - to.x
        let dy = self.y - to.y
        let dz = self.z - to.z

        return sqrt( Double((dx * dx) + (dy * dy) + (dz * dz)) )
    }
}
