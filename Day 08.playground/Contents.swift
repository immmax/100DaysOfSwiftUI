enum someErrors: Error {
    case outOfBounds, noRoot
}

func sqrtCustom(for number: Int) throws {
    switch number {
    case 1...10_000:
        for i in 1...100 {
            if i * i == number {
                print("Square root of \(number) is \(i).")
                break
            }
            if i == 100 {
                throw someErrors.noRoot
            }
        }
    default:
        throw someErrors.outOfBounds
    }
}

do {
    try sqrtCustom(for: 10000)
    try sqrtCustom(for: 0)
    try sqrtCustom(for: 47)
} catch someErrors.outOfBounds {
    print("Entered number is out of bounds!")
} catch someErrors.noRoot {
    print("No whole square root for this number!")
}
