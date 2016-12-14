import Foundation

public func process(input: [String]) -> Int {
    var dict = ["a":0,"b":0,"c":1,"d":0]
    var i = 0
    while true {
        if i >= input.count { break }
        if input[i] == "" { break }
        let arr = input[i].components(separatedBy: " ")
        let ins = arr[0]
        switch ins {
        case "cpy": dict[arr[2]] = Int(arr[1]) ?? dict[arr[1]]!; i += 1
        case "inc": 
            let next = input[i+1].components(separatedBy: " ")
            let nextnext = input[i+2].components(separatedBy: " ")
            let ins = next[0]
            if i + 1 < input.count &&
            ins == "dec" &&
            nextnext[0] == "jnz" &&
            nextnext[1] == next[1] &&
            nextnext[2] == "-2" {
                dict[arr[1]]! += dict[next[1]]!
                dict[next[1]] = 0
                i += 3
                continue
            }
            dict[arr[1]]! += 1; i += 1
        case "dec": dict[arr[1]]! -= 1; i += 1
        case "jnz": 
            let v = Int(arr[1]) ?? dict[arr[1]]!
            if v != 0 { i += Int(arr[2])! } else { i += 1 }
        default: i += 1
        }
    }
    return dict["a"]!
}

public func read(file: String) -> [String] {
    return (try! String(contentsOfFile: file)).components(separatedBy: .newlines)
}

let file = read(file: CommandLine.arguments[1])
print(file)
let p1 = process(input: file)
print("p2: \(p1)")
