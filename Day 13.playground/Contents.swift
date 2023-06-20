protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var agent: String { get }
}

extension Building {
    func printSalesSummary() {
        print("Sales summary is \(self.rooms * self.cost)")
    }
}

struct House: Building {
    var rooms = 3
    var cost = 10_000
    var agent = "Bond, James Bond"
}

struct Office: Building {
    var rooms = 25
    var cost = 25_000
    var agent = "Klark"
}
var house = House()
var office = Office()

house.printSalesSummary()
office.printSalesSummary()
