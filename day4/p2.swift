import Foundation

extension String {
  func slice(from: String, to: String) -> String? {
    return (range(of: from)?.upperBound).flatMap { substringFrom in
      (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
        substring(with: substringFrom..<substringTo)
      }
    }
  }
}

struct Code {
  let value: String
  let sector: Int
  let commons: String
}

func process(input: [Code]) -> [Code] {
  func validate(input: Code) -> Code? {
    var eval = [String: Int]()
    for c in input.value.characters { let s = String(c); eval[s] = eval[s] == nil ? 1 : eval[s]! + 1 }
    return eval
      .sorted { $0.key < $1.key }
      .sorted { $0.value == $1.value ? $0.key < $1.key : $0.value > $1.value }[0...4]
      .reduce("", { $0 + $1.key }) == input.commons ? input : nil
  }
  return input.flatMap(validate)
}

func process2(input: [Code]) -> Int {
  func rot(input: String, by: UInt32) -> String {
    func rot(unicodeScalar: UnicodeScalar) -> UnicodeScalar {
      var result = unicodeScalar.value
      if 65...90 ~= result { result = (result + by - 65) % 26 + 65 }
      else if 97 ... 122 ~= result { result = (result + by - 97) % 26 + 97 }
      return UnicodeScalar(result)!
    }
    
    let resultUSs = input.unicodeScalars.map(rot)
    var resultUSV = String.UnicodeScalarView()
    resultUSV.append(contentsOf: resultUSs)
    return String(resultUSV)
  }
  
  let processed = process(input: input)
  for i in processed { if rot(input: i.value, by: UInt32(i.sector)) == "northpoleobjectstorage" { return i.sector } }
  return -1
}

func read() -> [Code] {
  let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
  let content = try! String(contentsOf: fileURL!, encoding: .utf8)
  return content.components(separatedBy: .newlines).flatMap({ (str) -> Code? in
    if str == "" { return nil }
    let commons = str.slice(from: "[", to: "]")
    let numberIndex = str.rangeOfCharacter(from: .decimalDigits)!
    let value = str.substring(to: numberIndex.lowerBound).replacingOccurrences(of: "-", with: "")
    let signIndex = str.range(of: "[")!
    let numbers = str.substring(with: Range(uncheckedBounds: (numberIndex.lowerBound, signIndex.lowerBound)))
    return Code(value: value, sector: Int(numbers)!, commons: commons!)
  })
}

process2(input: read())
