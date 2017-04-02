# LibYACI-1.0 - Yet Another Class Implementation for WoW / LibStub

This is a LibStub Wrapper Implementation of YACI-1.2, which implements basic OOP
features like Classes and Inheritance.

### Introduction
Lua as a programming language is a table driven procedural programming language.
Since LUA was written to extend C for customization it's not necessarily equipped
to offer the OOP functionality that languages like C#, Java or C++ offer. But much
like Javascript with it's prototypes, LUA has something called metatables.

Metatables exist alongside Tables that they are assigned to. Metatables can offer
functionality based on Events. The most common event is `__index`, which is called
when code tries to access Keys in a table that aren't there. The LUA environment then
goes and looks inside an assigned metatable and calls `__index`, which itself can be a
separate table to look for the Key.

This functionality can be used to code in a OOP manner. But there is one downside.
Because lua's metatables are only there to simulate object like behavior, coding OOP
with metatables is what i would call 'anti-intuitive'.

This is where **YACI** steps in. It is meant to provide a _common sense_ notation for classes,
without having to think about the metatable aspect in the background.

### USAGE
Make sure to embed LibStub and LibYACI in your TOC.

```lua
  local YACI = LibStub("LibYACI-1.0")

  SampleClass = YACI:Class("SampleClass") -- SampleClass is now the prototypical namespace of SampleClass

  function SampleClass:init(_name,_length)
    self.ObjectName = _name
    self.ObjectLength = _length
  end

  function SampleClass:__add(rightSide) --lefthandside is passed in context because of the :-Notation
    local newname = self.ObjectName..rightSide.ObjectName
    local newlength = self.ObjectLength + rightSide.ObjectLength
    return SampleClass(newname,newlength)
  end

  SampleInstance = SampleClass("test",4)
```
Inheritance
```lua  
  ExtendedClass = SampleClass:subclass("ExtendedClass")

  function ExtendedClass:init(_name,_length,_examplearg)
    self.super:init(_name,_length) -- calls the BaseClass's constructor and executes within the same scope
    self.ExampleProperty = _examplearg
  end

  ExInstance = ExtendedClass("extendedTest",12,obj)

  print(SampleClass:made(ExInstance)) -- true
  print(ExtendedClass:made(ExInstance)) -- true

  print(ExtendedClass:made(SampleInstance)) -- false

  local additionTest = ExInstance + SampleInstance

  print(additionTest.ObjectLength) -- 16

```


### FEATURES
- Classes
  - `Class(name[,BaseClass])` returns a new Class Namespace based on _Object or _BaseClass_
- Inheritance
  - _Class_`:subclass(name)` returns a new class namespace based on _Class_'s namespace
- Lua-Events
  - Overloading operators like `myobj + myobj2`
  - Overriding default behavior like ToString()
- Methods
  - regular namespace functions get elevated to the status of instance methods
- Instantiation / Constructors
  - _Class_`:init(arg1,arg2,...)` defines Init as the constructor functions
  - `SampleClass(sampleArgument,sampleArgument2)` returns the instance after running the Init function
- Typing
  - _Class_`:inherits(ClassName)` returns true if the passed Class is a subclass of the Object
  - _Class_`:made(instance)` returns true if the _instance_ implements the _Class_
  - _Class_`:cast(instance)` returns a casted Instance of Type _Class_ if _Class_ is
    either a sub or super class of that object or raises an error
  - _Class_`:trycast(instance)` does the same as cast but returns nil instead of raising an error
- Virtuality
  - When inheriting from Classes methods with the same name are stored within its own scope
  - using _Class_`:Virtual(methodName)` makes virtual (as in automatically overridden
    by subclass methods with the same name)
- Abstraction
  - Calling _Class_`:virtual(methodName)` without _Class_`:methodName()` being defined marks methodName as abstract
  - Calling an abstract method raises an error that you failed to implement the abstract method

### Lua-Events
  - Control Events:
    - `__tostring` defining this overrides the default ToString behavior e.g.: much like in C#
  - Mathematic operator Events:
    - `__unm` Unary Minus "Negation" - called when e.g. `myobj = -myobj`
    - `__add` Addition - called when `myobj + myobj2` | (Left side is checked for `__add` function first)
    - `__sub` Subtraction - called when `myobj - myobj2`| (Left side is checked for `__sub` function first)
    - `__mul` Multiplication - called when `myobj * myobj2`| (Left side is checked for `__mul` function first)
    - `__div` Division - called when `myobj / myobj2`| (Left side is checked for `__div` function first)
    - `__mod` Modulo - called when `myobj % myobj2`| (Left side is checked for `__mod` function first)
    - `__pow` Involution - called when `myobj ^ myobj2`| (Left side is checked for `__pow` function first)
    - `__concat` Concatenation - called when `myobj .. myobj2`| (Left side is checked for `__concat` function first)
  - Equivalency operators
    - Binary Operator that are only called when both sides point to the same function
    - `__eq` Equality - called when `myobj == myobj2`
    - `__lt` "Less Than" - called when `myobj < myobj2` | also called when `myobj > myobj2` by inversing the parameters
    - `__le` "Less Equal" - called when `myobj <= myobj2` | also called when `myobj >= myobj2` by inversing the parameters

### Credits

Credits go to Julien Patte for the regular LUA implementation at https://github.com/jpatte/yaci.lua.

See `yaci-1.2.0.lua`'s header for more information.
