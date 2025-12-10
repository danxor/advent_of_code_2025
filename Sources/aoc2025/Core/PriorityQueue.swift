import Collections

struct PriorityQueueItem<T: Comparable>: Comparable {
    let score: Int
    let turn: Int
    let item: T

    static func <(lhs: PriorityQueueItem<T>, rhs: PriorityQueueItem<T>) -> Bool {
        if lhs.score < rhs.score {
            return true
        }

        return lhs.turn < rhs.turn
    }
}

struct PriorityQueue<T: Comparable> {
    private var heap: Heap<PriorityQueueItem<T>>

    init() {
        self.heap = Heap<PriorityQueueItem<T>>()
    }

    mutating func push(score: Int, turn: Int, item: T) {
        self.heap.insert(PriorityQueueItem<T>(score: score, turn: turn, item: item))
    }

    mutating func pop() -> PriorityQueueItem<T>? {
        guard !self.heap.isEmpty else {
            return nil
        }

        return self.heap.popMin()
    }

    var isEmpty: Bool {
        return self.heap.isEmpty
    }
}