import Foundation

func process(input: [(Int, Int, Int)]) -> Int {
    func validate(input: (Int, Int, Int)) -> Bool {
        return input.0 < input.1 + input.2 && input.1 < input.0 + input.2 &&
            input.2 < input.0 + input.1
    }
    return input.reduce(0, { $0 + (validate(input: $1) ? 1 : 0) })
}

func read() -> [(Int,Int,Int)] {
    let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
    let content = try! String(contentsOf: fileURL!, encoding: .utf8)
    let array = content.components(separatedBy: .newlines)
    var fixed = array.map { $0.components(separatedBy: " ").map { Int($0) }.filter { $0 != nil } as! [Int] }.flatMap { $0 }
    var correct = [(Int, Int, Int)]()
    for i in 0..<fixed.count where i % 9 == 0 {
        correct.append((fixed[i], fixed[i+3], fixed[i+6]))
        correct.append((fixed[i+1], fixed[i+4], fixed[i+7]))
        correct.append((fixed[i+2], fixed[i+5], fixed[i+8]))
    }
    return correct
}

process(input: read())
