import Foundation

func process(input: String) -> String {
  var result = ["","","","","","","",""]
  var pointer = 0
  while true {
    if pointer % 100000 == 0 { print("pointer: \(pointer) result: \(result)") }
    let md = "\(input)\(pointer)".md5()
    if md.hasPrefix("00000") {
      if let index = Int(String(md[md.index(md.startIndex, offsetBy: 5)])), index < result.count, result[index] == "" {
        let char = String(md[md.index(md.startIndex, offsetBy: 6)])
        print("char: \(char) index: \(index) pointer: \(pointer)")
        result[index] = char
        if result.filter({ $0 == "" }).count == 0 { return result.reduce("",+) }
      }
    }
    pointer += 1
  }
  return "error"
}

process(input: "")
