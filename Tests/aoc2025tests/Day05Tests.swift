import XCTest

@testable import aoc2025

final class Day05Tests: XCTestCase {
    let day: Int = 5

    func testPart1Example() throws {
        let testCases: [(input: String, expected: String)] = [
            ("3-5\n10-14\n16-20\n12-18\n\n1\n5\n8\n11\n17\n32\n", "3"),
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
            ("3-5\n10-14\n16-20\n12-18\n", "14"),
        ]

        for (input, expected) in testCases {
            let solver = DayRegistry.getDay(day)!

            let result = solver.solvePart2(input: input)

            XCTAssertEqual(result, expected, "Failed test case: \(input)")

            print("\(input) => \(result) expected \(expected)")
        }
    }
}