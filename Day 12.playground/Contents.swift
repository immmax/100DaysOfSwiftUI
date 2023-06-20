class Animal {
    var legs: Int
    init (legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Dog: Bark! Hey, human! I'm just a dog! Feed me!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Corgi: Bark! I'm not a regular dog - I'm a corgi. Be respectful!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Poodle: Bark! I'm Malvina's friend!")
    }
}

class Cat: Animal {
    var isTame: Bool
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak() {
        print("Cat: Meow! I'm a regular cat! I walk where I want.")
    }
}

class Persian: Cat {
    override func speak() {
        print("Persian: I don't say 'Meow'! I'm a persian by the way!")
    }
}

class Lion: Cat {
    override func speak() {
        print("Lion: ROAR! I'm the king!")
    }
}

var animal = Animal(legs: 4)
var dog = Dog(legs: 4)
dog.speak()
var corgi = Corgi(legs: 4)
corgi.speak()
var poodle = Poodle(legs: 3)
poodle.speak()
print("I have \(poodle.legs) legs...")
var cat = Cat(legs: 4, isTame: false)
cat.speak()
var persian = Persian(legs: 4, isTame: true)
persian.speak()
var simba = Lion(legs: 4, isTame: true)
simba.speak()
 
