import Foundation

class Bot {
    var id: Int
    var what = [Int]()
    var to: (Int?, Int?)
    init(id: Int, to: (Int?, Int?)) { self.id = id; self.to = to }
}

func process(input: [String]) -> Int {
    var bots = [Bot]()
    var values = [(Int, Int)]()
    var outputs = [Int:Int]()
    func process(input: String) {
        guard input != "" else { return }
        let array = input.components(separatedBy: " ")
        let type = array[0]
        switch type {
        case "bot":
            let to1 = array[5] == "bot" ? Int(array[6])! : -1 - Int(array[6])!
            let to2 = array[10] == "bot" ? Int(array[11])! : -1 - Int(array[11])!
            bots.append(Bot(id: Int(array[1])!, to: (to1,to2)))
        case "value":
            values.append((Int(array[1])!,Int(array[5])!))
        default: break
        }
    }
    
    func evaluate() {
        func evaluate(value: Int, botId: Int) {
            let bot = bots.filter { $0.id == botId }.first!
            bot.what.append(value)
            if bot.what.count == 2 {
                let what = bot.what.sorted()
                if let to = bot.to.0 {
                    if to < 0 { outputs[abs(to+1)] = what[0] }
                    else { evaluate(value: what[0], botId: to)} }
                if let to = bot.to.1 {
                    if to < 0 { outputs[abs(to+1)] = what[1] }
                    else {evaluate(value: what[1], botId: to) }
                }
            }
        }
        for v in values { evaluate(value: v.0, botId: v.1) }
    }
    
    for i in input { process(input: i)}
    evaluate()
    return outputs.filter { $0.0 == 0 || $0.0 == 1 || $0.0 == 2 }.map { $0.1 }.reduce(1,*)
}


func read() -> [String] {
    let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
    let content = try! String(contentsOf: fileURL!, encoding: .utf8)
    return content.components(separatedBy: .newlines)
}

process(input: read())
