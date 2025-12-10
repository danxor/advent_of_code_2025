import Foundation
import Collections

struct Machine: Hashable {
    var lights: [Bool]
    var buttons: [[Int]]
    var joltages: [Int]
    init(_ instruction: String) {
      let components = instruction.components(separatedBy: " ")
      self.lights = components[0].dropFirst().dropLast().map { $0 == "#" ? true : false }
      self.buttons = components.dropFirst().dropLast().map { $0.dropFirst().dropLast().components(separatedBy: ",").map { Int($0)! } }
      self.joltages = components.last!.dropFirst().dropLast().components(separatedBy: ",").map { Int($0)! }
    }
  }
  
  struct Day10: DaySolver {
    let day = 10

    func solvePart1(input: String) -> String {
        let machines = input.lines(includeEmpty: false).map { Machine($0) }

        var sum = 0

        for machine in machines {
            let value = minPresses(for: machine)

            sum += value
        }

        return "\(sum)"
    }

    func solvePart2(input: String) -> String {
        let machines = input.lines(includeEmpty: false).map {
            Machine($0)
        }

        var sum = 0

        for machine in machines {
            let value = minJoltagePresses(machine)

            sum += value
        }

        return "\(sum)"
    }

    func minPresses(for machine: Machine) -> Int {
        let numLights = machine.lights.count
        let numButtons = machine.buttons.count

        var matrix = [[Int]](repeating: [Int](repeating: 0, count: numButtons + 1), count: numLights)

        for (buttonIdx, toggles) in machine.buttons.enumerated() {
            for lightIdx in toggles {
                if lightIdx < numLights {
                    matrix[lightIdx][buttonIdx] = 1
                }
            }
        }

        for (lightIdx, isOn) in machine.lights.enumerated() {
            matrix[lightIdx][numButtons] = isOn ? 1 : 0
        }

        var pivotCol = 0
        var pivotRow = 0
        var pivotColumns = [Int]()

        while pivotRow < numLights && pivotCol < numButtons {
            var found = -1
            for row in pivotRow..<numLights {
                if matrix[row][pivotCol] == 1 {
                    found = row
                    break
                }
            }

            if found == -1 {
                pivotCol += 1
                continue
            }

            if found != pivotRow {
                matrix.swapAt(pivotRow, found)
            }

            pivotColumns.append(pivotCol)

            for row in 0..<numLights {
                if row != pivotRow && matrix[row][pivotCol] == 1 {
                    for col in 0...numButtons {
                        matrix[row][col] ^= matrix[pivotRow][col]
                    }
                }
            }

            pivotRow += 1
            pivotCol += 1
        }

        for row in pivotRow..<numLights {
            if matrix[row][numButtons] == 1 {
                return Int.max
            }
        }

        let pivotSet = Set(pivotColumns)
        var freeVars = [Int]()
        for col in 0..<numButtons {
            if !pivotSet.contains(col) {
                freeVars.append(col)
            }
        }

        let numFree = freeVars.count
        var minPresses = Int.max

        for mask in 0..<(1 << numFree) {
            var solution = [Int](repeating: 0, count: numButtons)

            for (i, freeCol) in freeVars.enumerated() {
                solution[freeCol] = (mask >> i) & 1
            }

            for (rowIdx, pivotColIdx) in pivotColumns.enumerated().reversed() {
                var val = matrix[rowIdx][numButtons]
                for col in (pivotColIdx + 1)..<numButtons {
                    val ^= (matrix[rowIdx][col] * solution[col])
                }
                solution[pivotColIdx] = val
            }

            let presses = solution.reduce(0, +)
            minPresses = min(minPresses, presses)
        }

        return minPresses
    }

    func minJoltagePresses(_ machine: Machine) -> Int {
        let numCounters = machine.joltages.count
        let numButtons = machine.buttons.count

        var matrix = [[Double]](repeating: [Double](repeating: 0, count: numButtons + 1), count: numCounters)

        for (buttonIdx, affects) in machine.buttons.enumerated() {
            for counterIdx in affects {
                if counterIdx < numCounters {
                    matrix[counterIdx][buttonIdx] = 1.0
                }
            }
        }

        for (i, target) in machine.joltages.enumerated() {
            matrix[i][numButtons] = Double(target)
        }

        var pivotRow = 0
        var pivotColumns = [Int]()

        for col in 0..<numButtons {
            var maxRow = pivotRow
            for row in (pivotRow + 1)..<numCounters {
                if abs(matrix[row][col]) > abs(matrix[maxRow][col]) {
                    maxRow = row
                }
            }

            if abs(matrix[maxRow][col]) < 1e-10 {
                continue
            }

            if maxRow != pivotRow {
                matrix.swapAt(pivotRow, maxRow)
            }

            pivotColumns.append(col)

            let scale = matrix[pivotRow][col]
            for c in col...numButtons {
                matrix[pivotRow][c] /= scale
            }

            for row in 0..<numCounters {
                if row != pivotRow && abs(matrix[row][col]) > 1e-10 {
                    let factor = matrix[row][col]
                    for c in col...numButtons {
                        matrix[row][c] -= factor * matrix[pivotRow][c]
                    }
                }
            }

            pivotRow += 1
            if pivotRow >= numCounters {
                break
            }
        }

        for row in pivotRow..<numCounters {
            if abs(matrix[row][numButtons]) > 1e-10 {
                return Int.max  // No solution
            }
        }

        let pivotSet = Set(pivotColumns)
        var freeVars = [Int]()
        for col in 0..<numButtons {
            if !pivotSet.contains(col) {
                freeVars.append(col)
            }
        }

        let numFree = freeVars.count

        func evaluateSolution(freeVals: [Int]) -> (valid: Bool, total: Int) {
            var total = freeVals.reduce(0, +)

            for (rowIdx, _) in pivotColumns.enumerated() {
                var val = matrix[rowIdx][numButtons]
                for (freeIdx, freeCol) in freeVars.enumerated() {
                    val -= matrix[rowIdx][freeCol] * Double(freeVals[freeIdx])
                }
                let intVal = Int(round(val))
                if intVal < 0 || abs(val - Double(intVal)) > 1e-6 {
                    return (false, Int.max)
                }
                total += intVal
            }
            return (true, total)
        }

        if numFree == 0 {
            let (valid, total) = evaluateSolution(freeVals: [])
            return valid ? total : Int.max
        }

        var buttonCaps = [Int](repeating: 0, count: numButtons)
        for (buttonIdx, affects) in machine.buttons.enumerated() {
            var cap = Int.max

            for c in affects {
                if c < machine.joltages.count {
                    cap = min(cap, machine.joltages[c])
                }
            }

            buttonCaps[buttonIdx] = cap == Int.max ? 0 : cap
        }

        let maxTarget = machine.joltages.max() ?? 0
        let globalCap = maxTarget > 0 ? maxTarget : 50

        var minPresses = Int.max

        if numFree <= 4 {
            func search(_ freeIdx: Int, _ freeVals: inout [Int], _ currentSum: Int) {
                if currentSum >= minPresses {
                    return  // Prune
                }

                if freeIdx == numFree {
                    let (valid, total) = evaluateSolution(freeVals: freeVals)
                    if valid {
                        minPresses = min(minPresses, total)
                    }
                    return
                }

                let buttonCap = buttonCaps[freeVars[freeIdx]]
                let localUpper = buttonCap > 0 ? buttonCap : globalCap

                for v in 0...localUpper {
                    if currentSum + v >= minPresses { break }
                    freeVals[freeIdx] = v
                    search(freeIdx + 1, &freeVals, currentSum + v)
                }
            }

            var freeVals = [Int](repeating: 0, count: numFree)
            search(0, &freeVals, 0)
        } else {
            let samples = min(1 << numFree, 512)
            for startMask in 0..<samples {
                var freeVals = [Int](repeating: 0, count: numFree)
                for i in 0..<numFree {
                    let cap = buttonCaps[freeVars[i]] > 0 ? buttonCaps[freeVars[i]] : globalCap
                    freeVals[i] = ((startMask >> i) & 1) * min(cap, maxTarget)
                }

                var improved = true
                while improved {
                    improved = false
                    for i in 0..<numFree {
                        let cap = buttonCaps[freeVars[i]] > 0 ? buttonCaps[freeVars[i]] : globalCap

                        if freeVals[i] < cap {
                            freeVals[i] += 1
                            let (valid1, total1) = evaluateSolution(freeVals: freeVals)
                            if valid1 && total1 < minPresses {
                                minPresses = total1
                                improved = true
                            }
                        }

                        if freeVals[i] > 0 {
                            freeVals[i] -= 1
                            let (valid2, total2) = evaluateSolution(freeVals: freeVals)
                            if valid2 && total2 < minPresses {
                                minPresses = total2
                                improved = true
                            }
                        }
                    }
                }

                let (valid, total) = evaluateSolution(freeVals: freeVals)
                if valid {
                    minPresses = min(minPresses, total)
                }
            }
        }

        return minPresses
    }
}
