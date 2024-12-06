import Foundation

var input = (try? String(contentsOf: URL(filePath: "4.txt"), encoding: String.Encoding.utf8)) ?? ""

let move = input.split(separator: "\n")[0].count


let horizontal_pattern = try? Regex("XMAS")
let vertical_pattern = try? Regex("X(.|\n){\(move)}M(.|\n){\(move)}A(.|\n){\(move)}S")
let diagonal_right_pattern = try? Regex("X(.|\n){\(move+1)}M(.|\n){\(move+1)}A(.|\n){\(move+1)}S")
let diagonal_left_pattern = try? Regex("X(.|\n){\(move-1)}M(.|\n){\(move-1)}A(.|\n){\(move-1)}S")

var total_1 = 0

func findOverlappingMatches(in text: String, regex: Regex<AnyRegexOutput>) -> [String] {
    var matches: [String] = []
    var searchIndex = text.startIndex
    
    while searchIndex < text.endIndex {
        if let match = text[searchIndex...].firstMatch(of: regex) {

            // Check if match is valid, i.e. either on one line, or 4 lines
            let value = String(text[match.range]) 
            let rows = value.split(separator: "\n").count
            if rows == 4 || rows == 1 {
                matches.append(value)
                searchIndex = text.index(after: match.range.lowerBound)
            } else {
                break
            }
        } else {
            break
        }
    }
    return matches
}

total_1 = total_1 + findOverlappingMatches(in: input, regex: horizontal_pattern!).count
total_1 = total_1 + findOverlappingMatches(in: input, regex: vertical_pattern!).count
total_1 = total_1 + findOverlappingMatches(in: input, regex: diagonal_right_pattern!).count
total_1 = total_1 + findOverlappingMatches(in: input, regex: diagonal_left_pattern!).count
total_1 = total_1 + findOverlappingMatches(in: String(input.reversed()), regex: horizontal_pattern!).count
total_1 = total_1 + findOverlappingMatches(in: String(input.reversed()), regex: vertical_pattern!).count
total_1 = total_1 + findOverlappingMatches(in: String(input.reversed()), regex: diagonal_right_pattern!).count
total_1 = total_1 + findOverlappingMatches(in: String(input.reversed()), regex: diagonal_left_pattern!).count



print("Part 1 \(total_1)")


let cross_pattern = try? Regex("M.SX(.|\n){\(move)}M(.|\n){\(move)}A(.|\n){\(move)}S")

