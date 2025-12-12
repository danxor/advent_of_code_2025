import XCTest

@testable import aoc2025

final class Day12Tests: XCTestCase {
    let day: Int = 12

    func testPart1Example() throws {
        let testCases: [(input: String, expected: String)] = [
            ("0:\n###\n##.\n##.\n\n1:\n###\n##.\n.##\n\n2:\n.##\n###\n##.\n\n3:\n##.\n###\n##.\n\n4:\n###\n#..\n###\n\n5:\n###\n.#.\n###\n\n4x4: 0 0 0 0 2 0\n12x5: 1 0 1 0 2 2\n12x5: 1 0 1 0 3 2\n", "2"),
        ]

        for (input, expected) in testCases {
            let solver = DayRegistry.getDay(day)!

            let result = solver.solvePart1(input: input)

            XCTAssertEqual(result, expected, "Failed test case: \(input)")

            print("\(input) => \(result) expected \(expected)")
        }
    }

    func testPart2Example() throws {
        let testCases: [(input: String, expected: String)] = [
            ("", ""),
        ]

        for (input, expected) in testCases {
            let solver = DayRegistry.getDay(day)!

            let result = solver.solvePart2(input: input)

            XCTAssertEqual(result, expected, "Failed test case: \(input)")

            print("\(input) => \(result) expected \(expected)")
        }
    }
}