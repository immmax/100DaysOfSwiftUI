func intArray (_ array: [Int]?) -> Int {
    return array?.randomElement() ?? Int.random(in: 1...100)
}

var example1: Array<Int>?
print("A random number is \(intArray(example1))")
var example2 = [4, 8, 15, 16, 23, 42]
print("A random number from an array is \(intArray(example2))")
