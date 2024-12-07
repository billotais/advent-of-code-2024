import Foundation

var input = (try? String(contentsOf: URL(filePath: "4.txt"), encoding: String.Encoding.utf8)) ?? ""

let move = input.split(separator: "\n")[0].count


let horizontal_pattern = try? Regex("XMAS")
let vertical_pattern = try? Regex("X(.|\n){\(move)}M(.|\n){\(move)}A(.|\n){\(move)}S")
let diagonal_right_pattern = try? Regex("X(.|\n){\(move+1)}M(.|\n){\(move+1)}A(.|\n){\(move+1)}S")
let diagonal_left_pattern = try? Regex("X(.|\n){\(move-1)}M(.|\n){\(move-1)}A(.|\n){\(move-1)}S")

var total_1 = 0

func findOverlappingMatches(in text: String, regex: Regex<AnyRegexOutput>, valid_lines: [Int]) -> [String] {
    var matches: [String] = []
    var searchIndex = text.startIndex
    
    while searchIndex < text.endIndex {
        if let match = text[searchIndex...].firstMatch(of: regex) {

            // Check if match is valid, i.e. either on one line, or 4 lines
            let value = String(text[match.range]) 
            let rows = value.split(separator: "\n").count
            if valid_lines.contains(rows) {
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

total_1 = total_1 + findOverlappingMatches(in: input, regex: horizontal_pattern!, valid_lines: [1,4]).count
total_1 = total_1 + findOverlappingMatches(in: input, regex: vertical_pattern!, valid_lines: [1,4]).count
total_1 = total_1 + findOverlappingMatches(in: input, regex: diagonal_right_pattern!, valid_lines: [1,4]).count
total_1 = total_1 + findOverlappingMatches(in: input, regex: diagonal_left_pattern!, valid_lines: [1,4]).count
total_1 = total_1 + findOverlappingMatches(in: String(input.reversed()), regex: horizontal_pattern!, valid_lines: [1,4]).count
total_1 = total_1 + findOverlappingMatches(in: String(input.reversed()), regex: vertical_pattern!, valid_lines: [1,4]).count
total_1 = total_1 + findOverlappingMatches(in: String(input.reversed()), regex: diagonal_right_pattern!, valid_lines: [1,4]).count
total_1 = total_1 + findOverlappingMatches(in: String(input.reversed()), regex: diagonal_left_pattern!, valid_lines: [1,4]).count



print("Part 1 \(total_1)")

var total_2 = 0
let cross_pattern = try? Regex("M.S(.|\n){\(move-1)}A(.|\n){\(move-1)}M.S")
let cross_pattern_invert = try? Regex("S.S(.|\n){\(move-1)}A(.|\n){\(move-1)}M.M")

total_2 = total_2 + findOverlappingMatches(in: input, regex: cross_pattern!, valid_lines: [3]).count
total_2 = total_2 + findOverlappingMatches(in: input, regex: cross_pattern_invert!, valid_lines: [3]).count
total_2 = total_2 + findOverlappingMatches(in: String(input.reversed()), regex: cross_pattern!, valid_lines: [3]).count
total_2 = total_2 + findOverlappingMatches(in: String(input.reversed()), regex: cross_pattern_invert!, valid_lines: [3]).count

print("Part 2 \(total_2)")