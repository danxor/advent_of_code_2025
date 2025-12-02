protocol DaySolver {
    var day: Int { get }
    func solvePart1(input: String) -> String
    func solvePart2(input: String) -> String
}

extension DaySolver {
    var inputFilename: String {
        return "Inputs/2025/day\(String(format: "%02d", day)).txt"
    }
}
