import Foundation

extension String {
    func indexDistance(of character: Character) -> Int? {
        guard let index = characters.index(of: character) else { return nil }
        return distance(from: startIndex, to: index)
    }
}

func process(input: [String]) -> Int {
    func decompress(input: String) -> Int {
        var input = input
        var count = 0
        for c in input.characters where c == "(" {
            guard input != "" else { break }
            count += input.indexDistance(of: "(")!
            input = input.substring(from: input.range(of: "(")!.upperBound)
            let mark = input[input.startIndex..<input.range(of: ")")!.lowerBound].components(separatedBy: "x")
            input = input.substring(from: input.range(of: ")")!.upperBound)
            count += input.substring(to: input.index(input.startIndex, offsetBy: Int(mark[0])!)).characters.count * Int(mark[1])!
            input = input.substring(from: input.index(input.startIndex, offsetBy: Int(mark[0])!))
        }
        count += input.characters.count
        return count
    }
    
    return input.reduce(0) { $0 + decompress(input: $1) }
}


func read() -> [String] {
    let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
    let content = try! String(contentsOf: fileURL!, encoding: .utf8)
    return content.components(separatedBy: .newlines)
}

process(input: read())
