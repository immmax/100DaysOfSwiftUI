import Cocoa

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Slava", "Sasha", "Max"]

if guests.isNotEmpty {
    print(guests.count)
}
