let names = ["Mathew", "Lucas", "Mark", "John", "Peter", "Paul", "John"]
print(names.count)
print(Set(names).count)

print(names.isEmpty)
var cities: Array = [String]()
cities.append("Kirov")
cities.append("Kaluga")
cities.append("Moscow")
cities.append("Atyrau")
cities.append("Almaty")
cities.append("Istanbul")
cities.append("Mexico City")
print(cities)
print(cities[4])

var countries: Set<String> = []
countries.insert("Russia")
countries.insert("Ukraine")
countries.insert("Belarus")
countries.insert("Kazakhstan")
countries.insert("Turkey")
countries.insert("Mexico")

print(countries)
print(countries.contains("Mexico"))

enum PortsOfEntry {
    case Brownswill, CalexicoWest, EaglePass, Hildago, Laredo, Nogales, PasoDelNotre, SanYsidro
}

var portCatched: PortsOfEntry = .SanYsidro
print(portCatched)
portCatched = .Hildago
print(portCatched)

var name = "Maxim"
var occupation = "Apple Developer"
print("\(name) is an \(occupation)")

var persons: Dictionary = [String: String]()
var stuff: Dictionary = [String: Dictionary<String, String>]()

persons["Walter White"] = "The Cook"
persons["Skylar White"] = "Cook's Wife"
persons["Walter Junior"] = "Cook's Son"
persons["Gus Fring"] = "Businessman"
persons["Hank Schreider"] = "DEA Agent"
print(persons)

persons.removeValue(forKey: "Skylar White")
print(persons)
