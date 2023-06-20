struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var currentGear: Int = 0
    
    init(model: String, numberOfSeats: Int, currentGear: Int = 0) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        self.currentGear = currentGear
    }
    
    mutating func changeGearUp(to gears: Int) {
        if currentGear + gears <= 10{
            currentGear += gears
        } else {
            currentGear = 10
            print("This car has only 10 gears. Current gear were set to \(currentGear)")
        }
    }
    
    mutating func changeGearDown(to gears: Int) {
        if currentGear >= gears {
            currentGear -= gears
        } else {
            currentGear = 0
            print("It's impossible to set a negative gear. Current gear were set to \(currentGear)")
        }
    }
}

var lada = Car(model: "Granta", numberOfSeats: 5, currentGear: 4)
print(lada)
print("Model is \(lada.model)")
print("Car has \(lada.numberOfSeats) seats")
print("Current gras is \(lada.currentGear)")
lada.changeGearDown(to: 3)
print("Current gras is \(lada.currentGear)")
lada.changeGearDown(to: 3)
print("Current gras is \(lada.currentGear)")
lada.changeGearUp(to: 11)
print("Current gras is \(lada.currentGear)")
