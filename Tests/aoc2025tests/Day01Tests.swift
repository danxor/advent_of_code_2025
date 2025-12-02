import XCTest

@testable import aoc2025

final class Day01Tests: XCTestCase {
    let day: Int = 1

    func testPart1Example() throws {
        let testCases: [(input: String, expected: String)] = [
            ("L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82", "3"),
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
            ("L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82", "6"),
        ]

        for (input, expected) in testCases {
            let solver = DayRegistry.getDay(day)!

            let result = solver.solvePart2(input: input)

            XCTAssertEqual(result, expected, "Failed test case: \(input)")

            print("\(input) => \(result) expected \(expected)")
        }
    }
}