import Foundation

var first_list: [Int] = []
var second_list: [Int] = []

var total_diff: Int = 0

let input: String? = try? String(contentsOf: URL(filePath: "1.txt"), encoding: String.Encoding.utf8)

let rows: [String.SubSequence]? = input?.split(separator: "\n")

for row in rows! {
    let ab = row.split(separator: " ")
    let a = Int(ab[0])
    let b = Int(ab[1])

    first_list.append(a!)
    second_list.append(b!)

}
first_list.sort()
second_list.sort()

for (a, b) in zip(first_list, second_list) {
    total_diff = total_diff + abs(a - b)
}

print(total_diff)


