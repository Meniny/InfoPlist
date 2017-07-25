## Introduction

`InfoPlist` is a Info.plist assistant for Cocoa/Cocoa Touch.

## Requirements

* iOS 8.0+
* watchOS 2.0+
* tvOS 9.0+
* macOS 10.10+
* Xcode 8 with Swift 3

## Installation

#### CocoaPods

```ruby
use_frameworks!
pod 'InfoPlist'
```

## Usage

```swift
import InfoPlist
```

```swift
let infoDictionary = InfoPlist.dictionary // [String: Any]?

_ = InfoPlist.getStringValue(forKey: "CFBundleDisplayName") // String?
_ = InfoPlist.getStringValue(forKey: "CFBundleVersion") // String
_ = InfoPlist.getBool(forKey: "UIStatusBarHidden") // Bool

_ = InfoPlist.isStatusBarHidden // Bool
_ = InfoPlist.iTunesFileSharingEnabled // Bool
_ = InfoPlist.cameraUsageDescription // String?
```
