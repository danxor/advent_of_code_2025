import XCTest

@testable import aoc2025

final class Day02Tests: XCTestCase {
    let day: Int = 2

    func testPart1Example() throws {
        let testCases: [(input: String, expected: String)] = [
            ("11-22", "33"),
            ("11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124", "1227775554"),
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
            ("11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124", "4174379265"),
        ]

        for (input, expected) in testCases {
            let solver = DayRegistry.getDay(day)!

            let result = solver.solvePart2(input: input)

            XCTAssertEqual(result, expected, "Failed test case: \(input)")

            print("\(input) => \(result) expected \(expected)")
        }
    }
}