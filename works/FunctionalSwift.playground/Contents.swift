//: Playground - noun: a place where people can play

import UIKit

// StringFilter

typealias StringFilter = String -> String

func shiftString(by: Int) -> StringFilter {
    return { string in
        var result = ""
        string.unicodeScalars.forEach { u in
            result += String(UnicodeScalar(u.value + UInt32(by)))
        }
        return result
    }
}

func dupString(count: Int) -> StringFilter {
    return { string in
        var result = ""
        for _ in 0..<count {
            result += string
        }
        return result
    }
}

infix operator ** { associativity left }

func **(filter1: StringFilter, filter2: StringFilter) -> StringFilter {
    return { string in
        return filter1(filter2(string))
    }
}

shiftString(2)("a") // c
dupString(5)("a") // aaaaaa
dupString(5)(shiftString(2)("a")) // ccccc

let filter = shiftString(2) ** dupString(5)
filter("a") // cccc


// -> A -> B -> C == -> A -> (B -> C)

//func curry<A, B, C>(f: (A, B) -> C) -> A -> B -> C {
func curry<A, B, C>(f: (A, B) -> C) -> A -> (B -> C) {
    return { x in
        { y in
            f(x, y)
        }
    }
}

func concat(a: String, _ b: String) -> String {
    return a + b
}

concat("a", "b")
let curried = curry(concat)
curried("a")("b")


// precedence

infix operator *** { associativity left precedence 140 }

func ***(num1: Int, num2: Int) -> Int {
    return num1 * num2 * num2
}

infix operator **** { associativity left precedence 150 }

func ****(num1: Int, num2: Int) -> Int {
    return num1 *** num2
}

1 + 2 *** 3 // 27
1 + 2 **** 3 // 19


// ShiftableInstance

protocol Shiftable {
    func shift() -> Self
}

extension String: Shiftable {
    func shift() -> String {
        return shiftString(1)(self)
    }
}

extension Int: Shiftable {
    func shift() -> Int {
        return self << 1
    }
}

"a".shift() // b
1.shift() // 2

extension Array where Element: Shiftable {
    func shift() -> [Element] {
        return map { $0.shift() }
    }
}

["a", "b"].shift() // b, c
[1, 2].shift() // 2, 4

func shiftShiftable<T: Shiftable>(s: T) {
    s.shift()
}

shiftShiftable("a") // b
shiftShiftable(1) // 2
//shiftShiftable([1, 2]) // error

"a" is Shiftable // true
1 is Shiftable // true
[1] is Shiftable // false

struct ShiftableInstance<T> {
    let shift: () -> T
}

func shiftShiftableInstance<T>(s: ShiftableInstance<T>) {
    s.shift()
}

shiftShiftableInstance(ShiftableInstance(shift: "a".shift)) // b
shiftShiftableInstance(ShiftableInstance(shift: 1.shift)) // 2
shiftShiftableInstance(ShiftableInstance(shift: [1, 2].shift)) // [2, 4]


// Backtick

//let class = "test" // error
let `class` = "test"
print(`class`) // test


// indirect

indirect enum Item {
    case File
    case Directory(Item)
}

extension Item {
    init() {
        self = .File
    }
    
    init(_ value: Item) {
        self = .Directory(value)
    }
}

Item() // File
Item(Item()) // Directory


// mutating

extension GeneratorType {
    //func test() { // error
    mutating func test() {
        while let x = self.next() {
            print(x)
        }
    }
}


// AnyGenerator

func countUp() -> AnyGenerator<Int> {
    var i = 0
    return anyGenerator { ++i }
}

let generator = countUp()
generator.next() // 1
generator.next() // 2


// GeneratorOfOne

var generator3 = GeneratorOfOne(3)
generator3.next() // 3
generator3.next() // nil

var generatorNil = GeneratorOfOne<Int?>(nil)
generatorNil.next() // nil
generatorNil.next() // nil

let array3 = Array(GeneratorOfOne(3))

let any3 = anyGenerator(GeneratorOfOne(3))
any3.next() // 3
any3.next() // nil

func +<T: GeneratorType, U: GeneratorType where T.Element == U.Element> (var gen1: T, var gen2: U) -> AnyGenerator<T.Element>
{
    return anyGenerator { gen1.next() ?? gen2.next() }
}

let numberNil: Int? = nil
let number1 = 1
let genNumber = anyGenerator(GeneratorOfOne(numberNil)) + anyGenerator(GeneratorOfOne(number1))
genNumber.next() // 1
genNumber.next() // nil

	