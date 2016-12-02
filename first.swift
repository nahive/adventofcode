func process(array: [String]) -> Int {
    let directions = [[1,0], [0,1], [-1,0], [0,-1]]
    var pos = [0,0]
    var dir = 0
    for (index, direction) in array.enumerated() {
        let d = direction[direction.index(direction.startIndex, offsetBy: 0)]
        let v = Int(direction[direction.index(direction.startIndex, offsetBy: 1)..<direction.endIndex])!
        switch d {
        case "R": if dir + 1 > 3 { dir = 0 } else { dir += 1 }
        case "L": if dir - 1 < 0 { dir = 3 } else { dir -= 1 }
        default: break
        }
        pos[0] += directions[dir][0] * v
        pos[1] += directions[dir][1] * v
    }
    return abs(pos[0]) + abs(pos[1])
}

let arr = ["R2", "L1", "R2", "R1", "R1", "L3", "R3", "L5", "L5", "L2", "L1", "R4", "R1", "R3", "L5", "L5", "R3", "L4", "L4", "R5", "R4", "R3", "L1", "L2", "R5", "R4", "L2", "R1", "R4", "R4", "L2", "L1", "L1", "R190", "R3", "L4", "R52", "R5", "R3", "L5", "R3", "R2", "R1", "L5", "L5", "L4", "R2", "L3", "R3", "L1", "L3", "R5", "L3", "L4", "R3", "R77", "R3", "L2", "R189", "R4", "R2", "L2", "R2", "L1", "R5", "R4", "R4", "R2", "L2", "L2", "L5", "L1", "R1", "R2", "L3", "L4", "L5", "R1", "L1", "L2", "L2", "R2", "L3", "R3", "L4", "L1", "L5", "L4", "L4", "R3", "R5", "L2", "R4", "R5", "R3", "L2", "L2", "L4", "L2", "R2", "L5", "L4", "R3", "R1", "L2", "R2", "R4", "L1", "L4", "L4", "L2", "R2", "L4", "L1", "L1", "R4", "L1", "L3", "L2", "L2", "L5", "R5", "R2", "R5", "L1", "L5", "R2", "R4", "R4", "L2", "R5", "L5", "R5", "R5", "L4", "R2", "R1", "R1", "R3", "L3", "L3", "L4", "L3", "L2", "L2", "L2", "R2", "L1", "L3", "R2", "R5", "R5", "L4", "R3", "L3", "L4", "R2", "L5", "R5"]

process(array: arr)


