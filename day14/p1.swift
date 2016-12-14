import Foundation

public func process(input: String) -> Int {
    func repeats(input: String, count: Int, what: String? = nil) -> String? {
        if let what = what { return (input.contains(String(repeating: what, count: count)) ? what : nil) }
        let arr = Set(input.characters.map{"\($0)"})
        for a in arr { if input.contains(String(repeating: a, count: count)) { return a } }
        return nil
    }
    var found = 0
    for i in 0...Int.max {
        let v1 = "\(input)\(i)".md5()
        if let w = repeats(input: v1, count: 3) {
            for j in (i+1)..<(i+1000) {
                let v2 = "\(input)\(j)".md5()
                if let _ = repeats(input: v2, count: 5, what: w) {
                    found += 1
                    print("found \(found) on \(i)")
                    if found == 64 { return i }
                }
            }
        }
    }
    return -1
}
