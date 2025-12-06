import XCTest

@testable import aoc2025

final class Day06Tests: XCTestCase {
    let day: Int = 6

    func testPart1Example() throws {
        let testCases: [(input: String, expected: String)] = [
            ("123 328  51 64 \n 45 64  387 23 \n  6 98  215 314\n*   +   *   +  \n", "4277556"),
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
            ("123 328  51 64 \n 45 64  387 23 \n  6 98  215 314\n*   +   *   +  \n", "3263827"),
        ]

        for (input, expected) in testCases {
            let solver = DayRegistry.getDay(day)!

            let result = solver.solvePart2(input: input)

            XCTAssertEqual(result, expected, "Failed test case: \(input)")

            print("\(input) => \(result) expected \(expected)")
        }
    }
}