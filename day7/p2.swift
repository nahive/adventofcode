import Foundation

func process(input: [String]) -> Int {
    func eval(input: String) -> Bool {
        func find(input: String) -> [String] {
            var res = [String]()
            for i in 0..<input.characters.count-2 {
                let a = input[input.index(input.startIndex, offsetBy: i)]
                let b = input[input.index(input.startIndex, offsetBy: i+1)]
                let c = input[input.index(input.startIndex, offsetBy: i+2)]
                if a == c && a != b { res.append("\(a)\(b)\(c)") }
            }
            return res
        }
        func compare(inp1: String, inp2: String) -> Bool {
            guard inp1.characters.count == 3 && inp1.characters.count == 3 else {
                return false
            }
            let i = inp1.index(inp1.startIndex, offsetBy: 0)
            let j = inp1.index(inp1.startIndex, offsetBy: 1)
            return inp1[i] == inp2[j] && inp1[j] == inp2[i]
        }
        if input == "" { return false }
        let split = input.components(separatedBy: CharacterSet(charactersIn: "[]"))
        let out = split.enumerated().filter{$0.0 % 2 == 0}.map{$0.1}.flatMap { find(input: $0) }
        let ins = split.enumerated().filter{$0.0 % 2 != 0}.map{$0.1}.flatMap { find(input: $0) }
        for o in out { for i in ins { if compare(inp1: i, inp2: o) { return true }}}
        return false
    }
    
    return input.map { eval(input: $0) }.reduce(0, {$0 + ($1 ? 1 : 0)})
}

func read() -> [String] {
    let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
    let content = try! String(contentsOf: fileURL!, encoding: .utf8)
    return content.components(separatedBy: .newlines)
}

process(input: read())
