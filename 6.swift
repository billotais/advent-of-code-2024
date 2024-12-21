import Foundation

let input = (try? String(contentsOf: URL(filePath: "6.txt"), encoding: String.Encoding.utf8)) ?? ""

var data: [[String]] = input.split(separator: "\n").map {row in 
    row.split(separator: "").map {x in String(x)}
}


enum Direction {
    case up, right, down, left
}
enum Turn {
    case right, left
}

enum MoveMode {
    case forward, backward
}

class Map {

    var array: [[String]]
    var guard_post: GuardPost


    var visited: Set<String> = []
    var visited_direction: Set<String> = []
    var possible_obstructions: Set<[Int]> = []

    var loop = false

    // Standard init based on data
    init(data: [[String]]) {
        array = data
        guard_post = GuardPost()
 
        for (i, row) in array.enumerated() {
            for (j, pos) in row.enumerated() {
                if pos == "^" {
                    guard_post.y = i
                    guard_post.x = j

                    visited.insert(guard_post.pos())
                    visited_direction.insert(guard_post.pos_dir())
                }
            }
        }
    }
    // Init with custom guard position
    init(data: [[String]], guard_post: GuardPost) {
        self.array = data
        self.guard_post = guard_post
    }

    // Check the content of the position where the guard is looking at
    func get_space_ahead() -> String {
        let (next_x, next_y) = guard_post.get_next_postition()

        if next_x < 0 || next_x >= array[0].count ||  next_y < 0 || next_y >= array.count  {return "o"}      
        
        return array[next_y][next_x]
 
    }

    func play(break_on_loop: Bool = false)  {
        var playing = true
        repeat {


            
            let next_pos = get_space_ahead()
            
            switch next_pos {
            
                case "o": // Out of bounds
                    playing = false
                case "#": // Obstacle
                    guard_post.rotate()
                default: // Free

                    // Move
                    guard_post.walk()

                   
                    possible_obstructions.insert([guard_post.x, guard_post.y])
                    
                    if break_on_loop && visited_direction.contains(guard_post.pos_dir()){
                        loop = true
                        playing = false

                    }
                    visited.insert(guard_post.pos())
                    visited_direction.insert(guard_post.pos_dir())
            }
           
        } while playing

    }

}

class GuardPost {
    var x: Int = 0
    var y: Int = 0

    var dir: Direction = .up
    var turn: Turn = .right
    var mode: MoveMode = .forward

    // Position in front of guard
    func get_next_postition() -> (Int, Int) {
        return switch dir {
        case .up: (x, y - 1)
        case .right: (x + 1, y)
        case .down: (x, y + 1)
        case .left: (x - 1, y)
        }
    }
    // Position left of guard
    func get_right_postition() -> (Int, Int) {
        return switch dir {
            case .up: (x + 1, y)
            case .right: (x, y + 1)
            case .down: (x - 1, y)
            case .left: (x, y - 1)
        }
    }

    func walk() {
        (self.x, self.y) = self.get_next_postition()
    }

    func rotate() {

        switch (turn, dir) {
            case (.right, .up): dir = .right
            case (.right, .right): dir = .down
            case (.right, .down): dir = .left
            case (.right, .left): dir = .up
            case (.left, .up): dir = .left
            case (.left, .right): dir = .up
            case (.left, .down): dir = .right
            case (.left, .left): dir = .down
        }
    }
    func flip() {
        switch dir {
            case .up: dir = .down
            case .right: dir = .left
            case .down: dir = .up
            case .left: dir = .right
        }

        switch turn {
            case .right: turn = .left
            case .left: turn = .right
        }
        switch mode {
            case .forward: mode = .backward
            case .backward: mode = .forward
        }
    }
    func pos() -> String {
        return "(x:\(x), y:\(y))"
    }
    func pos_dir() -> String {
        return "(x:\(x), y:\(y), dir:\(dir))"
    }


}

// Part 1
var map = Map(data: data)
map.play()

print("Part 1 \(map.visited.count)")


// Part 2


var looping_obstructions: Set<[Int]> = []
for possible_obstruction in map.possible_obstructions {
    var data_copy = data
    data_copy[possible_obstruction[1]][possible_obstruction[0]] = "#"

    var map_simulation = Map(data: data_copy)
    map_simulation.play(break_on_loop: true)

    if map_simulation.loop {
        looping_obstructions.insert(possible_obstruction)
    }
}
print("Part 2 \(looping_obstructions.count)")
