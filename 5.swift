import Foundation

let input = (try? String(contentsOf: URL(filePath: "5.txt"), encoding: String.Encoding.utf8)) ?? ""

let split_input = input.split(separator: "\n\n")

let rules = split_input[0].split(separator: "\n")
let sequences = split_input[1].split(separator: "\n")


// Define custom sort operator
extension Int {
    func compare(to other: Int) -> ComparisonResult {
        if rules.contains("\(self)|\(other)") {
            return .orderedAscending
        } else if rules.contains("\(other)|\(self)"){
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
}

// Check if sentence is ordered
func check_sequence(_ numbers: [Int]) -> Bool {

    let sorted_numbers = numbers.sorted {lhs, rhs in
        lhs.compare(to: rhs) == .orderedAscending
    }
    return sorted_numbers == numbers
}


// Sort a sequence
func sort_sequence(_ numbers: [Int]) -> [Int] {

    return numbers.sorted {lhs, rhs in
        lhs.compare(to: rhs) == .orderedAscending
    }
}

func get_middle_element(_ numbers: [Int]) -> Int {
    return numbers[(numbers.count-1)/2]
}

var correct_sequences: [[Int]] = []
var incorrect_sequences: [[Int]] = []

for seq in sequences {
    let numbers = seq.split(separator: ",").map { Substring in
        Int(Substring)!
    }
    if check_sequence(numbers) {
        correct_sequences.append(numbers)
    } else {
        incorrect_sequences.append(numbers)
    }
}


var total_1 = 0
for correct_sequence in correct_sequences {
    total_1 = total_1 + get_middle_element(correct_sequence)
}


print("Part 1 \(total_1)")

var total_2 = 0
for incorrect_sequence in incorrect_sequences {
    let sorted_sequence = sort_sequence(incorrect_sequence)
    total_2 = total_2 + get_middle_element(sorted_sequence)
}
print("Part 2 \(total_2)")



