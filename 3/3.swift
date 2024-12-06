import Foundation

var input = (try? String(contentsOf: URL(filePath: "3.txt"), encoding: String.Encoding.utf8)) ?? ""
input = input.replacingOccurrences(of: "\n", with: "")

let regex = try Regex(#"mul\(([0-9]{1,3}),([0-9]{1,3})\)"#)

// Calcule the multiplications in a string
func calculate(input: String) -> Int {
    var total = 0

    for match in input.matches(of: regex) {

        let first = Int(String(match.output[1].substring!))!
        let second = Int(String(match.output[2].substring!))!
        total = total + first*second

    }
    return total
}

let total_1 = calculate(input: input)
print("Part 1 \(total_1)")




let dont_regex = try Regex(#"(don't\(\)).*?(do\(\))"#)

var to_remove = 0

// Find all section between don't() and do()
for match in input.matches(of: dont_regex) {
    
    //R emove the value from that section from the total
    to_remove = to_remove + calculate(input: String(match.output[0].substring!))
}

print("Part 2 \(total_1 - to_remove)")




