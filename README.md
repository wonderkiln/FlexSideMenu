# WKAwesomeMenu

Initial project for the WonderKiln Side Menu that is used throughout our projects.

#### Origins
This was originally a forked copy of https://github.com/Friend-LGA/LGSideMenuController -- however due to planned changes and extensive usage we are running it as an independent repository.

## Preview

<img src="https://raw.githubusercontent.com/wonderkiln/WKAwesomeMenu/master/Demo/demo.gif" width="300"/>

## Installation

### With CocoaPods

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. To install with cocoaPods, follow the "Get Started" section on [CocoaPods](https://cocoapods.org/).

#### Podfile
```ruby
pod 'WKAwesomeMenu'
```

## Usage

In the source files where you need to use the library, import the header file:

```swift
import WKAwesomeMenu
```

### Initialization

```swift
let options = WKAwesomeMenuOptions.defaultOptions()
WKAwesomeMenu(rootViewController: rootVC, menuViewController: menuVC, options: options)
```

### Options

```swift
var backgroundImage: UIImage?
var cornerRadius: CGFloat
var shadowColor: UIColor
var shadowOffset: CGPoint
var shadowScale: CGFloat
var rootScale: CGFloat
var menuWidth: CGFloat
var menuParallax: CGFloat
var menuGripWidth: CGFloat
```
