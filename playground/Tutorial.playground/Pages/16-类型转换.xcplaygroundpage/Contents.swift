//: # 类型转换(Type Casting)
// 类型转换在 Swift 中使用 is 和 as 操作符实现。
import UIKit


//1.定义一个类层次作为例子
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
// the type of "library" is inferred to be [MediaItem]



//2.用类型检查操作符( is )来检查一个实例是否属于特定子类型。
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")
// prints "Media library contains 2 movies and 3 songs"


//3.向下转到它的子类型,用类型转换操作符( as? 或 as! )
for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}
// Movie: 'Casablanca', dir. Michael Curtiz
// Song: 'Blue Suede Shoes', by Elvis Presley
// Movie: 'Citizen Kane', dir. Orson Welles
// Song: 'The One And Only', by Chesney Hawkes // Song: 'Never Gonna Give You Up', by Rick Astley



//: Any和 AnyObject￼ 的类型转换

/*
Swift为不确定类型提供了两种特殊类型别名:
• AnyObject可以代表任何class类型的实例。
• Any可以表示任何类型,包括方法类型(function types)。
*/

//1. 定义了一个 ￼[AnyObject] 类型的数组并填入三个 Movie￼ 类型的实例:
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]

//因为知道这个数组只包含 Movie 实例,你可以直接用( as! )下转并解包到不可选的 Movie 类型:
for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}


//为了变为一个更短的形式,下转 someObjects 数组为 [Movie] 类型来代替下转数组中每一项的方式。
for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}


//2.使用 Any 类型来和混合的不同类型一起工作,包括方法类型和非 class 类型。它创建了一个可以存储Any类型的数组 things 。
var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String: print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

//在一个switch语句的case中使用强制形式的类型转换操作符(as, 而不是 as?)来检查和转换到一个明确的类型。在 switch case 语句的内容中这种检查总是安全的。


func toInt(_ value: Any?) -> Int {
    guard let v = value else {
        return 0
    }
    if v is Int { return v as! Int }
    if let s = v as? String { return Int(s) ?? 0 }
    if let b = v as? Bool { return b ? 1 : 0 }
    if let d = v as? Double { return Int(d) }
    if let f = v as? Float { return Int(f) }

    if let c = v as? Character {
        var i = 0
        for scalar in String(c).unicodeScalars {
            i = Int(scalar.value)
        }
        return i
    }
    return 0
}

toInt(1)
toInt(true)
toInt(false)
toInt("123")
toInt(Character("a"))
toInt("")
toInt(1.4)
toInt(Double(2.22))
toInt([1,2])


func toBool(_ value: Any?) -> Bool {
    guard let v = value else {
        return false
    }
    if let b = v as? Bool { return b }
    if let i  = v as? Int { return i != 0 }
    if let s = v as? String { return !s.isEmpty }
    if let d = v as? Double { return d != 0 }
    if let f = v as? Float { return f != 0 }
    if v is Character { return true }

    return false
}

toBool(1)
toBool(0)
toBool("1")
toBool("")
toBool(false)
toBool(true)
toBool(0.22)
toBool(Double(1.11))
toBool([])
