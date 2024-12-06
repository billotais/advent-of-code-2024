import Foundation

// Check if a list is safe
func check_safe_1(list: [Int]) -> Bool {
    
    var is_increasing = false
    var is_decreasing = false
    for i in 1..<list.count {
        let diff = list[i] - list[i-1]

        if diff > 0 {is_increasing = true}
        if diff < 0 {is_decreasing = true}
        if diff == 0 || abs(diff) > 3 || (is_increasing && is_decreasing) {return false}
    }
    return true
        
}


// Chec k if the list, or any version with one less layer, is safe
func check_safe_2(list: [Int]) -> Bool {
    for i in 0..<list.count {
        let reduced_array = Array(list[0..<i] + list[i+1..<list.count])
        if check_safe_1(list: list) || check_safe_1(list: reduced_array) {
            return true
        }
    }
    return false
}



// Parse the inpout into 2d array
let input = (try? String(contentsOf: URL(filePath: "2.txt"), encoding: String.Encoding.utf8)) ?? ""

let rows = input.split(separator: "\n")

var safe_lists_1 = 0
var safe_lists_2 = 0

for row in rows {
    let row_list = row.split(separator: " ").map { i in
        Int(i)!
    }

    safe_lists_1 = safe_lists_1 + (check_safe_1(list: row_list) ? 1 : 0)
    safe_lists_2 = safe_lists_2 + (check_safe_2(list: row_list) ? 1 : 0)

}

print("Part 1 \(safe_lists_1)")
print("Part 2 \(safe_lists_2)")



