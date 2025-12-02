struct DayRegistry {
    static func all() -> [DaySolver] {
        return [
            Day01(),
            Day02(),
            Day03(),
        ]
    }

    static func getDay(_ day: Int) -> DaySolver? {
        return DayRegistry.all().first { $0.day == day }
    }
}