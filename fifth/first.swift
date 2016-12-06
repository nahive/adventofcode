import Foundation
import CryptoSwift

func process(input: String) -> String {
  var result = ""
  var index = 0
  while result.characters.count < 8 {
    let md = "\(input)\(index)").md5
    if md.hasPrefix("00000") {
      result += String(md[md.index(md.startIndex, offsetBy: 5)])
    }
    index += 1
  }
  return result
}

process(input: "abc")
