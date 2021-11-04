# iOS
#### The new things that I've recently learned, trying to learn, trying to remember...

<br/>
<br/>


### 1 - Difference between **_class func_** and **_static func_**:
<br/>

[stackoverflow](https://stackoverflow.com/questions/25156377/what-is-the-difference-between-static-func-and-class-func-in-swift)

static is for static functions of structs and enums, and class for classes and protocols.
That's the main difference. Some other differences are that class functions are dynamically dispatched and can be overridden by subclasses.

Protocols use the class keyword, but it doesn't exclude structs from implementing the protocol, they just use static instead. Class was chosen for protocols so there wouldn't have to be a third keyword to represent static or class.

From Chris Lattner on this topic:

> We considered unifying the syntax (e.g. using "type" as the keyword), but that doesn't actually simply things. The keywords "class" and "static" are good for familiarity and are quite descriptive (once you understand how + methods work), and open the door for potentially adding truly static methods to classes. The primary weirdness of this model is that protocols have to pick a keyword (and we chose "class"), but on balance it is the right tradeoff.

```swift
class ClassA {
  class func func1() -> String {
    return "func1"
  }

  static func func2() -> String {
    return "func2"
  }

  /* same as above
  final class func func2() -> String {
    return "func2"
  }
  */
}
```

static func is same as final class func

Because it is final, we can not override it in subclass as below:

```swift
class ClassB : ClassA {
  override class func func1() -> String {
    return "func1 in ClassB"
  }

  // ERROR: Class method overrides a 'final` class method
  override static func func2() -> String {
    return "func2 in ClassB"
  }
}
```

> To declare a type variable property, mark the declaration with the static declaration modifier. Classes may mark type computed properties with the class declaration modifier instead to allow subclasses to override the superclass’s implementation. Type properties are discussed in Type Properties.

> NOTE
>In a class declaration, the keyword static has the same effect as marking the declaration with both the class and final declaration modifiers.
