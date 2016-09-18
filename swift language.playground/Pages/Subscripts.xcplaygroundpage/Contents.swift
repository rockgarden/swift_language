//: [Previous](@previous)
import UIKit
//: # subscripts 下标
do {
    struct Digit {
        var number : Int
        init(_ n:Int) {
            self.number = n
        }
        // 定义下标: 实现通过下标访问Int
        subscript(ix: Int) -> Int {
            get {
                let s = String(self.number)
                return Int(String(s[s.startIndex.advancedBy(ix)]))!
            }
            set {
                var s = String(self.number)
                let i = s.startIndex.advancedBy(ix)
                s.replaceRange(i...i, with: String(newValue))
                self.number = Int(s)!
            }
        }
    }
    var d = Digit(1234)
    let aDigit = d[1] // 2
    d[0] = 2 // now d.number is 2234
    d.number
}
do {
    struct What {
        subscript(first:Int, second:Int) -> Int {
            return 0
        }
    }
    let w = What()
    (w[1,2]) // compiles; there are still too dang-blasted many externalization rules
}
do {
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
    // This call will fail, since it's out of bounds.除非init值大于3
    //matrix[3, 3] = 4.5
}
do {
    class Dog {
        struct Noise {
            static var noise = "Woof"
        }
        func bark() {
            (Dog.Noise.noise)
        }
    }
    Dog.Noise.noise = "Arf"
    Dog().bark()
}
do {
    class ViewController: UIViewController {
        override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
            let app = UIApplication.sharedApplication()
            let window = app.keyWindow
            let vc = window?.rootViewController
            print(vc)
            let vc2 = UIApplication.sharedApplication().keyWindow?.rootViewController
            print(vc2)
            // vc2 = vc same self
        }
    }
}
//: ## 扩展添加下标
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
