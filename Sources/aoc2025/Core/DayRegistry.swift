struct DayRegistry {
    static func all() -> [DaySolver] {
        return [
            Day01(),
            Day02(),
            Day03(),
            Day04(),
        ]
    }

    static func getDay(_ day: Int) -> DaySolver? {
        return DayRegistry.all().first { $0.day == day }
    }
}