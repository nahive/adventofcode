import Foundation

func process(input: [String]) -> Int {
    func eval(input: String) -> Bool {
        if input == "" { return false }
        func test(input: String) -> Bool {
            for i in 0..<input.characters.count-3 {
                let a = input[input.index(input.startIndex, offsetBy: i)]
                let b = input[input.index(input.startIndex, offsetBy: i+1)]
                let c = input[input.index(input.startIndex, offsetBy: i+2)]
                let d = input[input.index(input.startIndex, offsetBy: i+3)]
                if a != b && a == d && b == c { return true }
            }
            return false
        }
        let tested = input
            .components(separatedBy: CharacterSet(charactersIn: "[]"))
            .map{test(input: $0)}
            .enumerated()
            .reduce([[Bool](),[Bool]()]) {
                var x = $0
                $1.offset % 2 == 0 ? x[0].append($1.1) : x[1].append($1.1)
                return x
        }
        return !tested[1].reduce(false, { $0 || $1}) && tested[0].reduce(false,{ $0 || $1})
    }
    return input.reduce(0, {$0 + (eval(input: $1) ? 1 : 0)})
}

func read() -> [String] {
    let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
    let content = try! String(contentsOf: fileURL!, encoding: .utf8)
    return content.components(separatedBy: .newlines)
}

process(input: read())
