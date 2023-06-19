let names = ["Piper", "Alex", "Suzanne", "Gloria"]
print(names[0...])
print(names[1...2])
print(names[1..<3])
let range = 1...5
print(range.upperBound)
print(range.last!)

let neededNames = 2
var collectedNames: [String] = []
for index in 0... {
    guard collectedNames.count != neededNames else { break }
    collectedNames.append(names[index])
}
print(collectedNames)

var dice: Int = 0
while dice != 21 {
    dice = Int.random(in: 1...21)
    print(dice)
}
print()

// Checkpoint 3
for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FizzBuzz")
    } else if  i.isMultiple(of: 5) {
        print("Buzz")
    } else if i.isMultiple(of: 3) {
        print("Fizz")
    } else {
        print(i)
    }
}
