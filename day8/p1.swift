import Foundation

func process(input: [String]) -> Int {
    var matrix = [[Int]](repeatElement([Int](repeatElement(0, count: 50)), count: 6))
    func eval(input: String) {
        func fill(x: Int, y: Int){ for i in 0..<x { for j in 0..<y { if matrix.count > j && matrix[j].count > i { matrix[j][i] = 1 }}}}
        func move(row: Int, by: Int){
            guard row < matrix.count else { return }
            var matrixCopy = matrix
            for i in 0..<matrix[row].count { matrixCopy[row][(i + by) % matrix[row].count] = matrix[row][i] }
            matrix = matrixCopy
        }
        func move(col: Int, by: Int){
            guard col < matrix.first!.count else { return }
            var matrixCopy = matrix
            for i in 0..<matrix.count { matrixCopy[(i + by) % matrix.count][col] = matrix[i][col] }
            matrix = matrixCopy
        }
        if input == "" { return }
        let arr = input.components(separatedBy: " ")
        let ins = arr.first!
        switch ins {
        case "rect":
            let xy = arr[1].components(separatedBy: "x")
            fill(x: Int(xy[0])!, y: Int(xy[1])!)
        case "rotate":
            let colrow = arr[1]
            let what = Int(arr[2].components(separatedBy: "=")[1])!
            let by = Int(arr[4])!
            switch colrow {
            case "column":
                move(col: what, by: by)
            case "row":
                move(row: what, by: by)
            default: break
            }
            break
        default: break
        }
    }
    for i in input { eval(input: i) }
    return matrix.reduce(0, { $0 + $1.reduce(0) { $0 + $1 }})
}

func read() -> [String] {
    let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
    let content = try! String(contentsOf: fileURL!, encoding: .utf8)
    return content.components(separatedBy: .newlines)
}

process(input: read())
