
struct Point {
    var x: Int
    var y: Int
    var cgPoint: CGPoint { return CGPoint(x: 250-x, y: 250-y) }
    
    func route(to: Point) -> [Point] {
        var r = [Point]()
        if x < to.x { for i in x..<to.x { r.append(Point(x: i, y: y)) }}
        if to.x < x { for i in ((to.x+1)...x).reversed() { r.append(Point(x: i, y: y))}}
        if y < to.y { for i in y..<to.y { r.append(Point(x: x, y: i)) }}
        if to.y < y { for i in ((to.y+1)...y).reversed() { r.append(Point(x: x, y: i))}}
        return r
    }
}

func process(array: [String]) -> Int {
    let directions = [Point(x: 0, y: 1), Point(x: 1, y: 0), Point(x: 0, y: -1), Point(x: -1, y: 0)]
    var pos = Point(x: 0, y: 0)
    var routes = [Point]()
    var visited = [pos]
    var dir = 0
    for direction in array {
        let d = direction[direction.index(direction.startIndex, offsetBy: 0)]
        let v = Int(direction[direction.index(direction.startIndex, offsetBy: 1)..<direction.endIndex])!
        
        switch d {
        case "R":
            if dir + 1 > 3 { dir = 0 } else { dir += 1 }
        case "L":
            if dir - 1 < 0 { dir = 3 } else { dir -= 1 }
        default: break
        }
        pos.x += directions[dir].x * v
        pos.y += directions[dir].y * v
        let route = visited.last!.route(to: pos)
        var xrs: Point!
        if routes.contains(where: { (p1) -> Bool in
            return route.contains(where: { (p2) -> Bool in
                if p1.x == p2.x && p1.y == p2.y { xrs = Point(x: p1.x, y: p1.y); return true }
                return false
            })
        }) { return abs(xrs.x) + abs(xrs.y) }
        routes += route
        visited.append(pos)
    }
    return -1
}

let arr = ["R2", "L1", "R2", "R1", "R1", "L3", "R3", "L5", "L5", "L2", "L1", "R4", "R1", "R3", "L5", "L5", "R3", "L4", "L4", "R5", "R4", "R3", "L1", "L2", "R5", "R4", "L2", "R1", "R4", "R4", "L2", "L1", "L1", "R190", "R3", "L4", "R52", "R5", "R3", "L5", "R3", "R2", "R1", "L5", "L5", "L4", "R2", "L3", "R3", "L1", "L3", "R5", "L3", "L4", "R3", "R77", "R3", "L2", "R189", "R4", "R2", "L2", "R2", "L1", "R5", "R4", "R4", "R2", "L2", "L2", "L5", "L1", "R1", "R2", "L3", "L4", "L5", "R1", "L1", "L2", "L2", "R2", "L3", "R3", "L4", "L1", "L5", "L4", "L4", "R3", "R5", "L2", "R4", "R5", "R3", "L2", "L2", "L4", "L2", "R2", "L5", "L4", "R3", "R1", "L2", "R2", "R4", "L1", "L4", "L4", "L2", "R2", "L4", "L1", "L1", "R4", "L1", "L3", "L2", "L2", "L5", "R5", "R2", "R5", "L1", "L5", "R2", "R4", "R4", "L2", "R5", "L5", "R5", "R5", "L4", "R2", "R1", "R1", "R3", "L3", "L3", "L4", "L3", "L2", "L2", "L2", "R2", "L1", "L3", "R2", "R5", "R5", "L4", "R3", "L3", "L4", "R2", "L5", "R5"]

process(array: arr)
