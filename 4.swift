import Foundation

var input = (try? String(contentsOf: URL(filePath: "4.txt"), encoding: String.Encoding.utf8)) ?? ""


let move = input.split(separator: "\n")[0].count - 1

input = input.replacingOccurrences(of: "\n", with: "")

let horizontal_pattern = try? Regex("XMAS")
let vertical_pattern = try? Regex("X[A-Z]{\(move)}M[A-Z]{\(move)}A[A-Z]{\(move)}S")
let diagonal_right_pattern = try? Regex("X[A-Z]{\(move+1)}M[A-Z]{\(move+1)}A[A-Z]{\(move+1)}S")
let diagonal_left_pattern = try? Regex("X[A-Z]{\(move-1)}M[A-Z]{\(move-1)}A[A-Z]{\(move-1)}S")

var total = 0

func findOverlappingMatches(in text: String, regex: Regex<AnyRegexOutput>) -> [String] {
    var matches: [String] = []
    var searchIndex = text.startIndex
    
    while searchIndex < text.endIndex {
        if let match = text[searchIndex...].firstMatch(of: regex) {
            matches.append(String(text[match.range]))
            searchIndex = text.index(after: match.range.lowerBound)
        } else {
            break
        }
    }
    print(matches)
    return matches
}

total = total + findOverlappingMatches(in: input, regex: horizontal_pattern!).count
total = total + findOverlappingMatches(in: String(input.reversed()), regex: horizontal_pattern!).count
total = total + findOverlappingMatches(in: input, regex: vertical_pattern!).count
total = total + findOverlappingMatches(in: String(input.reversed()), regex: vertical_pattern!).count
total = total + findOverlappingMatches(in: input, regex: diagonal_right_pattern!).count
total = total + findOverlappingMatches(in: String(input.reversed()), regex: diagonal_right_pattern!).count
total = total + findOverlappingMatches(in: input, regex: diagonal_left_pattern!).count
total = total + findOverlappingMatches(in: String(input.reversed()), regex: diagonal_left_pattern!).count

print(total)

