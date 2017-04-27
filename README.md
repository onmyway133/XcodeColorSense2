# MainThreadGuard
Tracking UIKit access on main thread

[![Version](https://img.shields.io/cocoapods/v/MainThreadGuard.svg?style=flat)](http://cocoapods.org/pods/MainThreadGuard)
[![License](https://img.shields.io/cocoapods/l/MainThreadGuard.svg?style=flat)](http://cocoapods.org/pods/MainThreadGuard)
[![Platform](https://img.shields.io/cocoapods/p/MainThreadGuard.svg?style=flat)](http://cocoapods.org/pods/MainThreadGuard)
![Swift](https://img.shields.io/badge/%20in-swift%203.0-orange.svg)

![](Screenshots/Banner.png)

## Description

This is just a Swift port of [PSPDFUIKitMainThreadGuard.m](https://gist.github.com/steipete/5664345) using swizzling on `UIView` extension

## Usage

Call `Guard.setup` 

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
  // setup

  Guard.setup()

  return true
}
```

## Features

- setNeedsLayout
- setNeedsDisplay
- setNeedsDisplayInRect:

Try accessing UIKit from another thread and MainThreadGuard will assert

```swift
class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white

    let label = UILabel()
    view.addSubview(label)

    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
      label.text = "Setting text on background thread"
    }
  }
}
```

## Installation

MainThreadGuard is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

You should add this to Debug configuration only

```ruby
pod "MainThreadGuard", git: 'https://github.com/onmyway133/MainThreadGuard', configurations: 'Debug'
```

## Author

Khoa Pham, onmyway133@gmail.com

## License

MainThreadGuard is available under the MIT license. See the LICENSE file for more info.
