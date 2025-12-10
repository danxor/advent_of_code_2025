struct DayRegistry {
    static func all() -> [DaySolver] {
        return [
            Day01(),
            Day02(),
            Day03(),
            Day04(),
            Day05(),
            Day06(),
            Day07(),
            Day08(),
            Day09(),
            Day10(),
        ]
    }

    static func getDay(_ day: Int) -> DaySolver? {
        return DayRegistry.all().first { $0.day == day }
    }
}