# AttributeKit

AttributeKit is a collection of `propertyWrapper` for various function

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/d3136295423b4476a145799a0a1198f0)](https://app.codacy.com/gh/hainayanda/AttributeKit/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
![build](https://github.com/hainayanda/AttributeKit/workflows/build/badge.svg)
![test](https://github.com/hainayanda/AttributeKit/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/AttributeKit.svg?style=flat)](https://cocoapods.org/pods/AttributeKit)
[![License](https://img.shields.io/cocoapods/l/AttributeKit.svg?style=flat)](https://cocoapods.org/pods/AttributeKit)
[![Platform](https://img.shields.io/cocoapods/p/AttributeKit.svg?style=flat)](https://cocoapods.org/pods/AttributeKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.5 or higher
- iOS 13.0 or higher
- MacOS 10.15 or higher (SPM Only)
- TVOS 13.0 or higer (SPM Only)
- XCode 13 or higher

## Installation

### Cocoapods

AttributeKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AttributeKit', '~> 1.0.0'
```

### Swift Package Manager from XCode

- Add it using XCode menu **File > Swift Package > Add Package Dependency**
- Add **<https://github.com/hainayanda/AttributeKit.git>** as Swift Package URL
- Set rules at **version**, with **Up to Next Major** option and put **1.0.0** as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/AttributeKit.git", .upToNextMajor(from: "1.0.0"))
]
```

Use it in your target as an `AttributeKit`

```swift
 .target(
    name: "MyModule",
    dependencies: ["AttributeKit"]
)
```

## Author

hainayanda, hainayanda@outlook.com

## License

AttributeKit is available under the MIT license. See the LICENSE file for more info.

## Usage

AttributeKit contains many `propertyWrapper` to help simplify the development.

### Unique

`Unique` is a `propertyWrapper` that wrapped an array and will automatically filter duplicated value lazily:

```swift
@Unique var numbers: [Int] = [1, 1, 2, 3, 4, 4]

// this will print [1, 2, 3, 4]
print(numbers)

// this will print the original array which is [1, 1, 2, 3, 4, 4]
print($numbers)
```

If your type is not `Equatable` nor `Hashable`, you can pass a comparator or hashable projection closure to used by the propertyWrapper:

```swift
// using equal comparator
@Unique(comparator: { $0.id == $1.id }) var myObjects: [MyObject]

// using hashable projection
@Unique(projection: { $0.id }) var myObjects: [MyObject]

// using hashable property
@Unique(by: \.id) var myObjects: [MyObject]
```

### Filtered

`Filtered` is a `propertyWrapper` that wrapped an array and will automatically filter the value lazily:

```swift
@Filtered({ $0 > 0 }) var numbers: [Int] = [-3, -2, -1, 0, 1, 2, 3]

// this will print [1, 2, 3]
print(numbers)

// this will print the original array which is [-3, -2, -1, 0, 1, 2, 3]
print($numbers)
```

If your wrapped value is `Equatable`, you can ignore the element using filtered:

```swift
@Filtered(ignore: 0) var numbers: [Int] = [0, 1, 2, 3]

// this will print [1, 2, 3]
print(numbers)

// this will print the original array which is [0, 1, 2, 3]
print($numbers)
```

### Sorted

`Sorted` is a `propertyWrapper` that wrapped an array and will automatically sort the value lazily:

```swift
@Sorted(<) var numbers: [Int] = [2, 4, 1, 3]

// this will print [1, 2, 3, 4]
print(numbers)

// this will print the original array which is [2, 4, 1, 3]
print($numbers)
```

If your wrapped value is `Comparable`, you can use `Ascending` or `Descending` instead

```swift
@Ascending var asc: [Int] = [2, 4, 1, 3]
@Descending var desc: [Int] = [2, 4, 1, 3]

// this will print [1, 2, 3, 4]
print(asc)

// this will print [4, 3, 2, 1]
print(desc)

// both will print the original array which is [2, 4, 1, 3]
print($asc)
print($desc)
```

### Bounded

`Bounded` `propertyWrapper` will bound the `Comparable` value in the given bound:

```swift
@Bounded(1...10) var number: Int = 11

// this will print 11
print(number)

// this will print 1...10
print($number)
```

If you want to lower bound or upper bound, you can use `LowerBounded` or `UpperBounded` instead:

```swift
@LowerBounded(1) var lower: Int = 0
@UpperBound(10) var upper: Int = 11

// this will print 1
print(lower)
// this will print 10
print(upper)

// this will print the lower bound which is 1
print($lower)
// this will print the upper bound which is 10
print($upper)
```

### Matched

`Matched` `propertyWrapper` will only accept the value that matched the condition given:

```swift
@Matched({ !$0.isEmpty }) var string: String = "not empty"

// this will print "not empty"
print(string)

// this will be ignored
string = ""

// this will still print "not empty"
print(string)
```

You can use `KeyPath` to the `Equatable` property to check whether its equal to the given value:

```swift
@Matched(\.id, equal: 123) var myObject: MyObject?
```

or if the property is `Comparable`:

```swift
// less than
@Matched(\.age, .lessThan(100)) var myObject: MyObject?

// less than or equal
@Matched(\.age, .lessThanOrEqual(50)) var myObject: MyObject?


// not equal
@Matched(\.age, .notEqual(99)) var myObject: MyObject?


// greater than or equal
@Matched(\.age, .greaterThanOrEqual(1)) var myObject: MyObject?


// greater than
@Matched(\.age, .greaterThan(0)) var myObject: MyObject?
```

If your `wrappedValue` is a string, you match it with regex or character set

```swift
// using regex
@Matched(regex: #"^((?!\.)[\w\-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$"#) var email: String?

// using character set
@Matched(is: .alphanumerics) var text: String?
```

### Mapped

`Mapped` is `propertyWrapper` capable of mapping the value while accessed by its `projectedValue`:

```swift
@Mapped({ $0.count }) var text: String = "test"

//will print 4
print($text)
```

You can use KeyPath to do the mapping too:

```swift
@Mapped(to: \.count) var text: String = "test"

//will print 4
print($text)
```

If you want to map from `String` to `URL`, you can use `URLMapped` instead:

```swift
@URLMapped var url: String

let urlObject: URL? = $url
```

### Dated

`Dated` is `propertyWrapper` capable of mapping various values to `Date` when accessed by its `projectedValue`. For String:

```swift
@Dated(format: "dd-MMM-yyyy") var string: String = "10-May-1991"

let date: Date? = $string
```

While for most number types (`Int`, `Float`, `Double`), you can do it like this:

```swift
@Dated(unit: .days, .since1970) var int: Int = 1000
```

available units are `days`, `hours`, `minutes`, `seconds`, and `milliseconds`.

### AutoReleased

`AutoReleased` `propertyWrapper` will release its value after given lifeSpan:

```swift
// will release the object after 10 seconds
@AutoReleased(lifeSpan: 10) var myObject: MyObject?

// change the lifespan to 20 second
$myObject = 20
```

### Buffered

`Buffered` is `propertyWrapper` that has a buffer for the previous value assigned to it. You simply give how much buffer you want to give for the `propertyWrapper`:

```swift
@Buffered(size: 3) var numbers: Int = 1

numbers = 2
numbers = 3
numbers = 4

// this will print [2, 3, 4]
print($numbers)
```

### Stats

`Stats` is a `propertyWrapper` that will record statistics of the `propertyWrapper` assigned history:

```swift
@Stats var number: Int = 1

let statistic: Statistic = $number
```

the `Statistic` object will contain many information about the statistic of the `propertyWrapper` assign history:

```swift
public struct Statistic<Value: Calculatable> {
    public private(set) var maximum: Value
    public private(set) var minimum: Value
    public private(set) var total: Value
    public private(set) var count: Int
    public var average: Value { ... }

    ...
    ...
}
```

### Encodability and Decodability of the propertyWrapper

Because of the limitation of Swift language, not all `propertyWrapper` can implement `Encodable` and `Decodable` by default.

Here's a list of `propertyWrapper` that implement `Encodable` if the wrapped value is `Encodable`:

- `AutoReleased`
- `Bounded`
- `LowerBounded`
- `UpperBounded`
- `Buffered`
- `Dated`
- `Filtered`
- `URLMapped`
- `Matched`
- `Sorted`
- `Ascending`
- `Descending`
- `Stats`
- `Unique`

And Here's a list of propertyWrapper that implement `Decodable` if the wrapped value is `Decodable`:

- `URLMapped`
- `Ascending`
- `Descending`
- `Stats`
- `Unique` only if its `wrappedValue` is `Equatable`

## Contribute

You know how, just clone and do a pull request