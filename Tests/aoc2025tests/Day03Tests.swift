import XCTest

@testable import aoc2025

final class Day03Tests: XCTestCase {
    let day: Int = 3

    func testPart1Example() throws {
        let testCases: [(input: String, expected: String)] = [
            ("987654321111111\n", "98"),
            ("811111111111119\n", "89"),
            ("234234234234278\n", "78"),
            ("818181911112111\n", "92"),
            ("987654321111111\n811111111111119\n234234234234278\n818181911112111\n", "357"),
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
            ("987654321111111\n", "987654321111"),
            ("811111111111119\n", "811111111119"),
            ("234234234234278\n", "434234234278"),
            ("818181911112111\n", "888911112111"),
            ("987654321111111\n811111111111119\n234234234234278\n818181911112111\n", "3121910778619"),
        ]

        for (input, expected) in testCases {
            let solver = DayRegistry.getDay(day)!

            let result = solver.solvePart2(input: input)

            XCTAssertEqual(result, expected, "Failed test case: \(input)")

            print("\(input) => \(result) expected \(expected)")
        }
    }
}