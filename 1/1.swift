import Foundation

var first_list: [Int] = []
var second_list: [Int] = []

// Parse the numbers into two lists
let input = try? String(contentsOf: URL(filePath: "1.txt"), encoding: String.Encoding.utf8)

let rows = input?.split(separator: "\n")

for row in rows! {
    let ab = row.split(separator: " ")
    let a = Int(ab[0])
    let b = Int(ab[1])

    first_list.append(a!)
    second_list.append(b!)

}

// Part 1
var total_diff_1 = 0
// Find the difference between the two lists
first_list.sort()
second_list.sort()

for (a, b) in zip(first_list, second_list) {
    total_diff_1 = total_diff_1 + abs(a - b)
}

print("Part 1 \(total_diff_1)")

// Part 2
var total_diff_2 = 0
// Count occurence of each item in right list
var counts: [Int:Int] = [:]
for item in second_list {
    counts[item] = (counts[item] ?? 0) + 1
}

for a in first_list {
    
    total_diff_2 = total_diff_2 + a*(counts[a] ?? 0)
}

print("Part 2 \(total_diff_1)")




