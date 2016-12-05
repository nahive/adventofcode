import Foundation

func process(input: [(Int, Int, Int)]) -> Int {
    func validate(input: (Int, Int, Int)) -> Bool {
        return input.0 < input.1 + input.2 && input.1 < input.0 + input.2 &&
            input.2 < input.0 + input.1
    }
    return input.reduce(0, { $0 + (validate(input: $1) ? 1 : 0) })
}

func read() -> [(Int,Int,Int)] {
    func triangle(input: String) -> (Int, Int, Int)? {
        guard let arr = (input.components(separatedBy: " ").map { Int($0) }.filter { $0 != nil } as? [Int]), arr.count == 3 else { return nil }
        return (arr[0], arr[1], arr[2])
    }
    let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
    let content = try! String(contentsOf: fileURL!, encoding: .utf8)
    let array = content.components(separatedBy: .newlines)
    return array.map { triangle(input: $0) }.filter { $0 != nil } as! [(Int, Int, Int)]
}

process(input: read())
