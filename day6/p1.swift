import Foundation

func process(input: [String]) -> String {
  var eval = [[String:Int]](repeating: [String : Int](), count: input.first!.characters.count)
  for str in input {
    for (i,c) in str.characters.enumerated() {
      eval[i][String(c)] = eval[i][String(c)] == nil ? 1 : eval[i][String(c)]! + 1
    }
  }
  
  return eval
    .map{$0.sorted(by:{$0.1>$1.1}).first!}
    .reduce("",{$0 + $1.0})
}

func read() -> [String] {
  let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
  let content = try! String(contentsOf: fileURL!, encoding: .utf8)
  return content.components(separatedBy: .newlines)
}

process(input: read())
