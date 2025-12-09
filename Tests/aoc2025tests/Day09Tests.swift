import XCTest

@testable import aoc2025

final class Day09Tests: XCTestCase {
    let day: Int = 9

    func testPart1Example() throws {
        let testCases: [(input: String, expected: String)] = [
            ("7,1\n11,1\n11,7\n9,7\n9,5\n2,5\n2,3\n7,3\n", "50"),
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
            ("7,1\n11,1\n11,7\n9,7\n9,5\n2,5\n2,3\n7,3\n", "24"),
        ]

        for (input, expected) in testCases {
            let solver = DayRegistry.getDay(day)!

            let result = solver.solvePart2(input: input)

            XCTAssertEqual(result, expected, "Failed test case: \(input)")

            print("\(input) => \(result) expected \(expected)")
        }
    }
}