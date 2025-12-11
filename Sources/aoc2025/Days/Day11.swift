struct Wire {
    let name: String
    let connections: [String]

    init(_ line: String) {
        let parts = line.split(separator: " ")
        self.name = String(parts[0].filter { $0 != ":" })
        self.connections = parts.dropFirst().map { String.init($0) }
    }
}

struct Day11: DaySolver {
    let day = 11

    private func countPaths(wires: [String: Wire], from sourceDevice: String, to destinationDevice: String) -> Int {
        var cache: [String: Int] = [:]

        var stack = Set<String>()

        func countFrom(_ current: String) -> Int {
            if current == destinationDevice {
                return 1
            }

            if let cachePath = cache[current] {
                return cachePath
            }

            if stack.contains(current) {
                return 0
            }

            guard let outputDevices = wires[current] else {
                cache[current] = 0
                return 0
            }

            stack.insert(current)

            var totalPaths = 0
            for outputDevice in outputDevices.connections {
                totalPaths += countFrom(outputDevice)
            }

            stack.remove(current)

            cache[current] = totalPaths
            return totalPaths
        }

        return countFrom(sourceDevice)
    }

    func solvePart1(input: String) -> String {
        let lines = input
            .lines(includeEmpty: false)
            .map {
                Wire($0)
            }

        var wires = [String: Wire]()
        for wire in lines {
            wires[wire.name] = wire
        }

        guard let start = wires["you"] else {
            return ""
        }

        let count = countPaths(wires: wires, from: start.name, to: "out")
        return "\(count)"
    }

    func solvePart2(input: String) -> String {
        let lines = input
            .lines(includeEmpty: false)
            .map {
                Wire($0)
            }

        var wires = [String: Wire]()
        for wire in lines {
            wires[wire.name] = wire
        }

        let svrToDac = countPaths(wires: wires, from: "svr", to: "dac")
        let dacToFft = countPaths(wires: wires, from: "dac", to: "fft")
        let fftToOut = countPaths(wires: wires, from: "fft", to: "out")
        let pathOne = svrToDac * dacToFft * fftToOut

        let svrToFft = countPaths(wires: wires, from: "svr", to: "fft")
        let fftToDac = countPaths(wires: wires, from: "fft", to: "dac")
        let dacToOut = countPaths(wires: wires, from: "dac", to: "out")
        let pathTwo = svrToFft * fftToDac * dacToOut

        let count = pathOne + pathTwo

        return "\(count)"
    }
}
