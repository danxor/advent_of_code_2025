import XCTest

@testable import aoc2025

final class UtilsTests: XCTestCase {
    func testPositiveMod() throws {
        let testCases: [(input: Int, expected: Int)] = [
            (15, 15),
            (125, 25),
            (925, 25),
        ]

        for (input, expected) in testCases {
            let result = input.mod(100)
            XCTAssertEqual(result, expected, "Failed test case: \(input)")
        }
    }

   func testNegativeMod() throws {
        let testCases: [(input: Int, expected: Int)] = [
            (-15, 85),
            (-125, 75),
            (-925, 75),
        ]

        for (input, expected) in testCases {
            let result = input.mod(100)
            XCTAssertEqual(result, expected, "Failed test case: \(input)")
        }
    }
}