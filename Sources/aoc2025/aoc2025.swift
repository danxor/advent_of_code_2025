// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

struct CLIOptions {
    var day: Int? = nil
}

func parseArguments() -> CLIOptions {
    var options = CLIOptions()
    var iterator = CommandLine.arguments.dropFirst().makeIterator()

    while let arg = iterator.next() {
        switch arg {
        case "--day", "-d":
            if let value = iterator.next(), let intVal = Int(value) {
                options.day = intVal
            } else {
                print("Error: --day requires an integer")
            }

        case "--help", "-h":
            print("Usage: AdventOfCode --day <n>")

        default:
            print("Unknown argument: \(arg)")
        }
    }

    return options
}

func getSolver(solvers: [DaySolver], day: Int) -> DaySolver? {
    for solver in solvers {
        if solver.day == day {
            return solver
        }
    }

    return nil
}

func construct_date(year: Int, month: Int, day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = 6
    components.minute = 0
    components.second = 0

    let calendar = Calendar.current

    return calendar.date(from: components)!
}

@main
struct aoc2025 {
    static func main() async {
        let opts = parseArguments()

        do {
            let config = try Config.create(filename: "aoc.env")

            let now = Date()

            let days = 1...25

            let available = days
                .map {
                    construct_date(year: config.year, month: 12, day: $0)
                }
                .filter {
                    $0 <= now
                }

            let all = DayRegistry.all()

            for date in available {
                let day = Calendar.current.component(.day, from: date)

                if opts.day != nil, opts.day != day {
                    continue
                }

                guard let solver = getSolver(solvers: all, day: day) else {
                    print("No solver found for day #\(day)")
                    continue
                }

                do {
                    let input = try await InputDownloader.ensureInputFile(config: config, day: solver.day)

                    let part1: String = solver.solvePart1(input: input)
                    let part2: String = solver.solvePart2(input: input)

                    print("Day \(solver.day): Part 1: \(part1), Part 2: \(part2)")
                } catch {
                    print("Error for day \(solver.day):", error)
                }
            }
        } catch {
            print("aoc.env:", error)
        }
    }
}
