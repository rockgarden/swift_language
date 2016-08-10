//: [Previous](@previous)

//: # subscripts 下标


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    // 定义下标:实现通过下标访问矩阵
    subscript(row: Int, column: Int) -> Double {
        //subcripts可被读写或只读 (read-only时不需要实现getters and setters)
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        //默认提供newValue, but you can change the name of the received value.
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
//This is setting up the first position of the matrix
matrix[0, 0] = 2.5
let number = matrix[0,0]
//This call will fail, since it's out of bounds.
//matrix[3, 3] = 4.5


//: 扩展添加下标
extension String {
    //返回指字符串指定位置的字符
    subscript(idx: Int) -> String {
        get {
            if idx > -1 && idx < self.characters.count {
                var count = 0
                var result = ""
                for ch in self.characters{
                    if count == idx {
                        result = "\(ch)"
                    }
                    count += 1
                }
                return result
            }else {
                return ""
            }
        }
        set {
            var result = ""
            var count = 0
            for ch in self.characters{
                if count == idx {
                    result += newValue
                } else {
                    result += "\(ch)"
                }
                count += 1
            }
            self = result
        }
    }
    subscript(start: Int, end: Int) -> String {
        if start > -1 && start < self.characters.count && end > -1 && end <= self.characters.count && start < end {
            var result = ""
            var count = 0
            for ch in self.characters{
                if count >= start && count < end {
                    result.append(ch)
                }
                count += 1
            }
            return result
        }else{
            return ""
        }
    }
}
var strSubscript = "long long code is trouble"
(strSubscript[15])
strSubscript[0] = "w"
strSubscript[6] = "k"
(strSubscript[0,10])


//: [Next](@next)
